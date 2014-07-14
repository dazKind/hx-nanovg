package hxnanovg;

import cpp.Char;
import cpp.ConstPointer;
import cpp.Pointer;
import cpp.UInt8;
import cpp.Float32;

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
    public var r:Float32;
    public var g:Float32;
    public var b:Float32;
    public var a:Float32;
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
    public var radius:Float32;
    public var feather:Float32;
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
    public var str:ConstPointer<Char>;
    public var x:Float32;
    public var min:Float32;
    public var max:Float32;
}

@:include("nanovg.h")
@:structAccess
@:unreflective
@:native("NVGtextRow")
extern class NvgTextRow {
    public var start:ConstPointer<Char>;
    public var end:ConstPointer<Char>;
    public var next:ConstPointer<Char>;
    public var width:Float32;
    public var minx:Float32;
    public var maxx:Float32;
}


@:include("hx-nanovg.h")
@:include("nanovg.h")
@:buildXml("&<include name='${haxelib:hx-nanovg}/Build.xml'/>")
extern class Nvg {

    @:native("nanovg::nvgCreateGL")
    public static function createGL(_flags:Int):Pointer<NvgContext>;

    @:native("nanovg::nvgDeleteGL")
    public static function deleteGL(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgBeginFrame")
    public static function beginFrame(_ctx:Pointer<NvgContext>, _windowWidth:Int, _windowHeight:Int, _devicePixelRatio:Float32):Void;

    @:native("::nvgEndFrame")
    public static function endFrame(_ctx:Pointer<NvgContext>):Void; 


    @:native("::nvgRGB")
    public static function rgb(_r:UInt8, _g:UInt8, _b:UInt8):NvgColor;

    @:native("::nvgRGBf")
    public static function rgbf(_r:Float32, _g:Float32, _b:Float32):NvgColor;

    @:native("::nvgRGBA")
    public static function rgba(_r:UInt8, _g:UInt8, _b:UInt8, _a:UInt8):NvgColor;

    @:native("::nvgRGBAf")
    public static function rgbaf(_r:Float32, _g:Float32, _b:Float32, _a:Float32):NvgColor;

    @:native("::nvgLerpRGBA")
    public static function lerpRgba(_c0:NvgColor, _c1:NvgColor, _u:Float32):NvgColor;

    @:native("::nvgTransRGBA")
    public static function transRgba(_c0:NvgColor, _a:UInt8):NvgColor;

    @:native("::nvgTransRGBAf")
    public static function transRgbaf(_c0:NvgColor, _a:Float32):NvgColor;

    @:native("::nvgHSL")
    public static function hsl(_h:Float32, _s:Float32, _l:Float32):NvgColor;

    @:native("::nvgHSLA")
    public static function hsla(_h:Float32, _s:Float32, _l:Float32, _a:UInt8):NvgColor;


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
    public static function miterLimit(_ctx:Pointer<NvgContext>, _limit:Float32):Void;

    @:native("::nvgStrokeWidth")
    public static function strokeWidth(_ctx:Pointer<NvgContext>, _size:Float32):Void;

    @:native("::nvgLineCap")
    public static function lineCap(_ctx:Pointer<NvgContext>, _cap:Int):Void;

    @:native("::nvgLineJoin")
    public static function lineJoin(_ctx:Pointer<NvgContext>, _join:Int):Void;

    @:native("::nvgGlobalAlpha")
    public static function globalAlpha(_ctx:Pointer<NvgContext>, _alpha:Float32):Void;


    @:native("::nvgResetTransform")
    public static function resetTransform(_ctx:Pointer<NvgContext>):Void;


    @:native("::nvgTransform")
    public static function transform(_ctx:Pointer<NvgContext>, _a:Float32, _b:Float32, _c:Float32, _d:Float32, _e:Float32, _f:Float32):Void;

    @:native("::nvgTranslate")
    public static function translate(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

    @:native("::nvgRotate")
    public static function rotate(_ctx:Pointer<NvgContext>, _angle:Float32):Void;

    @:native("::nvgSkewX")
    public static function skewX(_ctx:Pointer<NvgContext>, _angle:Float32):Void;

    @:native("::nvgSkewY")
    public static function skewY(_ctx:Pointer<NvgContext>, _angle:Float32):Void;

    @:native("::nvgScale")
    public static function scale(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

    @:native("::nvgCurrentTransform")
    public static function currentTransform(_ctx:Pointer<NvgContext>, _xForm:Float32):Void;

    @:native("::nvgTransformIdentity")
    public static function transformIdentity(_dst:Float32):Void;

    @:native("::nvgTransformTranslate")
    public static function transformTranslate(_dst:Pointer<Float32>, _tx:Float32, _ty:Float32):Void;

    @:native("::nvgTransformScale")
    public static function transformScale(_dst:Pointer<Float32>, _sx:Float32, _sy:Float32):Void;

    @:native("::nvgTransformRotate")
    public static function transformRotate(_dst:Pointer<Float32>, _angle:Float32):Void;

    @:native("::nvgTransformSkewX")
    public static function transformSkewX(_dst:Pointer<Float32>, _angle:Float32):Void;

    @:native("::nvgTransformSkewY")
    public static function transformSkewY(_dst:Pointer<Float32>, _angle:Float32):Void;

    @:native("::nvgTransformMultiply")
    public static function transformMultiply(_dst:Pointer<Float32>, _src:ConstPointer<Float32>):Void;

    @:native("::nvgTransformPremultiply")
    public static function transformPremultiply(_dst:Pointer<Float32>, _src:ConstPointer<Float32>):Void;

    @:native("::nvgTransformInverse")
    public static function transformInverse(_dst:Pointer<Float32>, _src:ConstPointer<Float32>):Void;

    @:native("::nvgTransformPoint")
    public static function transformPoint(_dstx:Pointer<Float32>, _dsty:Pointer<Float32>, _xform:ConstPointer<Float32>, _srcx:Float32, _srcy:Float32):Void;


    @:native("::nvgDegToRad")
    public static function degToRad(_deg:Float32):Float32;

    @:native("::nvgRadToDeg")
    public static function radToDeg(_rad:Float32):Float32;


    @:native("::nvgCreateImage")
    public static function createImage(_ctx:Pointer<NvgContext>, _filename:ConstPointer<Char>):Int;

    @:native("::nvgCreateImageMem")
    public static function createImageMem(_ctx:Pointer<NvgContext>, _data:Pointer<Char>, _ndata:Int):Int;

    @:native("::nvgCreateImageRGBA")
    public static function createImageRGBA(_ctx:Pointer<NvgContext>, _w:Int, _h:Int, _data:Pointer<Char>):Int;

    @:native("::nvgUpdateImage")
    public static function updateImage(_ctx:Pointer<NvgContext>, _image:Int, _data:Pointer<Char>):Void;

    @:native("::nvgImageSize")
    public static function imageSize(_ctx:Pointer<NvgContext>, _image:Int, _w:Pointer<Int>, _h:Pointer<Int>):Void;

    @:native("::nvgDeleteImage")
    public static function deleteImage(_ctx:Pointer<NvgContext>, _image:Int):Void;


    @:native("::nvgLinearGradient")
    public static function linearGradient(_ctx:Pointer<NvgContext>, _sx:Float32, _sy:Float32, _ex:Float32, _ey:Float32, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

    @:native("::nvgBoxGradient")
    public static function boxGradient(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _w:Float32, _h:Float32, _r:Float32, _f:Float32, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

    @:native("::nvgRadialGradient")
    public static function radialGradient(_ctx:Pointer<NvgContext>, _cx:Float32, _cy:Float32, _inr:Float32, _outr:Float32, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

    @:native("::nvgImagePattern")
    public static function imagePattern(_ctx:Pointer<NvgContext>, _ox:Float32, _oy:Float32, _ex:Float32, _ey:Float32, _angle:Float32, _image:Int, _repeat:Int, _alpha:Float32):NvgPaint;


    @:native("::nvgScissor")
    public static function scissor(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _w:Float32, _h:Float32):Void;

    @:native("::nvgResetScissor")
    public static function resetScissor(_ctx:Pointer<NvgContext>):Void;


    @:native("::nvgBeginPath")
    public static function beginPath(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgMoveTo")
    public static function moveTo(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

    @:native("::nvgLineTo")
    public static function lineTo(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

    @:native("::nvgBezierTo")
    public static function bezierTo(_ctx:Pointer<NvgContext>, _c1x:Float32, _c1y:Float32, _c2x:Float32, _c2y:Float32, _x:Float32, _y:Float32):Void;

    @:native("::nvgArcTo")
    public static function arcTo(_ctx:Pointer<NvgContext>, _x1:Float32, _y1:Float32, _x2:Float32, _y2:Float32, _radius:Float32):Void;

    @:native("::nvgClosePath")
    public static function closePath(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgPathWinding")
    public static function pathWinding(_ctx:Pointer<NvgContext>, _dir:Int):Void;

    @:native("::nvgArc")
    public static function arc(_ctx:Pointer<NvgContext>, _cx:Int, _cy:Int, _r:Float32, _a0:Float32, _a1:Float32, _dir:Int):Void;

    @:native("::nvgRect")
    public static function rect(_ctx:Pointer<NvgContext>, _x:Int, _y:Int, _w:Float32, _h:Float32):Void;

    @:native("::nvgRoundedRect")
    public static function roundedRect(_ctx:Pointer<NvgContext>, _x:Int, _y:Int, _w:Float32, _h:Float32, _r:Float32):Void;

    @:native("::nvgEllipse")
    public static function ellipse(_ctx:Pointer<NvgContext>, _cx:Int, _cy:Int, _rx:Float32, _ry:Float32):Void;

    @:native("::nvgCircle")
    public static function circle(_ctx:Pointer<NvgContext>, _cx:Int, _cy:Int, _r:Float32):Void;

    @:native("::nvgFill")
    public static function fill(_ctx:Pointer<NvgContext>):Void;

    @:native("::nvgStroke")
    public static function stroke(_ctx:Pointer<NvgContext>):Void;

    
    @:native("::nvgCreateFont")
    public static function createFont(_ctx:Pointer<NvgContext>, _name:ConstPointer<Char>, _filename:ConstPointer<Char>):Int;

    @:native("::nvgCreateFontMem")
    public static function createFontMem(_ctx:Pointer<NvgContext>, _name:ConstPointer<Char>, _data:Pointer<Char>, _ndata:Int, _freeData:Int):Int;

    @:native("::nvgFindFont")
    public static function findFont(_ctx:Pointer<NvgContext>, _name:ConstPointer<Char>):Int;

    @:native("::nvgFontSize")
    public static function fontSize(_ctx:Pointer<NvgContext>, _size:Float32):Void;

    @:native("::nvgFontBlur")
    public static function fontBlur(_ctx:Pointer<NvgContext>, _blur:Float32):Void;

    @:native("::nvgTextLetterSpacing")
    public static function textLetterSpacing(_ctx:Pointer<NvgContext>, _spacing:Float32):Void;

    @:native("::nvgTextLineHeight")
    public static function textLineHeight(_ctx:Pointer<NvgContext>, _lineHeight:Float32):Void;

    @:native("::nvgTextAlign")
    public static function textAlign(_ctx:Pointer<NvgContext>, _align:Int):Void;

    @:native("::nvgFontFaceId")
    public static function fontFaceId(_ctx:Pointer<NvgContext>, _font:Int):Void;

    @:native("::nvgFontFace")
    public static function fontFace(_ctx:Pointer<NvgContext>, _font:ConstPointer<Char>):Void;

    @:native("::nvgText")
    public static function text(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>):Float32;

    @:native("::nvgTextBox")
    public static function textBox(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _breakRowWidth:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>):Void;

    @:native("::nvgTextBounds")
    public static function textBounds(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _bounds:Pointer<Float32>):Float32;

    @:native("::nvgTextBoxBounds")
    public static function textBoxBounds(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _breakRowWidth:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _bounds:Pointer<Float32>):Void;

    @:native("::nvgTextGlyphPositions")
    public static function textGlyphPositions(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _positions:Pointer<NvgGlyphPosition>, _maxPositions:Int):Int;

    @:native("::nvgTextMetrics")
    public static function textMetrics(_ctx:Pointer<NvgContext>, _ascender:Pointer<Float32>, _descender:Pointer<Float32>, _lineh:Pointer<Float32>):Void;

    @:native("::nvgTextBreakLines")
    public static function textBreakLines(_ctx:Pointer<NvgContext>, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _breakRowWidth:Float32, _rows:Pointer<NvgTextRow>, _maxRows:Int):Int;
}

