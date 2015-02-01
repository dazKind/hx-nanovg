package;

import cpp.NativeArray;
import cpp.Pointer;
import cpp.Char;
import cpp.ConstPointer;
import cpp.Pointer;
import hxnanovg.Nvg;
import haxe.Utf8;
import cpp.Lib;

using cpp.NativeString;
//using cpp.NativeArray;

/**
 * ...
 * @author Thomas Hortobágyi
 */
class Demo
{
	public static inline var ICON_SEARCH:Int = 0x1F50D;
	public static inline var ICON_CIRCLED_CROSS:Int = 0x2716;
	public static inline var ICON_CHEVRON_RIGHT:Int = 0xE75E;
	public static inline var ICON_CHECK:Int = 0x2713;
	public static inline var ICON_LOGIN:Int = 0xE740;
	public static inline var ICON_TRASH:Int = 0xE729;
	
	public static inline function maxf(a:Float, b:Float):Float { return (a < b ? a : b); } 
	
	public static inline function clampf(a:Float, mn:Float, mx:Float):Float { return (a < mn ? mn : (a > mx ? mx : a)); } 
	
	public static inline function isBlack(col:Pointer<NvgColor>):Bool
	{
		return (col.ref.r == 0.0 && col.ref.g == 0.0 && col.ref.b == 0.0/* && col.ref.a == 0.0*/);
	}
	
	public static function cpToUTF8(cp:Int):String
	{
		var s:Utf8 = new Utf8();
		s.addChar(cp);
		
		return s.toString();
	}
	
	public var fontIconsID:Int;
	public var fontSansID:Int;
	public var fontSansBoldID:Int;	
	
	private var _t:Float = 0.0;
	
	private var images:Array<Int> = [];
	
	public function new(_vg:Pointer<NvgContext>) 
	{
		loadDemoData(_vg);
	}
	
	public function render(_vg:Pointer<NvgContext>, mx:Float, my:Float, width:Float, height:Float, blowup:Int)
	{
		drawEyes(_vg, width - 250, 50, 150, 100, mx, my, _t);
		drawParagraph(_vg, width - 450, 50, 150, 100, mx, my);
		drawGraph(_vg, 0, height / 2, width, height / 2, _t);
		drawColorwheel(_vg, width - 300, height - 300, 250.0, 250.0, _t);
		
		// Line joints
		drawLines(_vg, 120, height - 50, 600, 50, _t);
		
		// Line caps
		drawWidths(_vg, 10, 50, 30);
		
		// Line caps
		drawCaps(_vg, 10, 300, 30);
		
		//drawScissor(_vg, 50, height - 80, _t);
		
		Nvg.save(_vg);
		if (blowup != 0)
		{
			Nvg.rotate(_vg, Math.sin(_t * 0.3) * 5.0 / 180.0 * Math.PI);
			Nvg.scale(_vg, 2.0, 2.0);
		}
		
		// Widgets
		drawWindow(_vg, "Widgets `n Stuff", 50, 50, 300, 400);
		var x:Float = 60, y:Float = 95;
		drawSearchBox(_vg, "Search", x, y, 280, 25);
		y += 40;
		drawDropDown(_vg, "Effects", x, y, 280, 28);
		var popy:Float = y + 14;
		y += 45;
		
		// Form
		drawLabel(_vg, "Login", x,y, 280,20);
		y += 25;
		drawEditBox(_vg, "Email",  x,y, 280,28);
		y += 35;
		drawEditBox(_vg, "Password", x,y, 280,28);
		y += 38;
		drawCheckBox(_vg, "Remember me", x,y, 140,28);
		drawButton(_vg, ICON_LOGIN, "Sign in", x + 138, y, 140, 28, [0, 96, 128, 255]);
		y += 45;
		
		// Slider
		drawLabel(_vg, "Diameter", x, y, 280, 20);
		y += 25;
		var percent:Float = clampf(Math.cos(_t) * 1.5, 0, 1);
		var value:Float = Math.round(30000 * percent) / 100;
		var value_str:String = value == 0 ? "0.00" : Std.string(value);
		if (value_str.lastIndexOf(".") == -1) value_str += ".00";
		else if (value_str.lastIndexOf(".") == value_str.length - 2) value_str += "0";
		
		drawEditBoxNum(_vg, value_str, "px", x + 180, y, 100, 28);
		drawSlider(_vg, percent, x, y, 170, 28);
		y += 55;
		
		drawButton(_vg, ICON_TRASH, "Delete", x, y, 160, 28, [128, 16, 8, 255]);
		drawButton(_vg, 0, "Cancel", x + 170, y, 110, 28, [0, 0, 0, 0]);
		
		// Thumbnails box
		drawThumbnails(_vg, 365, popy - 30, 160, 300, _t);
		
		Nvg.restore(_vg);
		
		// increase the time
		_t += 0.01;
	}
	
	function drawWindow(vg:Pointer<NvgContext>, title:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		var cornerRadius:Float = 3.0;
		// drop shadow
		var shadowPaint:NvgPaint = Nvg.boxGradient(vg, x, y + 2, w, h, cornerRadius * 2, 10, Nvg.rgba(0, 0, 0, 128), Nvg.rgba(0, 0, 0, 0));
		// header
		var headerPaint:NvgPaint = Nvg.linearGradient(vg, x, y, x, y + 15, Nvg.rgba(255, 255, 255, 8), Nvg.rgba(0, 0, 0, 16));
		
		Nvg.save(vg);
		
		// window
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x, y, w, h, cornerRadius);
		Nvg.fillColor(vg, Nvg.rgba(28, 30, 34, 192));
		Nvg.fill(vg);
		
		// drop shadow
		Nvg.beginPath(vg);
		Nvg.rect(vg, x - 10, y - 10, w + 20, h + 30);
		Nvg.roundedRect(vg, x, y, w, h, cornerRadius);
		Nvg.pathWinding(vg, NvgSolidity.HOLE);
		Nvg.fillPaint(vg, shadowPaint);
		Nvg.fill(vg);
		
		// header
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 1, y + 1, w - 2, 30, cornerRadius - 1);
		Nvg.fillPaint(vg, headerPaint);
		Nvg.fill(vg);
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, x + 0.5, y + 0.5 + 30);
		Nvg.lineTo(vg, x + 0.5 + w - 1, y + 0.5 + 30);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 32));
		Nvg.stroke(vg);
		
		Nvg.fontSize(vg, 18.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.textAlign(vg, NvgAlign.ALIGN_CENTER | NvgAlign.ALIGN_MIDDLE);
		
		Nvg.fontBlur(vg, 2);
		Nvg.fillColor(vg, Nvg.rgba(0, 0, 0, 128));
		Nvg.text(vg, x + w / 2, y + 16 + 1, title.c_str(), untyped __cpp__("NULL"));
		
		Nvg.fontBlur(vg, 0);
		Nvg.fillColor(vg, Nvg.rgba(220, 220, 220, 160));
		Nvg.text(vg, x + w / 2, y + 16, title.c_str(), untyped __cpp__("NULL"));
		
		Nvg.restore(vg);
	}
	
	function drawSearchBox(vg:Pointer<NvgContext>, text:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		var bg:NvgPaint = Nvg.boxGradient(vg, x, y + 1.5, w, h, h / 2, 5, Nvg.rgba(0, 0, 0, 16), Nvg.rgba(0, 0, 0, 92));
		//var icon:String = "";
		var cornerRadius:Float = h / 2.0 - 1;

		// Edit
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x, y, w, h, cornerRadius);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		Nvg.fontSize(vg, h * 1.3);
		Nvg.fontFaceId(vg, fontIconsID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 64));
		Nvg.textAlign(vg, NvgAlign.ALIGN_CENTER | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + h * 0.55, y + h * 0.55, cpToUTF8(ICON_SEARCH).c_str(), untyped __cpp__("NULL"));

		Nvg.fontSize(vg, 20.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 32));

		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + h * 1.05, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));

		Nvg.fontSize(vg, h * 1.3);
		Nvg.fontFaceId(vg, fontIconsID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 32));
		Nvg.textAlign(vg, NvgAlign.ALIGN_CENTER | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + w - h * 0.55, y + h * 0.55, cpToUTF8(ICON_CIRCLED_CROSS).c_str(), untyped __cpp__("NULL"));
	}
	
	function drawDropDown(vg:Pointer<NvgContext>, text:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		var bg:NvgPaint = Nvg.linearGradient(vg, x, y, x, y + h, Nvg.rgba(255, 255, 255, 16), Nvg.rgba(0, 0, 0, 16));
		//var icon:String = "";
		var cornerRadius:Float = 4.0;

		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 1, y + 1, w - 2, h - 2, cornerRadius - 1);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);

		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 0.5, y + 0.5, w - 1, h - 1, cornerRadius - 0.5);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 48));
		Nvg.stroke(vg);

		Nvg.fontSize(vg, 20.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 160));
		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + h * 0.3, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));

		Nvg.fontSize(vg, h * 1.3);
		Nvg.fontFaceId(vg, fontIconsID);
		Nvg.fillColor(vg, Nvg.rgba(255,255,255,64));
		Nvg.textAlign(vg, NvgAlign.ALIGN_CENTER | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + w - h * 0.5, y + h * 0.5, cpToUTF8(ICON_CHEVRON_RIGHT).c_str(), untyped __cpp__("NULL"));
	}
	
	function drawLabel(vg:Pointer<NvgContext>, text:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		Nvg.fontSize(vg, 18.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 128));

		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));
	}
	
	function drawEditBoxBase(vg:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float):Void
	{
		var bg:NvgPaint = Nvg.boxGradient(vg, x + 1, y + 1 + 1.5, w - 2, h - 2, 3, 4, Nvg.rgba(255, 255, 255, 32), Nvg.rgba(32, 32, 32, 32));
		// Edit
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 1, y + 1, w - 2, h - 2, 4 - 1);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 0.5, y + 0.5, w - 1, h - 1, 4 - 0.5);
		Nvg.strokeColor(vg, Nvg.rgba(0,0,0,48));
		Nvg.stroke(vg);
	}
	
	function drawEditBox(vg:Pointer<NvgContext>, text:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		drawEditBoxBase(vg, x, y, w, h);
		
		Nvg.fontSize(vg, 20.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 64));
		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + h * 0.3, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));
	}

	function drawEditBoxNum(vg:Pointer<NvgContext>, text:String, units:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		drawEditBoxBase(vg, x, y, w, h);
		
		var uw:Float = Nvg.textBounds(vg, 0, 0, units.c_str(), untyped __cpp__("NULL"), untyped __cpp__("NULL"));
		
		Nvg.fontSize(vg, 18.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 64));
		Nvg.textAlign(vg, NvgAlign.ALIGN_RIGHT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + w - h * 0.3, y + h * 0.5, units.c_str(), untyped __cpp__("NULL"));
		
		Nvg.fontSize(vg, 20.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 128));
		Nvg.textAlign(vg, NvgAlign.ALIGN_RIGHT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + w - uw - h * 0.5, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));
	}	
	
	function drawCheckBox(vg:Pointer<NvgContext>, text:String, x:Float, y:Float, w:Float, h:Float):Void
	{
		var bg:NvgPaint = Nvg.boxGradient(vg, x + 1, y + Std.int(h * 0.5) - 9 + 1, 18, 18, 3, 3, Nvg.rgba(0, 0, 0, 32), Nvg.rgba(0, 0, 0, 92));
		
		Nvg.fontSize(vg, 18.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 160));
		
		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + 28, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));
		
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 1, y + Std.int(h * 0.5) - 9, 18, 18, 3);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		Nvg.fontSize(vg, 40);
		Nvg.fontFaceId(vg, fontIconsID);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 128));
		Nvg.textAlign(vg, NvgAlign.ALIGN_CENTER | NvgAlign.ALIGN_MIDDLE);
		Nvg.text(vg, x + 9 + 2, y + h * 0.5, cpToUTF8(ICON_CHECK).c_str(), untyped __cpp__("NULL"));
	}
	
	function drawButton(vg:Pointer<NvgContext>, preicon:Int, text:String, x:Float, y:Float, w:Float, h:Float, rgba:Array<Int>):Void
	{
		var col:NvgColor = Nvg.rgba(rgba[0], rgba[1], rgba[2], rgba[3]);
		
		var black:Bool = col.r == 0 && col.g == 0 && col.b == 0;
		
		var bg:NvgPaint = Nvg.linearGradient(vg, x, y, x, y + h, Nvg.rgba(255, 255, 255, black ? 16 : 32), Nvg.rgba(0, 0, 0, black ? 16 : 32));
		var cornerRadius:Float = 4.0;
		var tw:Float = 0, iw:Float = 0;
		
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 1, y + 1, w - 2, h - 2, cornerRadius - 1);
		if (!black)
		{
			Nvg.fillColor(vg, col);
			Nvg.fill(vg);
		}
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + 0.5, y + 0.5, w - 1, h - 1, cornerRadius - 0.5);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 48));
		Nvg.stroke(vg);

		Nvg.fontSize(vg, 20.0);
		Nvg.fontFaceId(vg, fontSansBoldID);
		tw = Nvg.textBounds(vg, 0, 0, text.c_str(), untyped __cpp__("NULL"), untyped __cpp__("NULL"));
		
		if (preicon != 0)
		{
			Nvg.fontSize(vg, h * 1.3);
			Nvg.fontFaceId(vg, fontIconsID);
			iw = Nvg.textBounds(vg, 0,0, cpToUTF8(preicon).c_str(), untyped __cpp__("NULL"), untyped __cpp__("NULL"));
			iw += h * 0.15;
		}
		
		if (preicon != 0)
		{
			Nvg.fontSize(vg, h * 1.3);
			Nvg.fontFaceId(vg, fontIconsID);
			Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 96));
			Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
			Nvg.text(vg, x + w * 0.5 - tw * 0.5 - iw * 0.75, y + h * 0.5, cpToUTF8(preicon).c_str(), untyped __cpp__("NULL"));
		}
		
		Nvg.fontSize(vg, 20.0);
		Nvg.fontFaceId(vg, fontSansBoldID);
		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_MIDDLE);
		Nvg.fillColor(vg, Nvg.rgba(0, 0, 0, 160));
		Nvg.text(vg, x + w * 0.5 - tw * 0.5 + iw * 0.25, y + h * 0.5 - 1, text.c_str(), untyped __cpp__("NULL"));
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 160));
		Nvg.text(vg, x + w * 0.5 - tw * 0.5 + iw * 0.25, y + h * 0.5, text.c_str(), untyped __cpp__("NULL"));
	}
	
	function drawSlider(vg:Pointer<NvgContext>, pos:Float, x:Float, y:Float, w:Float, h:Float):Void
	{
		var cy:Float = y + Std.int(h * 0.5);
		var kr:Float = Std.int(h * 0.25);
		
		Nvg.save(vg);
		
		// Slot
		var bg:NvgPaint = Nvg.boxGradient(vg, x, cy - 2 + 1, w, 4, 2, 2, Nvg.rgba(0, 0, 0, 32), Nvg.rgba(0, 0, 0, 128));
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x, cy - 2, w, 4, 2);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		// Knob Shadow
		bg = Nvg.radialGradient(vg, x + Std.int(pos * w), cy + 1, kr - 3, kr + 3, Nvg.rgba(0, 0, 0, 64), Nvg.rgba(0, 0, 0, 0));
		Nvg.beginPath(vg);
		Nvg.rect(vg, x + Std.int(pos * w) - kr - 5, cy - kr - 5, kr * 2 + 5 + 5, kr * 2 + 5 + 5 + 3);
		Nvg.circle(vg, x + Std.int(pos * w), cy, kr);
		Nvg.pathWinding(vg, NvgSolidity.HOLE);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		// Knob
		var knob:NvgPaint = Nvg.linearGradient(vg, x, cy - kr, x, cy + kr, Nvg.rgba(255, 255, 255, 16), Nvg.rgba(0, 0, 0, 16));
		Nvg.beginPath(vg);
		Nvg.circle(vg, x + Std.int(pos * w), cy, kr - 1);
		Nvg.fillColor(vg, Nvg.rgba(40, 43, 48, 255));
		Nvg.fill(vg);
		Nvg.fillPaint(vg, knob);
		Nvg.fill(vg);
		
		Nvg.beginPath(vg);
		Nvg.circle(vg, x + Std.int(pos * w), cy, kr - 0.5);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 92));
		Nvg.stroke(vg);
		
		Nvg.restore(vg);
	}
	
	function drawEyes(vg:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float, mx:Float, my:Float, t:Float):Void
	{
		var gloss:NvgPaint, bg:NvgPaint;
		
		var ex:Float = w * 0.23;
		var ey:Float = h * 0.5;
		var lx:Float = x + ex;
		var ly:Float = y + ey;
		var rx:Float = x + w - ex;
		var ry:Float = y + ey;
		var dx:Float,dy:Float,d:Float;
		var br:Float = (ex < ey ? ex : ey) * 0.5;
		var blink:Float = 1 - Math.pow(Math.sin(t * 0.5), 200) * 0.8;

		bg = Nvg.linearGradient(vg, x, y + h * 0.5, x + w * 0.1, y + h, Nvg.rgba(0, 0, 0, 32), Nvg.rgba(0, 0, 0, 16));
		Nvg.beginPath(vg);
		Nvg.ellipse(vg, lx + 3.0, ly + 16.0, ex, ey);
		Nvg.ellipse(vg, rx + 3.0, ry + 16.0, ex, ey);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);

		bg = Nvg.linearGradient(vg, x, y + h * 0.25, x + w * 0.1, y + h, Nvg.rgba(220, 220, 220, 255), Nvg.rgba(128, 128, 128, 255));
		Nvg.beginPath(vg);
		Nvg.ellipse(vg, lx, ly, ex, ey);
		Nvg.ellipse(vg, rx, ry, ex, ey);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		dx = (mx - rx) / (ex * 10);
		dy = (my - ry) / (ey * 10);
		d = Math.sqrt(dx * dx + dy * dy);
		if (d > 1.0)
		{
			dx /= d;
			dy /= d;
		}
		
		dx *= ex * 0.4;
		dy *= ey * 0.5;
		Nvg.beginPath(vg);
		Nvg.ellipse(vg, lx + dx, ly + dy + ey * 0.25 * (1 - blink), br, br * blink);
		Nvg.fillColor(vg, Nvg.rgba(32,32,32,255));
		Nvg.fill(vg);
		
		dx = (mx - rx) / (ex * 10);
		dy = (my - ry) / (ey * 10);
		d = Math.sqrt(dx * dx + dy * dy);
		if (d > 1.0)
		{
			dx /= d;
			dy /= d;
		}
		dx *= ex * 0.4;
		dy *= ey * 0.5;
		Nvg.beginPath(vg);
		Nvg.ellipse(vg, rx + dx, ry + dy + ey * 0.25 * (1 - blink), br, br * blink);
		Nvg.fillColor(vg, Nvg.rgba(32, 32, 32, 255));
		Nvg.fill(vg);
		
		gloss = Nvg.radialGradient(vg, lx - ex * 0.25, ly - ey * 0.5, ex * 0.1, ex * 0.75, Nvg.rgba(255, 255, 255, 128), Nvg.rgba(255, 255, 255, 0));
		Nvg.beginPath(vg);
		Nvg.ellipse(vg, lx, ly, ex, ey);
		Nvg.fillPaint(vg, gloss);
		Nvg.fill(vg);
		
		gloss = Nvg.radialGradient(vg, rx - ex * 0.25, ry - ey * 0.5, ex * 0.1, ex * 0.75, Nvg.rgba(255, 255, 255, 128), Nvg.rgba(255, 255, 255, 0));
		Nvg.beginPath(vg);
		Nvg.ellipse(vg, rx, ry, ex, ey);
		Nvg.fillPaint(vg, gloss);
		Nvg.fill(vg);
	}
	
	function drawGraph(vg:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float, t:Float):Void
	{
		var bg:NvgPaint;
		var samples:Array<Float> = [];
		var sx:Array<Float> = [], sy:Array<Float> = [];
		var dx:Float = w / 5.0;
		
		samples[0] = (1 + Math.sin(t * 1.2345 + Math.cos(t * 0.33457) * 0.44)) * 0.5;
		samples[1] = (1 + Math.sin(t * 0.68363 + Math.cos(t * 1.3) * 1.55)) * 0.5;
		samples[2] = (1 + Math.sin(t * 1.1642 + Math.cos(t * 0.33457) * 1.24)) * 0.5;
		samples[3] = (1 + Math.sin(t * 0.56345 + Math.cos(t * 1.63) * 0.14)) * 0.5;
		samples[4] = (1 + Math.sin(t * 1.6245 + Math.cos(t * 0.254) * 0.3)) * 0.5;
		samples[5] = (1 + Math.sin(t * 0.345 + Math.cos(t * 0.03) * 0.6)) * 0.5;

		for (i in 0 ... 6)
		{
			sx[i] = x + i * dx;
			sy[i] = y + h * samples[i] * 0.8;
		}
		
		// Graph background
		bg = Nvg.linearGradient(vg, x, y, x, y + h, Nvg.rgba(0, 160, 192, 0), Nvg.rgba(0, 160, 192, 64));
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, sx[0], sy[0]);
		for (i in 1 ... 6) Nvg.bezierTo(vg, sx[i - 1] + dx * 0.5, sy[i - 1], sx[i] - dx * 0.5, sy[i], sx[i], sy[i]);
		Nvg.lineTo(vg, x + w, y + h);
		Nvg.lineTo(vg, x, y + h);
		Nvg.fillPaint(vg, bg);
		Nvg.fill(vg);
		
		// Graph line
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, sx[0], sy[0] + 2);
		for (i in 1 ... 6) Nvg.bezierTo(vg, sx[i - 1] + dx * 0.5, sy[i - 1] + 2, sx[i] - dx * 0.5, sy[i] + 2, sx[i], sy[i] + 2);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 32));
		Nvg.strokeWidth(vg, 3.0);
		Nvg.stroke(vg);
		
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, sx[0], sy[0]);
		for (i in 1 ... 6) Nvg.bezierTo(vg, sx[i - 1] + dx * 0.5, sy[i - 1], sx[i] - dx * 0.5, sy[i], sx[i], sy[i]);
		Nvg.strokeColor(vg, Nvg.rgba(0, 160, 192, 255));
		Nvg.strokeWidth(vg, 3.0);
		Nvg.stroke(vg);
		
		// Graph sample pos
		for (i in 0 ... 6)
		{
			bg = Nvg.radialGradient(vg, sx[i], sy[i] + 2, 3.0, 8.0, Nvg.rgba(0, 0, 0, 32), Nvg.rgba(0, 0, 0, 0));
			Nvg.beginPath(vg);
			Nvg.rect(vg, sx[i] - 10, sy[i] - 10 + 2, 20, 20);
			Nvg.fillPaint(vg, bg);
			Nvg.fill(vg);
		}
		
		Nvg.beginPath(vg);
		for (i in 0 ... 6) Nvg.circle(vg, sx[i], sy[i], 4.0);
		Nvg.fillColor(vg, Nvg.rgba(0,160,192,255));
		Nvg.fill(vg);
		Nvg.beginPath(vg);
		for (i in 0 ... 6) Nvg.circle(vg, sx[i], sy[i], 2.0);
		Nvg.fillColor(vg, Nvg.rgba(220,220,220,255));
		Nvg.fill(vg);
		
		Nvg.strokeWidth(vg, 1.0);
	}
	
	function drawSpinner(vg:Pointer<NvgContext>, cx:Float, cy:Float, r:Float, t:Float):Void
	{
		var a0:Float = 0.0 + t * 6;
		var a1:Float = Math.PI + t * 6;
		var r0:Float = r;
		var r1:Float = r * 0.75;
		var ax:Float, ay:Float, bx:Float, by:Float;
		var paint:NvgPaint;
		
		Nvg.save(vg);
		
		Nvg.beginPath(vg);
		Nvg.arc(vg, cx, cy, r0, a0, a1, NvgWinding.CW);
		Nvg.arc(vg, cx, cy, r1, a1, a0, NvgWinding.CCW);
		Nvg.closePath(vg);
		ax = cx + Math.cos(a0) * (r0 + r1) * 0.5;
		ay = cy + Math.sin(a0) * (r0 + r1) * 0.5;
		bx = cx + Math.cos(a1) * (r0 + r1) * 0.5;
		by = cy + Math.sin(a1) * (r0 + r1) * 0.5;
		paint = Nvg.linearGradient(vg, ax, ay, bx, by, Nvg.rgba(0, 0, 0, 0), Nvg.rgba(0, 0, 0, 128));
		Nvg.fillPaint(vg, paint);
		Nvg.fill(vg);
		
		Nvg.restore(vg);
	}
	
	function drawThumbnails(vg:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float, /*images:ConstPointer<Int>, nimages:Int,*/ t:Float):Void
	{
		var cornerRadius:Float = 3.0;
		var shadowPaint:NvgPaint, imgPaint:NvgPaint, fadePaint:NvgPaint;
		var ix:Float, iy:Float, iw:Float, ih:Float;
		var thumb:Float = 60.0;
		var arry:Float = 30.5;
		var imgw:Int = 10, imgh:Int = 5;
		var stackh:Float = (images.length / 2) * (thumb + 10) + 10;
		
		var u:Float = (1 + Math.cos(t * 0.5)) * 0.5;
		var u2:Float = (1 - Math.cos(t * 0.2)) * 0.5;
		var scrollh:Float, dv:Float;

		Nvg.save(vg);
		
		// Drop shadow
		shadowPaint = Nvg.boxGradient(vg, x, y + 4, w, h, cornerRadius * 2, 20, Nvg.rgba(0, 0, 0, 128), Nvg.rgba(0, 0, 0, 0));
		Nvg.beginPath(vg);
		Nvg.rect(vg, x - 10, y - 10, w + 20, h + 30);
		Nvg.roundedRect(vg, x, y, w, h, cornerRadius);
		Nvg.pathWinding(vg, NvgSolidity.HOLE);
		Nvg.fillPaint(vg, shadowPaint);
		Nvg.fill(vg);
		
		// Window
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x, y, w, h, cornerRadius);
		Nvg.moveTo(vg, x - 10, y + arry);
		Nvg.lineTo(vg, x + 1, y + arry - 11);
		Nvg.lineTo(vg, x + 1, y + arry + 11);
		Nvg.fillColor(vg, Nvg.rgba(200, 200, 200, 255));
		Nvg.fill(vg);
		
		Nvg.save(vg);
		Nvg.scissor(vg, x, y, w, h);
		Nvg.translate(vg, 0, -(stackh - h) * u);
		
		dv = 1.0 / cast(images.length - 1.0, Float);
		
		var tx:Float, ty:Float, v:Float, a:Float;
		for (i in 0 ... images.length)
		{
			tx = x + 10;
			ty = y + 10;
			tx += (i % 2) * (thumb + 10);
			ty += (i / 2) * (thumb + 10);
			Nvg.imageSize(vg, images[i], Pointer.addressOf(imgw), Pointer.addressOf(imgh));
			if (imgw < imgh)
			{
				iw = thumb;
				ih = iw * cast(imgh, Float) / cast(imgw, Float);
				ix = 0;
				iy = -(ih - thumb) * 0.5;
			}
			else
			{
				ih = thumb;
				iw = ih * cast(imgw, Float) / cast(imgh, Float);
				ix = -(iw - thumb) * 0.5;
				iy = 0;
			}
			
			v = i * dv;
			a = clampf((u2 - v) / dv, 0, 1);
			
			if (a < 1.0) drawSpinner(vg, tx + thumb / 2, ty + thumb / 2, thumb * 0.25, t);
			
			imgPaint = Nvg.imagePattern(vg, tx + ix, ty + iy, iw, ih, 0.0 / 180.0 * Math.PI, images[i], a);
			Nvg.beginPath(vg);
			Nvg.roundedRect(vg, tx,ty, thumb,thumb, 5);
			Nvg.fillPaint(vg, imgPaint);
			Nvg.fill(vg);
			
			shadowPaint = Nvg.boxGradient(vg, tx - 1, ty, thumb + 2, thumb + 2, 5, 3, Nvg.rgba(0, 0, 0, 128), Nvg.rgba(0, 0, 0, 0));
			Nvg.beginPath(vg);
			Nvg.rect(vg, tx - 5, ty - 5, thumb + 10, thumb + 10);
			Nvg.roundedRect(vg, tx, ty, thumb, thumb, 6);
			Nvg.pathWinding(vg, NvgSolidity.HOLE);
			Nvg.fillPaint(vg, shadowPaint);
			Nvg.fill(vg);
			
			Nvg.beginPath(vg);
			Nvg.roundedRect(vg, tx + 0.5, ty + 0.5, thumb - 1, thumb - 1, 4 - 0.5);
			Nvg.strokeWidth(vg, 1.0);
			Nvg.strokeColor(vg, Nvg.rgba(255,255,255,192));
			Nvg.stroke(vg);
		}
		Nvg.restore(vg);
		
		// Hide fades
		fadePaint = Nvg.linearGradient(vg, x, y, x, y + 6, Nvg.rgba(200, 200, 200, 255), Nvg.rgba(200, 200, 200, 0));
		Nvg.beginPath(vg);
		Nvg.rect(vg, x + 4, y, w - 8, 6);
		Nvg.fillPaint(vg, fadePaint);
		Nvg.fill(vg);
		
		fadePaint = Nvg.linearGradient(vg, x, y + h, x, y + h - 6, Nvg.rgba(200, 200, 200, 255), Nvg.rgba(200, 200, 200, 0));
		Nvg.beginPath(vg);
		Nvg.rect(vg, x + 4, y + h - 6, w - 8, 6);
		Nvg.fillPaint(vg, fadePaint);
		Nvg.fill(vg);
		
		// Scroll bar
		shadowPaint = Nvg.boxGradient(vg, x + w - 12 + 1, y + 4 + 1, 8, h - 8, 3, 4, Nvg.rgba(0, 0, 0, 32), Nvg.rgba(0, 0, 0, 92));
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + w - 12, y + 4, 8, h - 8, 3);
		Nvg.fillPaint(vg, shadowPaint);
		Nvg.fill(vg);
		
		scrollh = (h / stackh) * (h - 8);
		shadowPaint = Nvg.boxGradient(vg, x + w - 12 - 1, y + 4 + (h - 8 - scrollh) * u - 1, 8, scrollh, 3, 4, Nvg.rgba(220, 220, 220, 255), Nvg.rgba(128, 128, 128, 255));
		Nvg.beginPath(vg);
		Nvg.roundedRect(vg, x + w - 12 + 1, y + 4 + 1 + (h - 8 - scrollh) * u, 8 - 2, scrollh - 2, 2);
		Nvg.fillPaint(vg, shadowPaint);
		Nvg.fill(vg);
		
		Nvg.restore(vg);
	}

	function drawColorwheel(vg:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float, t:Float):Void
	{
		var r0:Float, r1:Float, ax:Float, ay:Float, bx:Float, by:Float, cx:Float, cy:Float, aeps:Float, r:Float;
		var hue:Float = Math.sin(t * 0.12);
		var paint:NvgPaint;
		
		Nvg.save(vg);
		
		/*
		Nvg.beginPath(vg);
		Nvg.rect(vg, x,y,w,h);
		Nvg.fillColor(vg, Nvg.rgba(255,0,0,128));
		Nvg.fill(vg);
		//*/
		
		cx = x + w * 0.5;
		cy = y + h * 0.5;
		r1 = (w < h ? w : h) * 0.5 - 5.0;
		r0 = r1 - 20.0;
		aeps = 0.5 / r1; // half a pixel arc length in radians (2pi cancels out).
		
		for (i in 0 ... 6)
		{
			var a0:Float = i * Math.PI * 2.0 / 6.0 - aeps;
			var a1:Float = (i + 1.0) * Math.PI * 2.0 / 6.0 + aeps;
			
			Nvg.beginPath(vg);
			Nvg.arc(vg, cx,cy, r0, a0, a1, NvgWinding.CW);
			Nvg.arc(vg, cx,cy, r1, a1, a0, NvgWinding.CCW);
			Nvg.closePath(vg);
			
			ax = cx + Math.cos(a0) * (r0 + r1) * 0.5;
			ay = cy + Math.sin(a0) * (r0 + r1) * 0.5;
			bx = cx + Math.cos(a1) * (r0 + r1) * 0.5;
			by = cy + Math.sin(a1) * (r0 + r1) * 0.5;
			paint = Nvg.linearGradient(vg, ax, ay, bx, by, Nvg.hsla(a0 / (Math.PI * 2), 1.0, 0.55, 255), Nvg.hsla(a1 / (Math.PI * 2), 1.0, 0.55, 255));
			Nvg.fillPaint(vg, paint);
			Nvg.fill(vg);
		}

		Nvg.beginPath(vg);
		Nvg.circle(vg, cx, cy, r0 - 0.5);
		Nvg.circle(vg, cx, cy, r1 + 0.5);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 64));
		Nvg.strokeWidth(vg, 1.0);
		Nvg.stroke(vg);

		// Selector
		Nvg.save(vg);
		Nvg.translate(vg, cx, cy);
		Nvg.rotate(vg, hue * Math.PI * 2);

		// Marker on
		Nvg.strokeWidth(vg, 2.0);
		Nvg.beginPath(vg);
		Nvg.rect(vg, r0 - 1, -3, r1 - r0 + 2, 6);
		Nvg.strokeColor(vg, Nvg.rgba(255, 255, 255, 192));
		Nvg.stroke(vg);

		paint = Nvg.boxGradient(vg, r0 - 3, -5, r1 - r0 + 6, 10, 2, 4, Nvg.rgba(0, 0, 0, 128), Nvg.rgba(0, 0, 0, 0));
		Nvg.beginPath(vg);
		Nvg.rect(vg, r0 - 2 - 10, -4 - 10, r1 - r0 + 4 + 20, 8 + 20);
		Nvg.rect(vg, r0 - 2, -4, r1 - r0 + 4, 8);
		Nvg.pathWinding(vg, NvgSolidity.HOLE);
		Nvg.fillPaint(vg, paint);
		Nvg.fill(vg);

		// Center triangle
		r = r0 - 6;
		ax = Math.cos(120.0 / 180.0 * Math.PI) * r;
		ay = Math.sin(120.0 / 180.0 * Math.PI) * r;
		bx = Math.cos( -120.0 / 180.0 * Math.PI) * r;
		by = Math.sin( -120.0 / 180.0 * Math.PI) * r;
		Nvg.beginPath(vg);
		Nvg.moveTo(vg, r, 0);
		Nvg.lineTo(vg, ax, ay);
		Nvg.lineTo(vg, bx, by);
		Nvg.closePath(vg);
		paint = Nvg.linearGradient(vg, r, 0, ax, ay, Nvg.hsla(hue, 1.0, 0.5, 255), Nvg.rgba(255, 255, 255, 255));
		Nvg.fillPaint(vg, paint);
		Nvg.fill(vg);
		paint = Nvg.linearGradient(vg, (r + ax) * 0.5, (0 + ay) * 0.5, bx, by, Nvg.rgba(0, 0, 0, 0), Nvg.rgba(0, 0, 0, 255));
		Nvg.fillPaint(vg, paint);
		Nvg.fill(vg);
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 64));
		Nvg.stroke(vg);

		// Select circle on triangle
		ax = Math.cos(120.0 / 180.0 * Math.PI) * r * 0.3;
		ay = Math.sin(120.0 / 180.0 * Math.PI) * r * 0.4;
		Nvg.strokeWidth(vg, 2.0);
		Nvg.beginPath(vg);
		Nvg.circle(vg, ax, ay, 5);
		Nvg.strokeColor(vg, Nvg.rgba(255, 255, 255, 192));
		Nvg.stroke(vg);

		paint = Nvg.radialGradient(vg, ax, ay, 7, 9, Nvg.rgba(0, 0, 0, 64), Nvg.rgba(0, 0, 0, 0));
		Nvg.beginPath(vg);
		Nvg.rect(vg, ax - 20, ay - 20, 40, 40);
		Nvg.circle(vg, ax, ay, 7);
		Nvg.pathWinding(vg, NvgSolidity.HOLE);
		Nvg.fillPaint(vg, paint);
		Nvg.fill(vg);
		
		Nvg.restore(vg);
		
		Nvg.restore(vg);
	}
	
	function drawLines(vg:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float, t:Float):Void
	{
		var pad:Float = 5.0, s:Float = w / 9.0 - pad * 2;
		var pts:Array<Float> = [], fx:Float, fy:Float;
		var joins:Array<Int> = [NvgLineCap.MITER, NvgLineCap.ROUND, NvgLineCap.BEVEL];
		var caps:Array<Int> = [NvgLineCap.BUTT, NvgLineCap.ROUND, NvgLineCap.SQUARE];
		
		Nvg.save(vg);
		pts[0] = -s * 0.25 + Math.cos(t * 0.3) * s * 0.5;
		pts[1] = Math.sin(t * 0.3) * s * 0.5;
		pts[2] = -s * 0.25;
		pts[3] = 0;
		pts[4] = s * 0.25;
		pts[5] = 0;
		pts[6] = s * 0.25 + Math.cos( -t * 0.3) * s * 0.5;
		pts[7] = Math.sin( -t * 0.3) * s * 0.5;
		
		for (i in 0 ... 3)
		{
			for (j in 0 ... 3)
			{
				fx = x + s * 0.5 + (i * 3 + j) / 9.0 * w + pad;
				fy = y - s * 0.5 + pad;
				
				Nvg.lineCap(vg, caps[i]);
				Nvg.lineJoin(vg, joins[j]);
				
				Nvg.strokeWidth(vg, s * 0.3);
				Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 160));
				Nvg.beginPath(vg);
				Nvg.moveTo(vg, fx + pts[0], fy + pts[1]);
				Nvg.lineTo(vg, fx + pts[2], fy + pts[3]);
				Nvg.lineTo(vg, fx + pts[4], fy + pts[5]);
				Nvg.lineTo(vg, fx + pts[6], fy + pts[7]);
				Nvg.stroke(vg);
				
				Nvg.lineCap(vg, NvgLineCap.BUTT);
				Nvg.lineJoin(vg, NvgLineCap.BEVEL);
				
				Nvg.strokeWidth(vg, 1.0);
				Nvg.strokeColor(vg, Nvg.rgba(0, 192, 255, 255));
				Nvg.beginPath(vg);
				Nvg.moveTo(vg, fx + pts[0], fy + pts[1]);
				Nvg.lineTo(vg, fx + pts[2], fy + pts[3]);
				Nvg.lineTo(vg, fx + pts[4], fy + pts[5]);
				Nvg.lineTo(vg, fx + pts[6], fy + pts[7]);
				Nvg.stroke(vg);
			}
		}
		
		Nvg.restore(vg);
	}
	
	function loadDemoData(vg:Pointer<NvgContext>):Int
	{
		if (vg == untyped __cpp__("NULL")) return -1;
		// fonts - if any fontID == -1, then error occured
		fontIconsID = Nvg.createFont(vg, "icon".c_str(), "assets/entypo.ttf".c_str());
		fontSansID = Nvg.createFont(vg, "sans".c_str(), "assets/Roboto-Regular.ttf".c_str());
		fontSansBoldID = Nvg.createFont(vg, "sans-bold".c_str(), "assets/Roboto-Bold.ttf".c_str());
		
		for (i in 0 ... 12)
		{
			images[i] = Nvg.createImage(vg, ("assets/images/image" + (i + 1) + ".jpg").c_str(), 0);
			if (images[i] == 0)
			{
				Lib.print("Could not load: image" + (i + 1));
				return -1;
			}
		}
		
		return 0;
	}
	
	public function freeDemoData(vg:Pointer<NvgContext>):Void
	{
		if (vg == untyped __cpp__("NULL")) return;
		
		for (i in 0 ... images.length) Nvg.deleteImage(vg, images[i]);
	}
	
	function drawParagraph(vg:Pointer<NvgContext>, x:Float, y:Float, width:Float, height:Float, mx:Float, my:Float):Void
	{
		untyped __cpp__("NVGtextRow rows[3];");
		untyped __cpp__("NVGglyphPosition glyphs[100];");
		
		untyped __cpp__('const char* text = "This is longer chunk of text.\\n  \\n  Would have used lorem ipsum but she    was busy jumping over the lazy dog with the fox and all the men who came to the aid of the party.";');
		
		untyped __cpp__("const char* start;");
		untyped __cpp__("const char* end;");
		
		var nrows:Int, nglyphs:Int, lnum:Int = 0;
		var lineh:Float = 1.0;
		untyped __cpp__("float lineheight;");
		var caretx:Float, px:Float;
		untyped __cpp__ ("float bounds[4];");
		
		var a:Float;
		var gx:Float = 0, gy:Float = 0;
		var gutter:Int = 0;
		
		var index:Int = 0;
		
		Nvg.save(vg);
		
		Nvg.fontSize(vg, 18.0);
		Nvg.fontFaceId(vg, fontSansID);
		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_TOP);
		Nvg.textMetrics(vg, untyped __cpp__("NULL"), untyped __cpp__("NULL"),  untyped __cpp__("&lineheight"));
		
		// The text break API can be used to fill a large buffer of rows,
		// or to iterate over the text just few lines (or just one) at a time.
		// The "next" variable of the last returned item tells where to continue.
		untyped __cpp__("start = text; end = text + strlen(text);");
		
		lineh = untyped __cpp__("lineheight");
		
		while ((nrows = Nvg.textBreakLines(vg, untyped __cpp__("start"), untyped __cpp__("end"), width, untyped __cpp__("rows"), 3)) > 0)
		{
			for (i in 0 ... nrows)
			{
				var row:NvgTextRow = untyped __cpp__("rows[i]");//rows[i];
				
				var hit:Bool = mx > x && mx < (x + width) && my >= y && my < (y + lineh);
				
				Nvg.beginPath(vg);
				Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, hit ? 64 : 16));
				Nvg.rect(vg, x, y, row.width, lineh);
				Nvg.fill(vg);
				
				Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 255));
				Nvg.text(vg, x, y, row.start, row.end);
				
				if (hit)
				{
					caretx = (mx < x + row.width / 2) ? x : x + row.width;
					px = x;
					nglyphs = Nvg.textGlyphPositions(vg, x, y, row.start, row.end, untyped __cpp__("glyphs"), 100);
					for (j in 0 ... nglyphs)
					{
						var glp:NvgGlyphPosition = untyped __cpp__("glyphs[j]");
						var x0:Float = glp.x;
						
						var x1:Float = x + row.width;
						if (j + 1 < nglyphs)
						{
							glp = untyped __cpp__("glyphs[j+1]");
							x1 = glp.x;
						}
						
						var gx:Float = x0 * 0.3 + x1 * 0.7;
						if (mx >= px && mx < gx)
						{
							glp = untyped __cpp__("glyphs[j]");
							caretx = glp.x;
						}
						px = gx;
					}
					
					Nvg.beginPath(vg);
					Nvg.fillColor(vg, Nvg.rgba(255, 192, 0, 255));
					Nvg.rect(vg, caretx, y, 1, lineh);
					Nvg.fill(vg);
					
					gutter = lnum + 1;
					gx = x - 10;
					gy = y + lineh / 2;
				}
				
				lnum++;
				y += lineh;
			}
			
			// Keep going...
			untyped __cpp__("start = rows[nrows-1].next");
		}
		
		if (gutter != 0)
		{
			var txt:String = Std.string(gutter);
			
			Nvg.fontSize(vg, 13.0);
			Nvg.textAlign(vg, NvgAlign.ALIGN_RIGHT | NvgAlign.ALIGN_MIDDLE);
			
			Nvg.textBounds(vg, gx, gy, txt.c_str(), untyped __cpp__("NULL"), untyped __cpp__ ("bounds"));
			
			Nvg.beginPath(vg);
			Nvg.fillColor(vg, Nvg.rgba(255, 192, 0, 255));
			Nvg.roundedRect(vg, Std.int(untyped __cpp__ ("bounds[0]") - 4), Std.int(untyped __cpp__ ("bounds[1]") - 2),
							Std.int(untyped __cpp__ ("bounds[2]") - untyped __cpp__ ("bounds[0]")) + 8,
							Std.int(untyped __cpp__ ("bounds[3]") - untyped __cpp__ ("bounds[1]")) + 4,
							(Std.int(untyped __cpp__ ("bounds[3]") - untyped __cpp__ ("bounds[1]")) + 4) / 2 - 1);
			Nvg.fill(vg);
			
			Nvg.fillColor(vg, Nvg.rgba(32, 32, 32, 255));
			Nvg.text(vg, gx, gy, txt.c_str(), untyped __cpp__("NULL"));
		}
		
		y += 20.0;
		
		Nvg.fontSize(vg, 13.0);
		Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_TOP);
		Nvg.textLineHeight(vg, 1.2);

		Nvg.textBoxBounds(vg, x, y, 150, "Hover your mouse over the text to see calculated caret position.".c_str(), untyped __cpp__("NULL"), untyped __cpp__ ("bounds"));

		// Fade the tooltip out when close to it.
		gx = Math.abs((mx - (untyped __cpp__ ("bounds[0]") + untyped __cpp__ ("bounds[2]")) * 0.5) / (untyped __cpp__ ("bounds[0]") - untyped __cpp__ ("bounds[2]")));
		gy = Math.abs((my - (untyped __cpp__ ("bounds[1]") + untyped __cpp__ ("bounds[3]")) * 0.5) / (untyped __cpp__ ("bounds[1]") - untyped __cpp__ ("bounds[3]")));
		a = maxf(gx, gy) - 0.5;
		a = clampf(a, 0, 1);
		Nvg.globalAlpha(vg, a);
		
		Nvg.beginPath(vg);
		Nvg.fillColor(vg, Nvg.rgba(220, 220, 220, 255));
		Nvg.roundedRect(vg, untyped __cpp__ ("bounds[0]") - 2, untyped __cpp__ ("bounds[1]") - 2, Std.int(untyped __cpp__ ("bounds[2]") - untyped __cpp__ ("bounds[0]")) + 4, Std.int(untyped __cpp__ ("bounds[3]") - untyped __cpp__ ("bounds[1]")) + 4, 3);
		px = Std.int((untyped __cpp__ ("bounds[2]") + untyped __cpp__ ("bounds[0]")) / 2);
		Nvg.moveTo(vg, px, untyped __cpp__ ("bounds[1]") - 10);
		Nvg.lineTo(vg, px + 7, untyped __cpp__ ("bounds[1]") + 1);
		Nvg.lineTo(vg, px - 7, untyped __cpp__ ("bounds[1]") + 1);
		Nvg.fill(vg);
		
		Nvg.fillColor(vg, Nvg.rgba(0, 0, 0, 220));
		Nvg.textBox(vg, x,y, 150, "Hover your mouse over the text to see calculated caret position.".c_str(), untyped __cpp__("NULL"));
		
		Nvg.restore(vg);
	}
	
	function drawWidths(vg:Pointer<NvgContext>, x:Float, y:Float, width:Float):Void
	{
		Nvg.save(vg);
		
		Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 255));
		
		var w:Float;
		
		for (i in 0 ... 20)
		{
			w = (i + 0.5) * 0.1;
			Nvg.strokeWidth(vg, w);
			Nvg.beginPath(vg);
			Nvg.moveTo(vg, x, y);
			Nvg.lineTo(vg, x + width, y + width * 0.3);
			Nvg.stroke(vg);
			y += 10;
		}
		
		Nvg.restore(vg);
	}
	
	function drawCaps(vg:Pointer<NvgContext>, x:Float, y:Float, width:Float):Void
	{
		var caps:Array<Int> = [NvgLineCap.BUTT, NvgLineCap.ROUND, NvgLineCap.SQUARE];
		var lineWidth:Float = 8.0;
		
		Nvg.save(vg);
		
		Nvg.beginPath(vg);
		Nvg.rect(vg, x - lineWidth / 2, y, width + lineWidth, 40);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 32));
		Nvg.fill(vg);
		
		Nvg.beginPath(vg);
		Nvg.rect(vg, x, y, width, 40);
		Nvg.fillColor(vg, Nvg.rgba(255, 255, 255, 32));
		Nvg.fill(vg);
		
		Nvg.strokeWidth(vg, lineWidth);
		
		for (i in 0 ... 3)
		{
			Nvg.lineCap(vg, caps[i]);
			Nvg.strokeColor(vg, Nvg.rgba(0, 0, 0, 255));
			Nvg.beginPath(vg);
			Nvg.moveTo(vg, x, y + i * 10 + 5);
			Nvg.lineTo(vg, x + width, y + i * 10 + 5);
			Nvg.stroke(vg);
		}
		
		Nvg.restore(vg);
	}
	
	function drawScissor(vg:Pointer<NvgContext>, x:Float, y:Float, t:Float):Void
	{
		Nvg.save(vg);
		
		// Draw first rect and set scissor to it's area.
		Nvg.translate(vg, x, y);
		Nvg.rotate(vg, Nvg.degToRad(5));
		Nvg.beginPath(vg);
		Nvg.rect(vg, -20, -20, 60, 40);
		Nvg.fillColor(vg, Nvg.rgba(255, 0, 0, 255));
		Nvg.fill(vg);
		Nvg.scissor(vg, -20, -20, 60, 40);
		
		// Draw second rectangle with offset and rotation.
		Nvg.translate(vg, 40, 0);
		Nvg.rotate(vg, t);
		
		// Draw the intended second rectangle without any scissoring.
		Nvg.save(vg);
		Nvg.resetScissor(vg);
		Nvg.beginPath(vg);
		Nvg.rect(vg, -20, -10, 60, 30);
		Nvg.fillColor(vg, Nvg.rgba(255, 128, 0, 64));
		Nvg.fill(vg);
		Nvg.restore(vg);
		
		// Draw second rectangle with combined scissoring.
		Nvg.intersectScissor(vg, -20, -10, 60, 30);
		Nvg.beginPath(vg);
		Nvg.rect(vg, -20, -10, 60, 30);
		Nvg.fillColor(vg, Nvg.rgba(255, 128, 0, 255));
		Nvg.fill(vg);
		
		Nvg.restore(vg);
	}
	
}