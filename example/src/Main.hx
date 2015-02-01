package;

import cpp.Pointer;
import hxnanovg.Nvg;
import lime.app.Application;
import lime.graphics.opengl.GL;
import lime.graphics.RenderContext;
import lime.graphics.GLRenderContext;

using cpp.NativeString;


/**
 * ...
 * @author Thomas Hortobágyi
 */

@:buildXml("&<include name='${haxelib:hx-nanovg}/Build.xml'/>")

class Main extends Application 
{
    private var ctx:GLRenderContext;

    private var _vg:Pointer<NvgContext>;
	/** the original NanoVG example, ported to Haxe **/
	private var demo:Demo;
	/** "performance" monitor **/
	private var fpsMonitor:FPSMonitor;
	/** trace **/
	private var dbgTrace:DbgTrace;
	
	public var mouseX:Float = 0;
	public var mouseY:Float = 0;
	
	public var blowup:Int = 0;
	
	public function new() 
	{
		super();
	}
	
	public override function init(context:RenderContext):Void 
	{
        updateSavedContext(context);
		
		_vg = Nvg.createGL(NvgMode.ANTIALIAS);
		
		demo = new Demo(_vg);
		
		dbgTrace = new DbgTrace(demo.fontSansID);
		fpsMonitor = new FPSMonitor(_vg, demo.fontSansID);
	}
	
	public override function render(context:RenderContext):Void 
	{
		updateSavedContext(context);
		
        GL.viewport(0, 0, this.window.width, this.window.height);
        GL.clearColor(0.3, 0.3, 0.32, 1.0);
        GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT | GL.STENCIL_BUFFER_BIT);
		
		Nvg.beginFrame(_vg, this.window.width, this.window.height, 1.0);
		
		demo.render(_vg, mouseX, mouseY, this.window.width, this.window.height, blowup);
		
		fpsMonitor.render();
		
		dbgTrace.render(_vg);
		
		Nvg.endFrame(_vg);
	}
	
	override public function onWindowClose():Void 
	{
		super.onWindowClose();
		
		demo.freeDemoData(_vg);
	}
	
	override public function onKeyUp(keyCode:Int, modifier:Int):Void 
	{
		super.onKeyUp(keyCode, modifier);
		
		//dbgTrace.log(Std.string(keyCode));
		
		switch (keyCode)
		{
			// SPACE
			case 32: blowup = 1 - blowup;
		}
	}
	
	override public function onMouseMove(x:Float, y:Float, button:Int):Void 
	{
		super.onMouseMove(x, y, button);
		
		mouseX = x;
		mouseY = y;
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
