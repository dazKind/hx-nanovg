package;

import hxnanovg.Nvg;
import snow.App;
import snow.assets.Assets;
import snow.input.Input;
import snow.render.opengl.GL;
import snow.Snow;
import snow.types.Types;

using cpp.NativeString;

@:buildXml("&<include name='${haxelib:hx-nanovg}/Build.xml'/>")
class Main extends snow.App {

	var font:Int;
    var vg:cpp.Pointer<NvgContext>;
    var linearGradient:NvgPaint;

	public function new() super();

	override function ready() {

        trace(GL.versionString());

        app.window.onrender = onrender;
        this.render_rate = 1/9001;

        vg = Nvg.createGL(NvgMode.ANTIALIAS);
        font = Nvg.createFont(vg, "arial".c_str(), "assets/arial.ttf".c_str());
        linearGradient = Nvg.linearGradient(vg, 0, 0, 500, 500, Nvg.rgba(255,192,0,255), Nvg.rgba(0,0,0,255));
    }

    function onrender( window:snow.window.Window ) {
    	GL.viewport (0, 0, window.width, window.height);
        GL.clearColor (0.3, 0.3, 0.3, 1.0);
        GL.clear (GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT | GL.STENCIL_BUFFER_BIT);

        Nvg.beginFrame(vg, window.width, window.height, 1.0);

        Nvg.rect(vg, 100,100, 500,300);
        Nvg.circle(vg, 120,120, 250);
        Nvg.pathWinding(vg, NvgSolidity.HOLE);   // Mark circle as a hole.
        Nvg.fillPaint(vg, linearGradient);
        Nvg.fill(vg);
        
        Nvg.fontFaceId(vg, font);
        Nvg.fillColor(vg, Nvg.rgba(255,0,0,255));
        Nvg.text(vg, 50, 50, untyped "This is some text", untyped null);

        Nvg.fontSize(vg, 100.0);
        Nvg.fontFaceId(vg, font);
        Nvg.fillColor(vg, Nvg.rgba(255,255,255,64));
        Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT|NvgAlign.ALIGN_MIDDLE);
        Nvg.text(vg, 100, 100, untyped "Some other text!", untyped null);

        Nvg.endFrame(vg);

    }

    override function config( config:AppConfig ) : AppConfig {

        if(config.runtime.window != null) {
            if(config.runtime.window.width != null) {
                config.window.width = Std.int(config.runtime.window.width);
            }
            if(config.runtime.window.height != null) {
                config.window.height = Std.int(config.runtime.window.height);
            }
            if(config.runtime.window.vsync != null) {
                this.app.windowing.enable_vsync(config.runtime.window.vsync);
            }
        }

            //request minimum version
        config.render.opengl.major = 3;
        config.render.opengl.minor = 0;
        config.render.opengl.profile = OpenGLProfile.core;

        config.render.antialiasing = 16;
        config.render.stencil_bits = 8;
        config.render.depth_bits = 24;

        return config;
    }
}