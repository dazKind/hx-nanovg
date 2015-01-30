package;

import hxnanovg.Nvg;
import lime.app.Application;
import lime.graphics.opengl.GL;
import lime.graphics.RenderContext;
import lime.graphics.GLRenderContext;

using cpp.NativeString;

@:buildXml("&<include name='${haxelib:hx-nanovg}/Build.xml'/>")
class Main extends Application
{
    private var ctx:GLRenderContext;

    var vg:cpp.Pointer<NvgContext>;
    var linearGradient:NvgPaint;
    var font:Int;

    public function new()
    {
        super();
    }

    public override function init(context:RenderContext):Void
    {
        updateSavedContext(context);

        vg = Nvg.createGL(NvgMode.ANTIALIAS);
        font = Nvg.createFont(vg, "arial".c_str(), "assets/times.ttf".c_str());
        linearGradient = Nvg.linearGradient(vg, 0, 0, 500, 500, Nvg.rgba(255, 192, 0, 255), Nvg.rgba(0, 0, 0, 255));
    }

    public override function render(context:RenderContext):Void
    {
        updateSavedContext(context);

        GL.viewport(0, 0, config.width, config.height);
        GL.clearColor(0.3, 0.3, 0.3, 1.0);
        GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT | GL.STENCIL_BUFFER_BIT);

        Nvg.beginFrame(vg, 800, 600, 1.0);
		
        Nvg.rect(vg, 100, 100, 500, 300);
        Nvg.circle(vg, 120, 120, 250);
        Nvg.pathWinding(vg, NvgSolidity.HOLE); // Mark circle as a hole.
        Nvg.fillPaint(vg, linearGradient);
        Nvg.fill(vg);
		
//*
		Nvg.fontSize(vg, 30.0);
        Nvg.fontFaceId(vg, font);
        Nvg.fillColor(vg, Nvg.rgba(255, 0, 0, 255));
        Nvg.text(vg, 50, 50, "This is some text: اقتصادية".c_str(), untyped __cpp__("NULL"));

        Nvg.fontSize(vg, 100.0);
        Nvg.fontFaceId(vg, font);
        Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 64));
        Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
        Nvg.text(vg, 100, 100, "Some other text!".c_str(), untyped __cpp__("NULL"));
//*/
		Nvg.closePath(vg);
		
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, 0, 400);
		Nvg.bezierTo(vg, 50, 100, 300, 600, 400, 50);
		Nvg.strokeWidth(vg, 2);
		Nvg.strokeColor(vg, Nvg.rgba(0, 255, 255, 255));
		Nvg.stroke(vg);
		
        Nvg.endFrame(vg);
    }


    function updateSavedContext(context:RenderContext):Void
    {
        switch(context)
        {
            case RenderContext.OPENGL(gl): ctx = gl;
            default: null;
        }
    }
}