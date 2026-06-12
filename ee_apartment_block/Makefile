OPENSCAD    ?= /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
IMGSIZE     ?= 800,600
COLORSCHEME ?= BeforeDawn
CAMERA      := 0,0,0,55,0,25,500

SCAD := $(wildcard *.scad)
STLS := $(SCAD:.scad=.stl)
PNGS := $(SCAD:.scad=.png)

.PHONY: all previews
.DEFAULT_GOAL := all

all: $(STLS)

previews: $(PNGS)

%.stl: %.scad
	$(OPENSCAD) -o $@ $<

%.png: %.scad
	$(OPENSCAD) --render --imgsize=$(IMGSIZE) \
		--camera=$(CAMERA) --autocenter --viewall \
		--colorscheme=$(COLORSCHEME) \
		-o $@ $<
