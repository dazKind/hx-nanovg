
Attention, this repo is old. Please refer to the latest implementation at: https://github.com/snowkit/linc_nanovg
---


###Haxe Hxcpp-externs for https://github.com/memononen/nanovg

Please note, that this library uses haxe 3.2 features for the binding. So right now(Feb 2015) you will need the development version of haxe&hxcpp till haxe 3.2 is released to make it work. Thanks.

You may install using:
```
haxelib git hx-nanovg https://github.com/dazKind/hx-nanovg
cd <your haxelib-dir>/hx-nanovg/git/
git submodule update --init
```
or
```
git clone https://github.com/dazKind/hx-nanovg --recursive
haxelib dev hx-nanovg hx-nanovg
```
then clone **https://github.com/memononen/nanovg** into **/deps/nanovg**.

#### Included Demo:
![hx-nanovg](http://developium.net/pics/nanovg2.png)

#### Notes:
* Demo uses Lime (stencil buffer enabled!)
* uses https://github.com/native-toolkit/glew as submodule


---
#### From the NanoVG README

NanoVG is small antialiased vector graphics rendering library for OpenGL. It has lean API modeled after HTML5 canvas API. It is aimed to be a practical and fun toolset for building scalable user interfaces and visualizations.

![nanvg](https://github.com/memononen/nanovg/raw/master/example/screenshot-01.png?raw=true)

