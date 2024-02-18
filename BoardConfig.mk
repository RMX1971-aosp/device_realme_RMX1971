#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/RMX1971

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 114898743296
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824

PARTITIONS_LIST := cache system userdata vendor

$(foreach p, $(call to-upper, $(PARTITIONS_LIST)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(if $(filter-out cache userdata,$(p)), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p)))))

include vendor/realme/RMX1971/BoardConfigVendor.mk