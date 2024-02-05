#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/RMX1971

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xA90000 androidboot.hardware=qcom androidboot.console=ttyMSM0 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 service_locator.enable=1 androidboot.configfs=true androidboot.usbcontroller=a600000.dwc3 swiotlb=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_ARCH := arm64
ifeq ($(TARGET_PREBUILT_KERNEL),)
  TARGET_KERNEL_CLANG_COMPILE := true
	TARGET_KERNEL_CONFIG := RMX1971_defconfig
  TARGET_KERNEL_SOURCE := kernel/realme/RMX1971
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 114898743296
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824

PARTITIONS_LIST := cache system userdata vendor

$(foreach p, $(call to-upper, $(PARTITIONS_LIST)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(if $(filter-out cache userdata,$(p)), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p)))))

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

include vendor/realme/RMX1971/BoardConfigVendor.mk