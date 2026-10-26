PRODUCT_VERSION_MAJOR = 17
PRODUCT_VERSION_MINOR = 0

# Increase EVO Version with each major release.
EVO_VERSION_BASE := 12.3
EVO_BUILD_TYPE ?= Unofficial

ifeq ($(EVO_BUILD_TYPE),Official)
else ifeq ($(EVO_BUILD_TYPE),Unofficial)
else
$(error EVO_BUILD_TYPE must be Official or Unofficial. Current value: $(EVO_BUILD_TYPE))
endif

# ExpressiveOS's own version, which the zip name, Settings and the Updater show.
# EVO_VERSION_BASE stays: it's the Evolution X release this tree is built on.
EXPRESSIVE_VERSION := 1.0

ifeq ($(WITH_GMS),true)
EVO_VERSION := $(EXPRESSIVE_VERSION)
else
EVO_VERSION := $(EXPRESSIVE_VERSION)-Vanilla
endif

# The build's own date, the one build.prop carries: soong_ui writes BUILD_DATETIME
# (or now) to BUILD_DATETIME_FILE before product config, and BUILD_DATETIME itself
# can't be read here. Both make passes of a build then name the same zip, even
# across midnight.
EXPRESSIVE_DATE := $(shell f=$(BUILD_DATETIME_FILE); if [ -s "$$f" ]; then date -ud @$$(cat "$$f") +%Y%m%d; else date -u +%Y%m%d; fi)

# Internal version
LINEAGE_VERSION := ExpressiveOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(EXPRESSIVE_DATE)-$(LINEAGE_BUILD)-$(EVO_VERSION)-$(EVO_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := v$(EVO_VERSION)-$(EXPRESSIVE_DATE)

# Evolution X version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.evolution.build.type=$(EVO_BUILD_TYPE) \
    ro.evolution.build.version=$(LINEAGE_VERSION) \
    ro.evolution.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.evolution.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(EVO_VERSION)
