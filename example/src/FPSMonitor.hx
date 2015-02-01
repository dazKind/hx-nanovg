package;

import cpp.Pointer;
import cpp.Char;
import cpp.ConstPointer;
import cpp.Pointer;
import hxnanovg.Nvg;

import haxe.Timer;

using cpp.NativeString;

/**
 * ...
 * @author Hortobágyi Tamás
 */
class FPSMonitor
{
	private var vg:Pointer<NvgContext>;
	
	private var fontID:Int = 0;
	
	private var prevTime:Float;
	private var times:Array<Float> = [];
	/** Calculate the average time **/
	private var maxTimeCount:Int = 100;
	
	public function new(vg:Pointer<NvgContext>, fontID:Int) 
	{
		this.vg = vg;
		this.fontID = fontID;
		
		prevTime = Timer.stamp();
	}
	
	public function render()
	{
		times.push(Timer.stamp() - prevTime);
		prevTime = Timer.stamp();
		// if we hase enough data, remove the first data
		if (times.length > maxTimeCount) times.shift();
		
		var time:Float = 0.0;
		for (i in 0 ... times.length) time += times[i];
		time /= times.length;
		
		var fps:Float = Math.fround(100.0 / time) / 100.0;
		time = Math.fround(time * 100000) / 100.0;
		
		var x:Float = 5, y:Float = 5;
		var w:Float = 220, h:Float = 35;
		
		// base
		Nvg.beginPath(vg);
		Nvg.rect(vg, x, y, w, h);
		Nvg.fillColor(vg, Nvg.rgba(0, 0, 0, 128));
		Nvg.fill(vg);
		
		// graph
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, x, y + h);
		for (i in 0 ... times.length)
		{
			var v:Float = times[i] * 1000.0;
			if (v > 30.0) v = 30.0;
			var vx:Float = x + cast(w * i, Float) / cast(maxTimeCount, Float);
			var vy:Float = y + h - (v / 30.0) * h;
			Nvg.lineTo(vg, vx, vy);
		}
		Nvg.lineTo(vg, x + w * times.length / maxTimeCount, y + h);
		Nvg.fillColor(vg, Nvg.rgba(255, 192, 0, 128));
		Nvg.fill(vg);
		
		// values
		Nvg.fontSize(vg, 18);
		Nvg.fontFaceId(vg, fontID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 192));
		Nvg.textAlign(vg, NvgAlign.ALIGN_RIGHT | NvgAlign.ALIGN_TOP);
		Nvg.text(vg, x + w - 3, y, (Std.string(fps) + " FPS").c_str(), untyped __cpp__("NULL"));
		
		Nvg.fontSize(vg, 14);
		Nvg.fontFaceId(vg, fontID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 192));
		Nvg.textAlign(vg, NvgAlign.ALIGN_RIGHT | NvgAlign.ALIGN_BOTTOM);
		Nvg.text(vg, x + w - 3, y + h - 3, (Std.string(time) + " ms").c_str(), untyped __cpp__("NULL"));
	}
}