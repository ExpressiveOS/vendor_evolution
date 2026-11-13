PRODUCT_VERSION_MAJOR = 17
PRODUCT_VERSION_MINOR = 0

# Official or Unofficial. For one release it falls back to the old EVO_BUILD_TYPE
# when only that one is set (a kit or script from before 1.1); the fallback goes in 1.2.
EXPRESSIVE_BUILD_TYPE ?= $(or $(EVO_BUILD_TYPE),Unofficial)

ifeq ($(EXPRESSIVE_BUILD_TYPE),Official)
else ifeq ($(EXPRESSIVE_BUILD_TYPE),Unofficial)
else
$(error EXPRESSIVE_BUILD_TYPE must be Official or Unofficial. Current value: $(EXPRESSIVE_BUILD_TYPE))
endif

# ExpressiveOS's own version, which the zip name, Settings and the Updater show.
EXPRESSIVE_VERSION := 1.2

ifeq ($(WITH_GMS),true)
EXPRESSIVE_MODVERSION := $(EXPRESSIVE_VERSION)
else
EXPRESSIVE_MODVERSION := $(EXPRESSIVE_VERSION)-Vanilla
endif

# The old names, kept for one release as plain aliases so a reverted kit (a manifest
# revert does not revert the kit) still reads them. They go in 1.2.
EVO_VERSION := $(EXPRESSIVE_MODVERSION)
EVO_BUILD_TYPE := $(EXPRESSIVE_BUILD_TYPE)

# The build's own date, the one build.prop carries: soong_ui writes BUILD_DATETIME
# (or now) to BUILD_DATETIME_FILE before product config, and BUILD_DATETIME itself
# can't be read here. Both make passes of a build then name the same zip, even
# across midnight.
EXPRESSIVE_DATE := $(shell f=$(BUILD_DATETIME_FILE); if [ -s "$$f" ]; then date -ud @$$(cat "$$f") +%Y%m%d; else date -u +%Y%m%d; fi)

# Internal version
LINEAGE_VERSION := ExpressiveOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(EXPRESSIVE_DATE)-$(LINEAGE_BUILD)-$(EXPRESSIVE_MODVERSION)-$(EXPRESSIVE_BUILD_TYPE)

# Display version
LINEAGE_DISPLAY_VERSION := v$(EXPRESSIVE_MODVERSION)-$(EXPRESSIVE_DATE)

# Version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.expressiveos.build.type=$(EXPRESSIVE_BUILD_TYPE) \
    ro.expressiveos.build.version=$(LINEAGE_VERSION) \
    ro.expressiveos.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.expressiveos.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(EXPRESSIVE_MODVERSION)
