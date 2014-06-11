CONF = release
CFLAGS=
ifeq ($(CONF), debug)
	CFLAGS+= -debug
endif

HX=haxe -main Demo -cp ../Common
LIME=haxelib run lime build demo.lime.xml

all:
	$(LIME) windows -32 $(CFLAGS)

.PHONY: all