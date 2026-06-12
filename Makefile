SUBDIRS := ee_apartment_block marine_container police_station police_station_cs \
           single_car_garage slawojka

.PHONY: all previews help $(SUBDIRS)

help:
	@echo "Usage:"
	@echo "  make all        Regenerate all STL files across all projects"
	@echo "  make previews   Render PNG previews for all models"
	@echo "  make <dir>      Build a single project (e.g. make slawojka)"
	@echo ""
	@echo "  Each project directory also has its own Makefile."

all previews:
	@for d in $(SUBDIRS); do $(MAKE) -C $$d $@; done

$(SUBDIRS):
	$(MAKE) -C $@
