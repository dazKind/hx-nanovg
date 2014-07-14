package;

import lime.gl.GL;
import hxnanovg.Nvg;
import lime.Lime;

using cpp.NativeString;

@:buildXml("&<include name='${haxelib:hx-nanovg}/Build.xml'/>")
class Demo {

    private var lime:Lime;

    var vg:cpp.Pointer<NvgContext>;
    var font:Int;
    var linearGradient:NvgPaint;

    public function new () {}

    public function ready (lime:Lime):Void {
        this.lime = lime;

        vg = Nvg.createGL(NvgMode.ANTIALIAS);
        font = Nvg.createFont(vg, "arial".c_str(), "assets/arial.ttf".c_str());
        linearGradient = Nvg.linearGradient(vg, 0, 0, 500, 500, Nvg.rgba(255,192,0,255), Nvg.rgba(0,0,0,255));
    }
    private function render ():Void {

        GL.viewport (0, 0, lime.config.width, lime.config.height);
        GL.clearColor (0.3, 0.3, 0.3, 1.0);
        GL.clear (GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT | GL.STENCIL_BUFFER_BIT);

        Nvg.beginFrame(vg, 800, 600, 1.0);

        Nvg.rect(vg, 100,100, 500,300);
        Nvg.circle(vg, 120,120, 250);
        Nvg.pathWinding(vg, NvgSolidity.HOLE);   // Mark circle as a hole.
        Nvg.fillPaint(vg, linearGradient);
        Nvg.fill(vg);
        
        Nvg.fontFaceId(vg, font);
        Nvg.fillColor(vg, Nvg.rgba(255,0,0,255));
        Nvg.text(vg, 50, 50, "This is some text".c_str(), untyped __cpp__("NULL"));

        Nvg.fontSize(vg, 100.0);
        Nvg.fontFaceId(vg, font);
        Nvg.fillColor(vg, Nvg.rgba(255,255,255,64));
        Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT|NvgAlign.ALIGN_MIDDLE);
        Nvg.text(vg, 100, 100, "Some other text!".c_str(), untyped __cpp__("NULL"));

        Nvg.endFrame(vg);
    }
}
