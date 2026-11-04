#
# Copyright (C) 2016 The CyanogenMod Project
#               2017-2024 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# No default boot animation: a product that installs bootanimation.zip sets
# TARGET_BOOTANIMATION to the zip it ships (ExpressiveOS's products get theirs from
# the build kit's bootanimation.mk, through vendor/extra/product.mk). Without one
# the build stops here instead of falling back to another ROM's animation.
ifeq ($(TARGET_BOOTANIMATION),)
ifneq ($(filter bootanimation.zip,$(PRODUCT_PACKAGES)),)
    $(error $(TARGET_PRODUCT) installs bootanimation.zip but sets no TARGET_BOOTANIMATION. Set it to the boot animation zip to ship (ExpressiveOS's build kit does, with bootanimation/apply-bootanim.sh))
endif
endif

include $(CLEAR_VARS)
LOCAL_MODULE := bootanimation.zip
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/media

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_BOOTANIMATION)
	@cp $(TARGET_BOOTANIMATION) $@

include $(CLEAR_VARS)

BOOTANIMATION_SYMLINK := $(TARGET_OUT_PRODUCT)/media/bootanimation-dark.zip
$(BOOTANIMATION_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@mkdir -p $(dir $@)
	$(hide) ln -sf bootanimation.zip $@

ALL_DEFAULT_INSTALLED_MODULES += $(BOOTANIMATION_SYMLINK)
