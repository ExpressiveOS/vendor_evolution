# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# Evolution X OTA update package

LINEAGE_TARGET_PACKAGE := $(PRODUCT_OUT)/$(LINEAGE_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

# ExpressiveOS keeps the target-files zip the package is made from: every incremental
# OTA from this build starts from it. Only the unpacked copy and its file list go.
# The zip is made before the package, because ota_from_target_files may rewrite
# META/dynamic_partitions_info.txt in the unpacked copy (disable_ublk) while it runs.
$(INTERNAL_OTA_PACKAGE_TARGET): | $(BUILT_TARGET_FILES_PACKAGE)
$(LINEAGE_TARGET_PACKAGE): $(INTERNAL_OTA_PACKAGE_TARGET) $(BUILT_TARGET_FILES_PACKAGE)
	$(hide) mv -f $(INTERNAL_OTA_PACKAGE_TARGET) $(LINEAGE_TARGET_PACKAGE)
	$(hide) $(SHA256) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/lineage/build/tools/createjson.py $(TARGET_DEVICE) $(PRODUCT_OUT) $(LINEAGE_VERSION).zip $(TARGET_BUILD_VARIANT) $(WITH_GMS)
	$(hide) rm -rf $(patsubst %.zip,%,$(BUILT_TARGET_FILES_PACKAGE)) $(BUILT_TARGET_FILES_DIR)
	$(hide) ./vendor/lineage/build/tasks/ascii_output.sh
	@echo "Package Complete: $(LINEAGE_TARGET_PACKAGE)" >&2

.PHONY: evolution
evolution: $(LINEAGE_TARGET_PACKAGE) $(DEFAULT_GOAL)
