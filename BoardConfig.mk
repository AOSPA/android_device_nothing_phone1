# config.mk
#
# Product-specific compile-time definitions.
#
# TODO(b/124534788): Temporarily allow eng and debug LOCAL_MODULE_TAGS

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76

# AVB - Disable Verification
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# AVB - Recovery
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# AVB - VBMeta System
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Boot
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

# Build
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_RECOVERY_DTBO := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_DO_NOT_STRIP_VENDOR_MODULES := true
BOARD_KERNEL_CMDLINE := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    swiotlb=0 \
    loop.max_part=7 \
    cgroup.memory=nokmem,nosocket \
    pcie_ports=compat \
    iptable_raw.raw_before_defrag=1 \
    ip6table_raw.raw_before_defrag=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE    := 4096
KERNEL_DEFCONFIG := phone1_defconfig

# Kernel Modules
KERNEL_TECHPACK_OUT += $(OUT_DIR)/target/product/$(PRODUCT_DEVICE)/obj/kernel/msm-$(TARGET_KERNEL_VERSION)/techpack
BOARD_VENDOR_KERNEL_MODULES += \
    $(KERNEL_TECHPACK_OUT)/display/msm/msm_drm.ko \
    $(KERNEL_TECHPACK_OUT)/camera/drivers/camera.ko \
    $(KERNEL_TECHPACK_OUT)/audio/dsp/codecs/native_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/dsp/q6_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/dsp/adsp_loader_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/dsp/q6_notifier_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/dsp/q6_pdr_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/ipc/apr_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/soc/pinctrl_wcd_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/soc/snd_event_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/soc/pinctrl_lpi_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/soc/swr_ctrl_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/soc/swr_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/machine_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/bolero/va_macro_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/bolero/tx_macro_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/bolero/bolero_cdc_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/bolero/wsa_macro_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/bolero/rx_macro_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/tfa98xx/tfa98xx_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/mbhc_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wcd937x/wcd937x_slave_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wcd937x/wcd937x_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wcd9xxx_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/stub_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wcd938x/wcd938x_slave_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wcd938x/wcd938x_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/swr_dmic_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/swr_haptics_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wsa883x/wsa883x_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/wcd_core_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/codecs/hdmi_dlkm.ko \
    $(KERNEL_TECHPACK_OUT)/audio/asoc/platform_dlkm.ko

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(KERNEL_TECHPACK_OUT)/display/msm/msm_drm.ko

# Partitions - A/B
AB_OTA_PARTITIONS := boot dtbo odm product system system_ext vendor vendor_boot vbmeta vbmeta_system
AB_OTA_UPDATER := true

# Partitions - Dynamic
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := product system system_ext odm vendor

# Partitions - Filesystems
BOARD_EXT4_SHARE_DUP_BLOCKS := true
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_F2FS := true

# Partitions - Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions - Paths
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor

# Partitions - Sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x1800000
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 32)
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 6438256640
BOARD_SUPER_PARTITION_SIZE := 6442450944
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000

# Radio
ADD_RADIO_FILES := false

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_FSTAB := device/nothing/phone1/init/fstab.default

# UFS
#namespace definition for librecovery_updater
#differentiate legacy 'sg' or 'bsg' framework
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg
