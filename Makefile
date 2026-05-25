OPENSCAD ?= /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

SCAD  := $(wildcard *.scad)
STLS  := $(SCAD:.scad=.stl)

.PHONY: all help
.DEFAULT_GOAL := help

help:
	@echo "Usage:"
	@echo "  make all                  Regenerate all STL files from SCAD sources"
	@echo "  make <name>.stl           Regenerate a single STL (e.g. make slawojka.stl)"
	@echo ""
	@echo "Options:"
	@echo "  OPENSCAD=<path>           Override OpenSCAD binary (default: $(OPENSCAD))"

all: $(STLS)

%.stl: %.scad
	$(OPENSCAD) -o $@ $<
