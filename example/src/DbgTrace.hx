package;
import cpp.Pointer;
import cpp.Char;
import cpp.ConstPointer;
import cpp.Pointer;
import hxnanovg.Nvg;

using cpp.NativeString;

/**
 * ...
 * @author Hortobágyi Tamás
 */
class DbgTrace
{
	var text:String = "";
	
	var fontID:Int;
	
	public function new(fontID:Int) 
	{
		this.fontID = fontID;
	}
	
	public function log(s:String)
	{
		text += (text.length > 0 ? "\n" : "") + s;
	}
	
	public function render(vg:Pointer<NvgContext>)
	{
		if (text.length > 0)
		{
			Nvg.fontSize(vg, 14.0);
			Nvg.fontFaceId(vg, fontID);
			Nvg.fillColor(vg, Nvg.rgb(255, 0, 0));
			
			Nvg.textAlign(vg, NvgAlign.ALIGN_LEFT | NvgAlign.ALIGN_TOP);
			Nvg.textBox(vg, 10, 100, 400, text.c_str(), untyped __cpp__("NULL"));
		}
	}
}