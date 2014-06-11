package hxnanovg;

class NVG {

	public static var createGL:Int->Int->Int->Dynamic = 
		cpp.Lib.load("hx-nanovg", "hx_nvgCreateGL", 3);
	
	public static var deleteGL:Dynamic->Void = 
		cpp.Lib.load("hx-nanovg", "hx_nvgDeleteGL", 1);

	
}

