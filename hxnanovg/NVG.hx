package hxnanovg;

import cpp.Pointer;
import cpp.UInt8;

@:include("hx-nanovg.h")
@:native("NVGcontext")
extern class NvgContext {}

@:enum
abstract NvgSolidity(Int) {
	var SOLID = 1;
	var HOLE = 2;
}

@:include("nanovg.h")
@:native("NVGcolor")
extern class NvgColor {
	public var r:Float;
	public var g:Float;
	public var b:Float;
	public var a:Float;
}

@:include("hx-nanovg.h")
@:include("nanovg.h")
extern class Nvg {

	@:native("nanovg::nvgCreateGL")
	public static function createGL(_atlasW:Int, _atlasH:Int, _flags:Int):Pointer<NvgContext>;

	@:native("nanovg::nvgDeleteGL")
	public static function deleteGL(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgBeginFrame")
	public static function beginFrame(_ctx:Pointer<NvgContext>, _windowWidth:Int, _windowHeight:Int, _devicePixelRatio:Float, _alphaBlend:Int):Void;

	@:native("::nvgEndFrame")
	public static function endFrame(_ctx:Pointer<NvgContext>):Void;	

	@:native("::nvgBeginPath")
	public static function beginPath(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgRect")
	public static function rect(_ctx:Pointer<NvgContext>, _x:Int, _y:Int, _w:Float, _h:Int):Void;

	@:native("::nvgCircle")
	public static function circle(_ctx:Pointer<NvgContext>, _cx:Int, _cy:Int, _r:Float):Void;

	@:native("::nvgPathWinding")
	public static function pathWinding(_ctx:Pointer<NvgContext>, _dir:Int):Void;

	@:native("::nvgFillColor")
	public static function fillColor(_ctx:Pointer<NvgContext>, _color:NvgColor):Void;

	@:native("::nvgFill")
	public static function fill(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgRGBA")
	public static function rgba(_r:UInt8, _g:UInt8, _b:UInt8, _a:UInt8):NvgColor;
}

