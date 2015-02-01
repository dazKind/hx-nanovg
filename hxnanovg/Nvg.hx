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
	/** Winding for solid shapes **/
    inline public static var CCW:Int = 1;
	/** Winding for holes **/
    inline public static var CW:Int = 2;
}

class NvgSolidity {
	/** CCW **/
    inline public static var SOLID:Int = 1;
	/** CW **/
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
	/** Default, align text horizontally to left. **/
    inline public static var ALIGN_LEFT:Int      = 1 << 0;
	/** Align text horizontally to center. **/
    inline public static var ALIGN_CENTER:Int    = 1 << 1;
	/** Align text horizontally to right. **/
    inline public static var ALIGN_RIGHT:Int     = 1 << 2;
	/** Align text vertically to top. **/
    inline public static var ALIGN_TOP:Int       = 1 << 3;
	/** Align text vertically to middle. **/
    inline public static var ALIGN_MIDDLE:Int    = 1 << 4;
	/** Align text vertically to bottom. **/
    inline public static var ALIGN_BOTTOM:Int    = 1 << 5;
	/** Default, align text vertically to baseline. **/
    inline public static var ALIGN_BASELINE:Int  = 1 << 6;
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
	@:native("new NvgGlyphPosition")
	static public function create():Pointer<NvgGlyphPosition>;
	/** Position of the glyph in the input string. **/
    public var str:ConstPointer<Char>;
	/** The x-coordinate of the logical glyph position. **/
    public var x:Float32;
	/** The bounds of the glyph shape. **/
    public var min:Float32;
	/** The bounds of the glyph shape. **/
    public var max:Float32;
}

@:include("nanovg.h")
@:structAccess
@:unreflective
@:native("NVGtextRow")
extern class NvgTextRow {
	@:native("new NVGtextRow")
	static public function create():Pointer<NvgTextRow>;
	/** Pointer to the input text where the row starts. **/
    public var start:ConstPointer<Char>;
	/** Pointer to the input text where the row ends (one past the last character). **/
    public var end:ConstPointer<Char>;
	/** Pointer to the beginning of the next row. **/
    public var next:ConstPointer<Char>;
	/** Logical width of the row. **/
    public var width:Float32;
	/** Actual bounds of the row. Logical with and bounds can differ because of kerning and some parts over extending. **/
    public var minx:Float32;
	/** Actual bounds of the row. Logical with and bounds can differ because of kerning and some parts over extending. **/
    public var maxx:Float32;
}

class NVGimageFlags {
	/** Generate mipmaps during creation of the image. **/
    inline public static var IMAGE_GENERATE_MIPMAPS:Int	= 1 << 0;
	/** Repeat image in X direction. **/
	inline public static var IMAGE_REPEATX:Int			= 1 << 1;
	/** Repeat image in Y direction. **/
	inline public static var IMAGE_REPEATY:Int			= 1 << 2;
	/** Flips (inverses) image in Y direction when rendered. **/
	inline public static var IMAGE_FLIPY:Int			= 1 << 3;
	/** Image data has premultiplied alpha. **/
	inline public static var IMAGE_PREMULTIPLIED:Int	= 1 << 4;
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
	/**
	 * Begin drawing a new frame
	 * Calls to nanovg drawing API should be wrapped in nvgBeginFrame() & nvgEndFrame()
	 * nvgBeginFrame() defines the size of the window to render to in relation currently
	 * set viewport (i.e. glViewport on GL backends). Device pixel ration allows to
	 * control the rendering on Hi-DPI devices.
	 * For example, GLFW returns two dimension for an opened window: window size and
	 * frame buffer size. In that case you would set windowWidth/Height to the window size
	 * @param	_ctx
	 * @param	_windowWidth
	 * @param	_windowHeight
	 * @param	_devicePixelRatio frameBufferWidth / windowWidth
	 */
	public static function beginFrame(_ctx:Pointer<NvgContext>, _windowWidth:Int, _windowHeight:Int, _devicePixelRatio:Float32):Void;

	@:native("::nvgCancelFrame")
	/**
	 * Cancels drawing the current frame.
	 */
	public static function cancelFrame(_ctx:Pointer<NvgContext>):Void; 
	
	@:native("::nvgEndFrame")
	/**
	 * Ends drawing flushing remaining render state.
	 */
	public static function endFrame(_ctx:Pointer<NvgContext>):Void; 
	
	//
	// Color utils
	//
	// Colors in NanoVG are stored as unsigned ints in ABGR format.

	@:native("::nvgRGB")
	/**
	 * Returns a color value from red, green, blue values. Alpha will be set to 255 (1.0).
	 */
	public static function rgb(_r:UInt8, _g:UInt8, _b:UInt8):NvgColor;

	@:native("::nvgRGBf")
	/**
	 * Returns a color value from red, green, blue values. Alpha will be set to 1.0.
	 */
	public static function rgbf(_r:Float32, _g:Float32, _b:Float32):NvgColor;

	@:native("::nvgRGBA")
	/**
	 * Returns a color value from red, green, blue and alpha values. [0..255]
	 */
	public static function rgba(_r:UInt8, _g:UInt8, _b:UInt8, _a:UInt8):NvgColor;

	@:native("::nvgRGBAf")
	/**
	 * Returns a color value from red, green, blue and alpha values. [0..1]
	 */
	public static function rgbaf(_r:Float32, _g:Float32, _b:Float32, _a:Float32):NvgColor;

	@:native("::nvgLerpRGBA")
	/**
	 * Linearly interpolates from color c0 to c1, and returns resulting color value.
	 */
	public static function lerpRgba(_c0:NvgColor, _c1:NvgColor, _u:Float32):NvgColor;

	@:native("::nvgTransRGBA")
	/** Sets transparency of a color value. **/
	public static function transRgba(_c0:NvgColor, _a:UInt8):NvgColor;

	@:native("::nvgTransRGBAf")
	/** Sets transparency of a color value. **/
	public static function transRgbaf(_c0:NvgColor, _a:Float32):NvgColor;

	@:native("::nvgHSL")
	/**
	 * Returns color value specified by hue, saturation and lightness.
	 * HSL values are all in range [0..1], alpha will be set to 255.
	 */
	public static function hsl(_h:Float32, _s:Float32, _l:Float32):NvgColor;

	@:native("::nvgHSLA")
	/**
	 * Returns color value specified by hue, saturation and lightness.
	 * HSL values are all in range [0..1], alpha in range [0..255].
	 */
	public static function hsla(_h:Float32, _s:Float32, _l:Float32, _a:UInt8):NvgColor;

	// State Handling
	//
	// NanoVG contains state which represents how paths will be rendered.
	// The state contains transform, fill and stroke styles, text and font styles, and scissor clipping.
	
	@:native("::nvgSave")
	/**
	 * Pushes and saves the current render state into a state stack.
	 * A matching nvgRestore() must be used to restore the state.
	 */
	public static function save(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgRestore")
	/**
	 * Pops and restores current render state.
	 */
	public static function restore(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgReset")
	/**
	 * Resets current render state to default values. Does not affect the render state stack.
	 */
	public static function reset(_ctx:Pointer<NvgContext>):Void;

	//
	// Render styles
	//
	// Fill and stroke render style can be either a solid color or a paint which is a gradient or a pattern.
	// Solid color is simply defined as a color value, different kinds of paints can be created
	// using nvgLinearGradient(), nvgBoxGradient(), nvgRadialGradient() and nvgImagePattern().
	//
	// Current render style can be saved and restored using nvgSave() and nvgRestore(). 
	
	@:native("::nvgStrokeColor")
	/**
	 * Sets current stroke style to a solid color.
	 */
	public static function strokeColor(_ctx:Pointer<NvgContext>, _color:NvgColor):Void;

	@:native("::nvgStrokePaint")
	/**
	 * Sets current stroke style to a paint, which can be a one of the gradients or a pattern.
	 */
	public static function strokePaint(_ctx:Pointer<NvgContext>, _paint:NvgPaint):Void;

	@:native("::nvgFillColor")
	/**
	 * Sets current fill style to a solid color.
	 */
	public static function fillColor(_ctx:Pointer<NvgContext>, _color:NvgColor):Void;

	@:native("::nvgFillPaint")
	/**
	 * Sets current fill style to a paint, which can be a one of the gradients or a pattern.
	 */
	public static function fillPaint(_ctx:Pointer<NvgContext>, _paint:NvgPaint):Void;

	@:native("::nvgMiterLimit")
	/**
	 * Sets the miter limit of the stroke style.
	 * Miter limit controls when a sharp corner is beveled.
	 */
	public static function miterLimit(_ctx:Pointer<NvgContext>, _limit:Float32):Void;

	@:native("::nvgStrokeWidth")
	/**
	 * Sets the stroke width of the stroke style.
	 */
	public static function strokeWidth(_ctx:Pointer<NvgContext>, _size:Float32):Void;

	@:native("::nvgLineCap")
	/**
	 * Sets how the end of the line (cap) is drawn,
	 * Can be one of: NvgLineCap.BUTT (default), NvgLineCap.ROUND, NvgLineCap.SQUARE.
	 */
	public static function lineCap(_ctx:Pointer<NvgContext>, _cap:Int):Void;

	@:native("::nvgLineJoin")
	/**
	 * Sets how sharp path corners are drawn.
	 * Can be one of NvgLineCap.MITER (default), NvgLineCap.ROUND, NvgLineCap.BEVEL.
	 */
	public static function lineJoin(_ctx:Pointer<NvgContext>, _join:Int):Void;

	@:native("::nvgGlobalAlpha")
	/**
	 * Sets the transparency applied to all rendered shapes.
	 * Already transparent paths will get proportionally more transparent as well.
	 */
	public static function globalAlpha(_ctx:Pointer<NvgContext>, _alpha:Float32):Void;

	//
	// Transforms
	//
	// The paths, gradients, patterns and scissor region are transformed by an transformation
	// matrix at the time when they are passed to the API.
	// The current transformation matrix is a affine matrix:
	//   [sx kx tx]
	//   [ky sy ty]
	//   [ 0  0  1]
	// Where: sx,sy define scaling, kx,ky skewing, and tx,ty translation.
	// The last row is assumed to be 0,0,1 and is not stored.
	//
	// Apart from nvgResetTransform(), each transformation function first creates
	// specific transformation matrix and pre-multiplies the current transformation by it.
	//
	// Current coordinate system (transformation) can be saved and restored using nvgSave() and nvgRestore(). 

	@:native("::nvgResetTransform")
	/**
	 * Resets current transform to a identity matrix.
	 */
	public static function resetTransform(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgTransform")
	/**
	 * Premultiplies current coordinate system by specified matrix.
	 * The parameters are interpreted as matrix as follows:
	 *   [a c e]
	 *   [b d f]
	 *   [0 0 1]
	 */
	public static function transform(_ctx:Pointer<NvgContext>, _a:Float32, _b:Float32, _c:Float32, _d:Float32, _e:Float32, _f:Float32):Void;

	@:native("::nvgTranslate")
	/**
	 * Translates current coordinate system.
	 */
	public static function translate(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

	@:native("::nvgRotate")
	/**
	 * Rotates current coordinate system. Angle is specified in radians.
	 */
	public static function rotate(_ctx:Pointer<NvgContext>, _angle:Float32):Void;

	@:native("::nvgSkewX")
	/**
	 * Skews the current coordinate system along X axis. Angle is specified in radians.
	 */
	public static function skewX(_ctx:Pointer<NvgContext>, _angle:Float32):Void;

	@:native("::nvgSkewY")
	/**
	 * Skews the current coordinate system along Y axis. Angle is specified in radians.
	 */
	public static function skewY(_ctx:Pointer<NvgContext>, _angle:Float32):Void;

	@:native("::nvgScale")
	/**
	 * Scales the current coordinate system.
	 */
	public static function scale(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

	@:native("::nvgCurrentTransform")
	/**
	 * Stores the top part (a-f) of the current transformation matrix in to the specified buffer.
	 *   [a c e]
	 *   [b d f]
	 *   [0 0 1]
	 * There should be space for 6 floats in the return buffer for the values a-f.
	 */
	public static function currentTransform(_ctx:Pointer<NvgContext>, _xForm:Float32):Void;
	
	// The following functions can be used to make calculations on 2x3 transformation matrices.
	// A 2x3 matrix is represented as float[6].
	
	@:native("::nvgTransformIdentity")
	/**
	 * Sets the transform to identity matrix.
	 */
	public static function transformIdentity(_dst:Pointer<Float32>):Void;

	@:native("::nvgTransformTranslate")
	/**
	 *  Sets the transform to translation matrix matrix.
	 */
	public static function transformTranslate(_dst:Pointer<Float32>, _tx:Float32, _ty:Float32):Void;

	@:native("::nvgTransformScale")
	/**
	 * Sets the transform to scale matrix.
	 */
	public static function transformScale(_dst:Pointer<Float32>, _sx:Float32, _sy:Float32):Void;

	@:native("::nvgTransformRotate")
	/**
	 * Sets the transform to rotate matrix. Angle is specified in radians.
	 */
	public static function transformRotate(_dst:Pointer<Float32>, _angle:Float32):Void;

	@:native("::nvgTransformSkewX")
	/**
	 * Sets the transform to skew-x matrix. Angle is specified in radians.
	 */
	public static function transformSkewX(_dst:Pointer<Float32>, _angle:Float32):Void;

	@:native("::nvgTransformSkewY")
	/**
	 * Sets the transform to skew-y matrix. Angle is specified in radians.
	 */
	public static function transformSkewY(_dst:Pointer<Float32>, _angle:Float32):Void;

	@:native("::nvgTransformMultiply")
	/**
	 * Sets the transform to the result of multiplication of two transforms, of A = A*B.
	 */
	public static function transformMultiply(_dst:Pointer<Float32>, _src:ConstPointer<Float32>):Void;

	@:native("::nvgTransformPremultiply")
	/**
	 * Sets the transform to the result of multiplication of two transforms, of A = B*A.
	 */
	public static function transformPremultiply(_dst:Pointer<Float32>, _src:ConstPointer<Float32>):Void;

	@:native("::nvgTransformInverse")
	/**
	 * Sets the destination to inverse of specified transform.
	 * Returns 1 if the inverse could be calculated, else 0.
	 */
	public static function transformInverse(_dst:Pointer<Float32>, _src:ConstPointer<Float32>):Void;

	@:native("::nvgTransformPoint")
	/**
	 * Transform a point by given transform.
	 */
	public static function transformPoint(_dstx:Pointer<Float32>, _dsty:Pointer<Float32>, _xform:ConstPointer<Float32>, _srcx:Float32, _srcy:Float32):Void;


	@:native("::nvgDegToRad")
	/**
	 * Converts degrees to radians.
	 */
	public static function degToRad(_deg:Float32):Float32;

	@:native("::nvgRadToDeg")
	/**
	 * Converts radians to degrees.
	 */
	public static function radToDeg(_rad:Float32):Float32;

	//
	// Images
	//
	// NanoVG allows you to load jpg, png, psd, tga, pic and gif files to be used for rendering.
	// In addition you can upload your own image. The image loading is provided by stb_image.
	// The parameter imageFlags is combination of flags defined in NVGimageFlags.

	@:native("::nvgCreateImage")
	/**
	 * Creates image by loading it from the disk from specified file name.
	 * Returns handle to the image.
	 */
	public static function createImage(_ctx:Pointer<NvgContext>, _filename:ConstPointer<Char>, _imageFlags:Int):Int;

	@:native("::nvgCreateImageMem")
	/**
	 * Creates image by loading it from the specified chunk of memory.
	 * Returns handle to the image.
	 */
	public static function createImageMem(_ctx:Pointer<NvgContext>, _data:Pointer<Char>, _ndata:Int):Int;

	@:native("::nvgCreateImageRGBA")
	/**
	 * Creates image from specified image data.
	 * Returns handle to the image.
	 */
	public static function createImageRGBA(_ctx:Pointer<NvgContext>, _w:Int, _h:Int, _data:Pointer<Char>):Int;

	@:native("::nvgUpdateImage")
	/**
	 * Updates image data specified by image handle.
	 */
	public static function updateImage(_ctx:Pointer<NvgContext>, _image:Int, _data:Pointer<Char>):Void;

	@:native("::nvgImageSize")
	/**
	 * Returns the dimensions of a created image.
	 */
	public static function imageSize(_ctx:Pointer<NvgContext>, _image:Int, _w:Pointer<Int>, _h:Pointer<Int>):Void;

	@:native("::nvgDeleteImage")
	/**
	 * Deletes created image.
	 */
	public static function deleteImage(_ctx:Pointer<NvgContext>, _image:Int):Void;

	//
	// Paints
	//
	// NanoVG supports four types of paints: linear gradient, box gradient, radial gradient and image pattern.
	// These can be used as paints for strokes and fills.

	@:native("::nvgLinearGradient")
	/**
	 * Creates and returns a linear gradient. Parameters (sx,sy)-(ex,ey) specify the start and end coordinates
	 * of the linear gradient, icol specifies the start color and ocol the end color.
	 * The gradient is transformed by the current transform when it is passed to nvgFillPaint() or nvgStrokePaint().
	 */
	public static function linearGradient(_ctx:Pointer<NvgContext>, _sx:Float32, _sy:Float32, _ex:Float32, _ey:Float32, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

	@:native("::nvgBoxGradient")
	/**
	 * Creates and returns a box gradient. Box gradient is a feathered rounded rectangle, it is useful for rendering
	 * drop shadows or highlights for boxes. Parameters (x,y) define the top-left corner of the rectangle,
	 * (w,h) define the size of the rectangle, r defines the corner radius, and f feather. Feather defines how blurry
	 * the border of the rectangle is. Parameter icol specifies the inner color and ocol the outer color of the gradient.
	 * The gradient is transformed by the current transform when it is passed to nvgFillPaint() or nvgStrokePaint().
	 */
	public static function boxGradient(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _w:Float32, _h:Float32, _r:Float32, _f:Float32, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

	@:native("::nvgRadialGradient")
	/**
	 * Creates and returns a radial gradient. Parameters (cx,cy) specify the center, inr and outr specify
	 * the inner and outer radius of the gradient, icol specifies the start color and ocol the end color.
	 * The gradient is transformed by the current transform when it is passed to nvgFillPaint() or nvgStrokePaint().
	 */
	public static function radialGradient(_ctx:Pointer<NvgContext>, _cx:Float32, _cy:Float32, _inr:Float32, _outr:Float32, _icol:NvgColor, _ocol:NvgColor):NvgPaint;

	@:native("::nvgImagePattern")
	/**
	 * Creates and returns an image patter. Parameters (ox,oy) specify the left-top location of the image pattern,
	 * (ex,ey) the size of one image, angle rotation around the top-left corner, image is handle to the image to render.
	 * The gradient is transformed by the current transform when it is passed to nvgFillPaint() or nvgStrokePaint().
	 */
	public static function imagePattern(_ctx:Pointer<NvgContext>, _ox:Float32, _oy:Float32, _ex:Float32, _ey:Float32, _angle:Float32, _image:Int, _alpha:Float32):NvgPaint;

	//
	// Scissoring
	//
	// Scissoring allows you to clip the rendering into a rectangle. This is useful for various
	// user interface cases like rendering a text edit or a timeline. 

	@:native("::nvgScissor")
	/**
	 * Sets the current scissor rectangle.
	 * The scissor rectangle is transformed by the current transform.
	 */
	public static function scissor(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _w:Float32, _h:Float32):Void;

	@:native("::nvgIntersectScissor")
	/**
	 * Intersects current scissor rectangle with the specified rectangle.
	 * The scissor rectangle is transformed by the current transform.
	 * Note: in case the rotation of previous scissor rect differs from
	 * the current one, the intersection will be done between the specified
	 * rectangle and the previous scissor rectangle transformed in the current
	 * transform space. The resulting shape is always rectangle.
	 */
	public static function intersectScissor(_ctx:Pointer<NvgContext>, x:Float, y:Float, w:Float, h:Float):Void;
	
	@:native("::nvgResetScissor")
	/**
	 * Reset and disables scissoring.
	 */
	public static function resetScissor(_ctx:Pointer<NvgContext>):Void;

	//
	// Paths
	//
	// Drawing a new shape starts with nvgBeginPath(), it clears all the currently defined paths.
	// Then you define one or more paths and sub-paths which describe the shape. The are functions
	// to draw common shapes like rectangles and circles, and lower level step-by-step functions,
	// which allow to define a path curve by curve.
	//
	// NanoVG uses even-odd fill rule to draw the shapes. Solid shapes should have counter clockwise
	// winding and holes should have counter clockwise order. To specify winding of a path you can
	// call nvgPathWinding(). This is useful especially for the common shapes, which are drawn CCW.
	//
	// Finally you can fill the path using current fill style by calling nvgFill(), and stroke it
	// with current stroke style by calling nvgStroke().
	//
	// The curve segments and sub-paths are transformed by the current transform.

	@:native("::nvgBeginPath")
	/**
	 * Clears the current path and sub-paths.
	 */
	public static function beginPath(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgMoveTo")
	/**
	 * Starts new sub-path with specified point as first point.
	 */
	public static function moveTo(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

	@:native("::nvgLineTo")
	/**
	 * Adds line segment from the last point in the path to the specified point.
	 */
	public static function lineTo(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32):Void;

	@:native("::nvgBezierTo")
	/**
	 * Adds cubic bezier segment from last point in the path via two control points to the specified point.
	 */
	public static function bezierTo(_ctx:Pointer<NvgContext>, _c1x:Float32, _c1y:Float32, _c2x:Float32, _c2y:Float32, _x:Float32, _y:Float32):Void;

	@:native("::nvgQuadTo")
	/**
	 * Adds an arc segment at the corner defined by the last path point, and two specified points.
	 */
	public static function quadTo(_ctx:Pointer<NvgContext>, _cx:Float32, _cy:Float32, _x:Float32, _y:Float32):Void;

	@:native("::nvgArcTo")
	/**
	 * Adds an arc segment at the corner defined by the last path point, and two specified points.
	 */
	public static function arcTo(_ctx:Pointer<NvgContext>, _x1:Float32, _y1:Float32, _x2:Float32, _y2:Float32, _radius:Float32):Void;

	@:native("::nvgClosePath")
	/**
	 * Closes current sub-path with a line segment.
	 */
	public static function closePath(_ctx:Pointer<NvgContext>):Void;
	
	@:native("::nvgPathWinding")
	/**
	 * Sets the current sub-path winding, see NvgWinding and NvgSolidity.
	 */
	public static function pathWinding(_ctx:Pointer<NvgContext>, _dir:Int):Void;

	@:native("::nvgArc")
	/**
	 * Creates new circle arc shaped sub-path. The arc center is at cx,cy, the arc radius is r,
	 * and the arc is drawn from angle a0 to a1, and swept in direction dir (NVG_CCW, or NVG_CW).
	 * Angles are specified in radians.
	 */
	public static function arc(_ctx:Pointer<NvgContext>, _cx:Float32, _cy:Float32, _r:Float32, _a0:Float32, _a1:Float32, _dir:Int):Void;

	@:native("::nvgRect")
	/**
	 * Creates new rectangle shaped sub-path.
	 */
	public static function rect(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _w:Float32, _h:Float32):Void;

	@:native("::nvgRoundedRect")
	/**
	 * Creates new rounded rectangle shaped sub-path.
	 */
	public static function roundedRect(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _w:Float32, _h:Float32, _r:Float32):Void;

	@:native("::nvgEllipse")
	/**
	 * Creates new ellipse shaped sub-path.
	 */
	public static function ellipse(_ctx:Pointer<NvgContext>, _cx:Float32, _cy:Float32, _rx:Float32, _ry:Float32):Void;

	@:native("::nvgCircle")
	/**
	 * Creates new circle shaped sub-path.
	 */
	public static function circle(_ctx:Pointer<NvgContext>, _cx:Float32, _cy:Float32, _r:Float32):Void;

	@:native("::nvgFill")
	/**
	 * Fills the current path with current fill style.
	 */
	public static function fill(_ctx:Pointer<NvgContext>):Void;

	@:native("::nvgStroke")
	/**
	 * Fills the current path with current stroke style.
	 */
	public static function stroke(_ctx:Pointer<NvgContext>):Void;

	//
	// Text
	//
	// NanoVG allows you to load .ttf files and use the font to render text.
	//
	// The appearance of the text can be defined by setting the current text style
	// and by specifying the fill color. Common text and font settings such as
	// font size, letter spacing and text align are supported. Font blur allows you
	// to create simple text effects such as drop shadows.
	//
	// At render time the font face can be set based on the font handles or name.
	//
	// Font measure functions return values in local space, the calculations are
	// carried in the same resolution as the final rendering. This is done because
	// the text glyph positions are snapped to the nearest pixels sharp rendering.
	//
	// The local space means that values are not rotated or scale as per the current
	// transformation. For example if you set font size to 12, which would mean that
	// line height is 16, then regardless of the current scaling and rotation, the
	// returned line height is always 16. Some measures may vary because of the scaling
	// since aforementioned pixel snapping.
	//
	// While this may sound a little odd, the setup allows you to always render the
	// same way regardless of scaling. I.e. following works regardless of scaling:
	//
	//		var txt:String = "Text me up.";
	//		Nvg.textBounds(vg, x,y, txt.c_str(), NULL, bounds);
	//		Nvg.beginPath(vg);
	//		Nvg.roundedRect(vg, bounds[0],bounds[1], bounds[2]-bounds[0], bounds[3]-bounds[1]);
	//		Nvg.fill(vg);
	//
	// Note: currently only solid color fill is supported for text.

	@:native("::nvgCreateFont")
	/**
	 * Creates font by loading it from the disk from specified file name.
	 * Returns handle to the font.
	 */
	public static function createFont(_ctx:Pointer<NvgContext>, _name:ConstPointer<Char>, _filename:ConstPointer<Char>):Int;

	@:native("::nvgCreateFontMem")
	/**
	 * Creates image by loading it from the specified memory chunk.
	 * Returns handle to the font.
	 */
	public static function createFontMem(_ctx:Pointer<NvgContext>, _name:ConstPointer<Char>, _data:Pointer<Char>, _ndata:Int, _freeData:Int):Int;

	@:native("::nvgFindFont")
	/**
	 * Finds a loaded font of specified name, and returns handle to it, or -1 if the font is not found.
	 */
	public static function findFont(_ctx:Pointer<NvgContext>, _name:ConstPointer<Char>):Int;

	@:native("::nvgFontSize")
	/**
	 * Sets the font size of current text style.
	 */
	public static function fontSize(_ctx:Pointer<NvgContext>, _size:Float32):Void;

	@:native("::nvgFontBlur")
	/**
	 * Sets the blur of current text style.
	 */
	public static function fontBlur(_ctx:Pointer<NvgContext>, _blur:Float32):Void;

	@:native("::nvgTextLetterSpacing")
	/**
	 * Sets the letter spacing of current text style.
	 */
	public static function textLetterSpacing(_ctx:Pointer<NvgContext>, _spacing:Float32):Void;

	@:native("::nvgTextLineHeight")
	/**
	 * Sets the proportional line height of current text style. 
	 * The line height is specified as multiple of font size. 
	 */
	public static function textLineHeight(_ctx:Pointer<NvgContext>, _lineHeight:Float32):Void;

	@:native("::nvgTextAlign")
	/**
	 * Sets the text align of current text style, see NvgAlign for options.
	 */
	public static function textAlign(_ctx:Pointer<NvgContext>, _align:Int):Void;

	@:native("::nvgFontFaceId")
	/**
	 * Sets the font face based on specified id of current text style.
	 */
	public static function fontFaceId(_ctx:Pointer<NvgContext>, _font:Int):Void;

	@:native("::nvgFontFace")
	/**
	 * Sets the font face based on specified name of current text style.
	 */
	public static function fontFace(_ctx:Pointer<NvgContext>, _font:ConstPointer<Char>):Void;

	@:native("::nvgText")
	/**
	 * Draws text string at specified location.
	 * If end is specified only the sub-string up to the end is drawn.
	 */
	public static function text(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>):Float32;

	@:native("::nvgTextBox")
	/**
	 * Draws multi-line text string at specified location wrapped at the specified width.
	 * If end is specified only the sub-string up to the end is drawn.
	 * White space is stripped at the beginning of the rows,
	 * the text is split at word boundaries or when new-line characters are encountered.
	 * Words longer than the max width are slit at nearest character (i.e. no hyphenation).
	 */
	public static function textBox(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _breakRowWidth:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>):Void;

	@:native("::nvgTextBounds")
	/**
	 * Measures the specified text string. Parameter bounds should be a pointer to float[4],
	 * if the bounding box of the text should be returned. The bounds value are [xmin,ymin, xmax,ymax]
	 * Returns the horizontal advance of the measured text (i.e. where the next character should drawn).
	 * Measured values are returned in local coordinate space.
	 */
	public static function textBounds(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _bounds:Pointer<Float32>):Float32;

	@:native("::nvgTextBoxBounds")
	/**
	 * Measures the specified multi-text string. Parameter bounds should be a pointer to float[4],
	 * if the bounding box of the text should be returned. The bounds value are [xmin,ymin, xmax,ymax]
	 * Measured values are returned in local coordinate space.
	 */
	public static function textBoxBounds(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _breakRowWidth:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _bounds:Pointer<Float32>):Void;

	@:native("::nvgTextGlyphPositions")
	/**
	 * Calculates the glyph x positions of the specified text.
	 * If end is specified only the sub-string will be used.
	 * Measured values are returned in local coordinate space.
	 */
	public static function textGlyphPositions(_ctx:Pointer<NvgContext>, _x:Float32, _y:Float32, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _positions:Pointer<NvgGlyphPosition>, _maxPositions:Int):Int;

	@:native("::nvgTextMetrics")
	/**
	 * Returns the vertical metrics based on the current text style.
	 * Measured values are returned in local coordinate space.
	 */
	public static function textMetrics(_ctx:Pointer<NvgContext>, _ascender:Pointer<Float32>, _descender:Pointer<Float32>, _lineh:Pointer<Float32>):Void;

	@:native("::nvgTextBreakLines")
	/**
	 * Breaks the specified text into lines. If end is specified only the sub-string will be used.
	 * White space is stripped at the beginning of the rows,
	 * the text is split at word boundaries or when new-line characters are encountered.
	 * Words longer than the max width are slit at nearest character (i.e. no hyphenation).
	 */
	public static function textBreakLines(_ctx:Pointer<NvgContext>, _string:ConstPointer<Char>, _end:ConstPointer<Char>, _breakRowWidth:Float32, _rows:Pointer<NvgTextRow>, _maxRows:Int):Int;
}

