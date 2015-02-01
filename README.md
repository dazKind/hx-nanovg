
###Haxe Hxcpp-externs for https://github.com/memononen/nanovg


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

#### Included Demo:
![hx-nanovg](http://developium.net/pics/nanovg2.png)

#### Include Example from the ported original NanoVG (not perfect):
![hx-nanovg example](https://dl.dropboxusercontent.com/u/79150615/nanovg_example_in_haxe.png)

#### Notes:
* Demo uses Lime (stencil buffer enabled!)
* uses https://github.com/native-toolkit/glew as submodule
* check out nanovg to /deps/nanovg


---
#### From the NanoVG README

NanoVG is small antialiased vector graphics rendering library for OpenGL. It has lean API modeled after HTML5 canvas API. It is aimed to be a practical and fun toolset for building scalable user interfaces and visualizations.

![nanvg](https://github.com/memononen/nanovg/raw/master/example/screenshot-01.png?raw=true)

