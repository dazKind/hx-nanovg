package hxnanovg;

import cpp.ConstPointer;
import cpp.Pointer;
import cpp.UInt8;

@:include("hx-nanovg.h")
@:native("NVGcontext")
extern class NvgContext {}

class NvgMode {
    inline public static var ANTIALIAS:Int = 1;
    inline public static var STENCIL_STROKES:Int = 2;
}

class NvgWinding {
    inline public static var CCW:Int = 1;
    inline public static var CW:Int = 2;
}

class NvgSolidity {
    inline public static var SOLID:Int = 1;
    inline public static var HOLE:Int = 2;
}

class NvgLineCap  {
    inline public static var BUTT:Int   = 1;
    inline public static var ROUND:Int  = 2;
    inline public static var SQUARE:Int = 3;
    inline public static var BEVEL:Int  = 4;
    inline public static var MITER:Int  = 5;
}

class NvgPatternRepeat   {
    inline public static var NOREPEAT:Int = 0;
    inline public static var REPEATX:Int  = 0x01;
    inline public static var REPEATY:Int  = 0x02;
}

class NvgAlign {
    inline public static var ALIGN_LEFT:Int      = 1<<0;
    inline public static var ALIGN_CENTER:Int    = 1<<1;
    inline public static var ALIGN_RIGHT:Int     = 1<<2;
    inline public static var ALIGN_TOP:Int       = 1<<3;
    inline public static var ALIGN_MIDDLE:Int    = 1<<4;
    inline public static var ALIGN_BOTTOM:Int    = 1<<5;
    inline public static var ALIGN_BASELINE:Int  = 1<<6;
}

@:include("nanovg.h")
@:structAccess
@:unreflective
@:native("NVGcolor")
extern class NvgColor {
    public var r:Float;
    public var g:Float;
    public var b:Float;
    public var a:Float;
}

@:include("nanovg.h")
@:structAccess
@:unreflective
@:native("NVGpaint")
extern class NvgPaint {
    @:native("float[]")
    public var xform:Dynamic; // float[6]
    @:native("float[]")
    public var extent:Dynamic; // float[3]
    public var radius:Float;
    public var feather:Float;
    public var innerColor:NvgColor;
    public var outerColor:NvgColor;
    public var image:Int;
    public var repeat:Int;
}

@:include("nanovg.h")
@:structAccess
@:unreflective
@:native("NVGglyphPosition")
extern class NvgGlyphPosition {
    public var str:String;
    public var x:Float;
    public var min:Float;
    public var max:Float;
}

@:include("nanovg.h")
@:structAccess
@:unreflective
@:native("NVGtextRow")
extern class NvgTextRow {
    public var start:String;
    public var end:String;
    public var next:String;
    public var width:Float;
    public var minx:Float;
    public var maxx:Float;
}

@:include("nanovg.h")
@:include("hx-nanovg.h")
@:buildXml("&<include name='${haxelib:hx-nanovg}/Build.xml'/>")
extern class Nvg {

    @:native("nanovg::nvgCreateGL")
    public static function createGL(_flags:Int):Pointer<NvgContext>;

    @:native("nanovg::nvgDeleteGL")
    public static function deleteGL(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgBeginFrame")
    public static function beginFrame(_ctx:Pointer<NvgContext>, _windowWidth:Int, _windowHeight:Int, _devicePixelRatio:Float):Void;

    @:native("::nvgEndFrame")
    public static function endFrame(_ctx:Pointer<NvgContext>):Void; 


    @:native("::nvgRGB")
    public static function rgb(_r:UInt8, _g:UInt8, _b:UInt8):NvgColor;

    @:native("::nvgRGBf")
    public static function rgbf(_r:Float, _g:Float, _b:Float):NvgColor;

    @:native("::nvgRGBA")
    public static function rgba(_r:UInt8, _g:UInt8, _b:UInt8, _a:UInt8):NvgColor;

    @:native("::nvgRGBAf")
    public static function rgbaf(_r:Float, _g:Float, _b:Float, _a:Float):NvgColor;

    @:native("::nvgLerpRGBA")
    public static function lerpRgba(_c0:NvgColor, _c1:NvgColor, _u:Float):NvgColor;

    @:native("::nvgTransRGBA")
    public static function transRgba(_c0:NvgColor, _a:UInt8):NvgColor;

    @:native("::nvgTransRGBAf")
    public static function transRgbaf(_c0:NvgColor, _a:Float):NvgColor;

    @:native("::nvgHSL")
    public static function hsl(_h:Float, _s:Float, _l:Float):NvgColor;

    @:native("::nvgHSLA")
    public static function hsla(_h:Float, _s:Float, _l:Float, _a:UInt8):NvgColor;


    @:native("::nvgSave")
    public static function save(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgRestore")
    public static function restore(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgReset")
    public static function reset(_ctx:Pointer<NvgContext>):Void;


    @:native("::nvgStrokeColor")
    public static function strokeColor(_ctx:Pointer<NvgContext>, _color:NvgColor):Void;

    @:native("::nvgStrokePaint")
    public static function strokePaint(_ctx:Pointer<NvgContext>, _paint:NvgPaint):Void;

    @:native("::nvgFillColor")
    public static function fillColor(_ctx:Pointer<NvgContext>, _color:NvgColor):Void;

    @:native("::nvgFillPaint")
    public static function fillPaint(_ctx:Pointer<NvgContext>, _paint:NvgPaint):Void;

    @:native("::nvgMiterLimit")
    public static function miterLimit(_ctx:Pointer<NvgContext>, _limit:Float):Void;

    @:native("::nvgStrokeWidth")
    public static function strokeWidth(_ctx:Pointer<NvgContext>, _size:Float):Void;

    @:native("::nvgLineCap")
    public static function lineCap(_ctx:Pointer<NvgContext>, _cap:Int):Void;

    @:native("::nvgLineJoin")
    public static function lineJoin(_ctx:Pointer<NvgContext>, _join:Int):Void;

    @:native("::nvgGlobalAlpha")
    public static function globalAlpha(_ctx:Pointer<NvgContext>, _alpha:Float):Void;


    @:native("::nvgResetTransform")
    public static function resetTransform(_ctx:Pointer<NvgContext>):Void;


    @:native("::nvgTransform")
    public static function transform(_ctx:Pointer<NvgContext>, _a:Float, _b:Float, _c:Float, _d:Float, _e:Float, _f:Float):Void;

    @:native("::nvgTranslate")
    public static function translate(_ctx:Pointer<NvgContext>, _x:Float, _y:Float):Void;

    @:native("::nvgRotate")
    public static function rotate(_ctx:Pointer<NvgContext>, _angle:Float):Void;

    @:native("::nvgSkewX")
    public static function skewX(_ctx:Pointer<NvgContext>, _angle:Float):Void;

    @:native("::nvgSkewY")
    public static function skewY(_ctx:Pointer<NvgContext>, _angle:Float):Void;

    @:native("::nvgScale")
    public static function scale(_ctx:Pointer<NvgContext>, _x:Float, _y:Float):Void;

    @:native("::nvgCurrentTransform")
    public static function currentTransform(_ctx:Pointer<NvgContext>, _xForm:Float):Void;

    @:native("::nvgTransformIdentity")
    public static function transformIdentity(_dst:Float):Void;

    @:native("::nvgTransformTranslate")
    public static function transformTranslate(_dst:Pointer<Float>, _tx:Float, _ty:Float):Void;

    @:native("::nvgTransformScale")
    public static function transformScale(_dst:Pointer<Float>, _sx:Float, _sy:Float):Void;

    @:native("::nvgTransformRotate")
    public static function transformRotate(_dst:Pointer<Float>, _angle:Float):Void;

    @:native("::nvgTransformSkewX")
    public static function transformSkewX(_dst:Pointer<Float>, _angle:Float):Void;

    @:native("::nvgTransformSkewY")
    public static function transformSkewY(_dst:Pointer<Float>, _angle:Float):Void;

    @:native("::nvgTransformMultiply")
    public static function transformMultiply(_dst:Pointer<Float>, _src:ConstPointer<Float>):Void;

    @:native("::nvgTransformPremultiply")
    public static function transformPremultiply(_dst:Pointer<Float>, _src:ConstPointer<Float>):Void;

    @:native("::nvgTransformInverse")
    public static function transformInverse(_dst:Pointer<Float>, _src:ConstPointer<Float>):Void;

    @:native("::nvgTransformPoint")
    public static function transformPoint(_dstx:Pointer<Float>, _dsty:Pointer<Float>, _xform:ConstPointer<Float>, _srcx:Float, _srcy:Float):Void;


    @:native("::nvgDegToRad")
    public static function degToRad(_deg:Float):Float;

    @:native("::nvgRadToDeg")
    public static function radToDeg(_rad:Float):Float;


    @:native("::nvgCreateImage")
    public static function createImage(_ctx:Pointer<NvgContext>, _filename:String):Int;

    @:native("::nvgCreateImageMem")
    public static function createImageMem(_ctx:Pointer<NvgContext>, _data:haxe.io.BytesData, _ndata:Int):Int;

    @:native("::nvgCreateImageRGBA")
    public static function createImageRGBA(_ctx:Pointer<NvgContext>, _w:Int, _h:Int, _data:haxe.io.BytesData):Int;

    @:native("::nvgUpdateImage")
    public static function updateImage(_ctx:Pointer<NvgContext>, _image:Int, _data:haxe.io.BytesData):Void;

    @:native("::nvgImageSize")
    public static function imageSize(_ctx:Pointer<NvgContext>, _image:Int, _w:Pointer<Int>, _h:Pointer<Int>):Void;

    @:native("::nvgDeleteImage")
    public static function deleteImage(_ctx:Pointer<NvgContext>, _image:Int):Void;


    @:native("::nvgLinearGradient")
    public static function linearGradient(_ctx:Pointer<NvgContext>, _sx:Float, _sy:Float, _ex:Float, _ey:Float, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

    @:native("::nvgBoxGradient")
    public static function boxGradient(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _w:Float, _h:Float, _r:Float, _f:Float, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

    @:native("::nvgRadialGradient")
    public static function radialGradient(_ctx:Pointer<NvgContext>, _cx:Float, _cy:Float, _inr:Float, _outr:Float, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

    @:native("::nvgImagePattern")
    public static function imagePattern(_ctx:Pointer<NvgContext>, _ox:Float, _oy:Float, _ex:Float, _ey:Float, _angle:Float, _image:Int, _repeat:Int, _alpha:Float):NvgPaint;


    @:native("::nvgScissor")
    public static function scissor(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _w:Float, _h:Float):Void;

    @:native("::nvgIntersectScissor")
    public static function intersectScissor(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _w:Float, _h:Float):Void;

    @:native("::nvgResetScissor")
    public static function resetScissor(_ctx:Pointer<NvgContext>):Void;


    @:native("::nvgBeginPath")
    public static function beginPath(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgMoveTo")
    public static function moveTo(_ctx:Pointer<NvgContext>, _x:Float, _y:Float):Void;

    @:native("::nvgLineTo")
    public static function lineTo(_ctx:Pointer<NvgContext>, _x:Float, _y:Float):Void;

    @:native("::nvgBezierTo")
    public static function bezierTo(_ctx:Pointer<NvgContext>, _c1x:Float, _c1y:Float, _c2x:Float, _c2y:Float, _x:Float, _y:Float):Void;

    @:native("::nvgArcTo")
    public static function arcTo(_ctx:Pointer<NvgContext>, _x1:Float, _y1:Float, _x2:Float, _y2:Float, _radius:Float):Void;

    @:native("::nvgClosePath")
    public static function closePath(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgPathWinding")
    public static function pathWinding(_ctx:Pointer<NvgContext>, _dir:Int):Void;

    @:native("::nvgArc")
    public static function arc(_ctx:Pointer<NvgContext>, _cx:Float, _cy:Float, _r:Float, _a0:Float, _a1:Float, _dir:Int):Void;

    @:native("::nvgRect")
    public static function rect(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _w:Float, _h:Float):Void;

    @:native("::nvgRoundedRect")
    public static function roundedRect(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _w:Float, _h:Float, _r:Float):Void;

    @:native("::nvgEllipse")
    public static function ellipse(_ctx:Pointer<NvgContext>, _cx:Float, _cy:Float, _rx:Float, _ry:Float):Void;

    @:native("::nvgCircle")
    public static function circle(_ctx:Pointer<NvgContext>, _cx:Float, _cy:Float, _r:Float):Void;

    @:native("::nvgFill")
    public static function fill(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgStroke")
    public static function stroke(_ctx:Pointer<NvgContext>):Void;

    
    @:native("::nvgCreateFont")
    public static function createFont(_ctx:Pointer<NvgContext>, _name:String, _filename:String):Int;

    @:native("::nvgCreateFontMem")
    public static function createFontMem(_ctx:Pointer<NvgContext>, _name:String, _data:haxe.io.BytesData, _ndata:Int, _freeData:Int):Int;

    @:native("::nvgFindFont")
    public static function findFont(_ctx:Pointer<NvgContext>, _name:String):Int;

    @:native("::nvgFontSize")
    public static function fontSize(_ctx:Pointer<NvgContext>, _size:Float):Void;

    @:native("::nvgFontBlur")
    public static function fontBlur(_ctx:Pointer<NvgContext>, _blur:Float):Void;

    @:native("::nvgTextLetterSpacing")
    public static function textLetterSpacing(_ctx:Pointer<NvgContext>, _spacing:Float):Void;

    @:native("::nvgTextLineHeight")
    public static function textLineHeight(_ctx:Pointer<NvgContext>, _lineHeight:Float):Void;

    @:native("::nvgTextAlign")
    public static function textAlign(_ctx:Pointer<NvgContext>, _align:Int):Void;

    @:native("::nvgFontFaceId")
    public static function fontFaceId(_ctx:Pointer<NvgContext>, _font:Int):Void;

    @:native("::nvgFontFace")
    public static function fontFace(_ctx:Pointer<NvgContext>, _font:String):Void;

    @:native("::nvgText")
    public static function text(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _string:String, _end:String):Float;

    @:native("::nvgTextBox")
    public static function textBox(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _breakRowWidth:Float, _string:String, _end:String):Void;

    @:native("::nvgTextBounds")
    public static function textBounds(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _string:String, _end:String, _bounds:Pointer<Float>):Float;

    @:native("::nvgTextBoxBounds")
    public static function textBoxBounds(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _breakRowWidth:Float, _string:String, _end:String, _bounds:Pointer<Float>):Void;

    @:native("::nvgTextGlyphPositions")
    public static function textGlyphPositions(_ctx:Pointer<NvgContext>, _x:Float, _y:Float, _string:String, _end:String, _positions:Pointer<NvgGlyphPosition>, _maxPositions:Int):Int;

    @:native("::nvgTextMetrics")
    public static function textMetrics(_ctx:Pointer<NvgContext>, _ascender:Pointer<Float>, _descender:Pointer<Float>, _lineh:Pointer<Float>):Void;

    @:native("::nvgTextBreakLines")
    public static function textBreakLines(_ctx:Pointer<NvgContext>, _string:String, _end:String, _breakRowWidth:Float, _rows:Pointer<NvgTextRow>, _maxRows:Int):Int;
}

