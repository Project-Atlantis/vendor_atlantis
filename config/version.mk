# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
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

ATLANTIS_MOD_VERSION = EXPERIMENTAL
ATLANTIS_BUILD_TYPE := UNOFFICIAL
ATLANTIS_BUILD_ZIP_TYPE := VANILLA

ifeq ($(ATLANTIS_GAPPS), true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
    ATLANTIS_BUILD_ZIP_TYPE := GAPPS
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(ATLANTIS_OFFICIAL), true)
   LIST = $(shell cat infrastructure/devices/atlantis.devices | awk '$$1 != "#" { print $$2 }')
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      ATLANTIS_BUILD_TYPE := OFFICIAL

PRODUCT_PACKAGES += \
    Updater

    endif
    ifneq ($(IS_OFFICIAL), true)
       ATLANTIS_BUILD_TYPE := UNOFFICIAL
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

ATLANTIS_VERSION := Atlantis-$(ATLANTIS_MOD_VERSION)-$(CURRENT_DEVICE)-$(ATLANTIS_BUILD_TYPE)-$(shell date -u +%Y%m%d)-$(ATLANTIS_BUILD_ZIP_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.atlantis.version=$(ARLANTIS_VERSION) \
  ro.atlantis.releasetype=$(ATLANTIS_BUILD_TYPE) \
  ro.atlantis.ziptype=$(ATLANTIS_BUILD_ZIP_TYPE) \
  ro.modversion=$(ATLANTIS_MOD_VERSION)

ATLANTIS_DISPLAY_VERSION := Atlantis-$(ATLANTIS_MOD_VERSION)-$(ATLANTIS_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.atlantis.display.version=$(ATLANTIS_DISPLAY_VERSION)
