# config.mk
#
# Product-specific compile-time definitions.
#
# TODO(b/124534788): Temporarily allow eng and debug LOCAL_MODULE_TAGS

BOARD_SYSTEMSDK_VERSIONS := 30

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_NO_KERNEL := false

-include $(QCPATH)/common/lahaina/BoardConfigVendor.mk

USE_OPENGL_RENDERER := true

#Generate DTBO image
BOARD_KERNEL_SEPARATED_DTBO := true

### Dynamic partition Handling
# Define the Dynamic Partition sizes and groups.
BOARD_SUPER_PARTITION_SIZE := 6442450944
# Enable DTBO for recovery image
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 6438256640
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := vendor odm
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x06400000

TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
AB_OTA_PARTITIONS ?= boot vendor_boot vendor odm dtbo vbmeta
BOARD_EXT4_SHARE_DUP_BLOCKS := true

# Defines for enabling A/B builds
AB_OTA_UPDATER := true
TARGET_RECOVERY_FSTAB := device/nothing/phone1/recovery.fstab

BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1


BOARD_USES_METADATA_PARTITION := true

TARGET_COPY_OUT_VENDOR := vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 48318382080
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_DTBOIMG_PARTITION_SIZE := 0x1800000
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

ifeq "$(KERNEL_DEFCONFIG)" "vendor/$(TARGET_BOARD_PLATFORM)-qgki_defconfig"
BOARD_KERNEL_BINARIES := kernel kernel-gki
endif

ifeq (,$(findstring -qgki-debug_defconfig,$(KERNEL_DEFCONFIG)))
$(warning #### GKI config ####)
VENDOR_RAMDISK_KERNEL_MODULES := proxy-consumer.ko \
				rpmh-regulator.ko \
				refgen.ko \
				stub-regulator.ko \
                                clk-dummy.ko \
				clk-qcom.ko \
				clk-rpmh.ko \
				gcc-lahaina.ko \
				gcc-shima.ko \
				gcc-yupik.ko \
				qnoc-qos.ko \
				qnoc-lahaina.ko \
				qnoc-shima.ko \
				qnoc-yupik.ko \
				cmd-db.ko \
				qcom_rpmh.ko \
				rpmhpd.ko \
				icc-bcm-voter.ko \
				icc-rpmh.ko \
				pinctrl-msm.ko \
				pinctrl-lahaina.ko \
				pinctrl-shima.ko \
				pinctrl-yupik.ko \
				_qcom_scm.ko \
				secure_buffer.ko \
				iommu-logger.ko \
				qcom-arm-smmu-mod.ko \
				phy-qcom-ufs.ko \
				phy-qcom-ufs-qrbtc-sdm845.ko \
				phy-qcom-ufs-qmp-v4-lahaina.ko\
				phy-qcom-ufs-qmp-v4-yupik.ko\
				ufshcd-crypto-qti.ko \
				crypto-qti-common.ko \
				crypto-qti-hwkm.ko \
				hwkm.ko \
				ufs-qcom.ko \
				qbt_handler.ko \
				qcom_watchdog.ko \
				qcom-pdc.ko \
				qpnp-power-on.ko \
				msm-poweroff.ko \
				sdhci-msm.ko \
				cqhci.ko \
				cqhci-crypto.ko \
				cqhci-crypto-qti.ko \
				memory_dump_v2.ko
else
$(warning #### QGKI config ####)
endif

# Append the list of .ko that needs to be included as a part of vendor-ramdisk
# only in QGKI variants, but not in GKI.
ifneq "$(KERNEL_DEFCONFIG)" "vendor/$(TARGET_BOARD_PLATFORM)-gki_defconfig"
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(KERNEL_MODULES_OUT)/msm_drm.ko
endif

BOARD_DO_NOT_STRIP_VENDOR_MODULES := true
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true

BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket pcie_ports=compat loop.max_part=7 iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_USES_UNCOMPRESSED_KERNEL := false

BOARD_USES_GENERIC_AUDIO := true
BOARD_QTI_CAMERA_32BIT_ONLY := true
TARGET_NO_RPC := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

#Disable appended dtb.
TARGET_KERNEL_APPEND_DTB := false
TARGET_COMPILE_WITH_MSM_KERNEL := true

#Enable dtb in boot image and boot image header version 3 support.
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

#Add non-hlos files to ota packages
ADD_RADIO_FILES := true


# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

#flag for qspm compilation
TARGET_USES_QSPM := true

#namespace definition for librecovery_updater
#differentiate legacy 'sg' or 'bsg' framework
SOONG_CONFIG_NAMESPACES += ufsbsg

SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

#namespace definition for perf
SOONG_CONFIG_NAMESPACES += perf
SOONG_CONFIG_perf += ioctl
SOONG_CONFIG_perf_ioctl := true

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS := TEMPORARY_DISABLE_PATH_RESTRICTIONS
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PREBUILT_ELF_FILES := true

# KEYSTONE(If43215c7f384f24e7adeeabdbbb1790f174b2ec1,b/147756744)
BUILD_BROKEN_NINJA_USES_ENV_VARS += SDCLANG_AE_CONFIG SDCLANG_CONFIG SDCLANG_SA_ENABLE

BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
