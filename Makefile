OPENSCAD    ?= /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
IMGSIZE     ?= 800,600
COLORSCHEME ?= BeforeDawn
CAMERA      := 0,0,0,55,0,25,500

SCAD  := $(wildcard *.scad)
STLS  := $(SCAD:.scad=.stl)
PNGS  := $(SCAD:.scad=.png)

.PHONY: all previews help
.DEFAULT_GOAL := help

help:
	@echo "Usage:"
	@echo "  make all                  Regenerate all STL files from SCAD sources"
	@echo "  make previews             Render PNG previews for all models"
	@echo "  make <name>.stl           Regenerate a single STL (e.g. make slawojka.stl)"
	@echo "  make <name>.png           Render preview for a single model"
	@echo ""
	@echo "Options:"
	@echo "  OPENSCAD=<path>           Override OpenSCAD binary (default: $(OPENSCAD))"
	@echo "  COLORSCHEME=<name>        Preview color scheme (default: $(COLORSCHEME))"
	@echo "  IMGSIZE=<w,h>             Preview image size (default: $(IMGSIZE))"

all: $(STLS)

previews: $(PNGS)

%.stl: %.scad
	$(OPENSCAD) -o $@ $<

%.png: %.scad
	$(OPENSCAD) --render --imgsize=$(IMGSIZE) \
		--camera=$(CAMERA) --autocenter --viewall \
		--colorscheme=$(COLORSCHEME) \
		-o $@ $<
