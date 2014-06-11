package; 

import hxnanovg.NVG;

class Demo {

	public function new () {}

	public function ready (lime:lime.Lime):Void {
        var ctx = NVG.createGL(512, 512, 0);
        //NVG.deleteGL(ctx);

        trace(ctx);
    }
    private function render ():Void {

    }
}