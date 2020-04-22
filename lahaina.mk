BUILD_BROKEN_DUP_RULES := true
TEMPORARY_DISABLE_PATH_RESTRICTIONS := true

ALLOW_MISSING_DEPENDENCIES=true

# Default Android A/B configuration
ENABLE_AB ?= true

ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# For QSSI builds, we should skip building the system image. Instead we build the
# "non-system" images (that we support).

PRODUCT_BUILD_SYSTEM_IMAGE := false
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := true
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_SYSTEM_EXT_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
ifeq ($(ENABLE_AB), true)
PRODUCT_BUILD_CACHE_IMAGE := false
else
PRODUCT_BUILD_CACHE_IMAGE := true
endif
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_USERDATA_IMAGE := true

# Also, since we're going to skip building the system image, we also skip
# building the OTA package. We'll build this at a later step.
TARGET_SKIP_OTA_PACKAGE := true

# Enable AVB 2.0
BOARD_AVB_ENABLE := true

# Set SYSTEMEXT_SEPARATE_PARTITION_ENABLE if was not already set (set earlier via build.sh).
SYSTEMEXT_SEPARATE_PARTITION_ENABLE ?= false

###########
#QMAA flags starts
###########
#QMAA global flag for modular architecture
#true means QMAA is enabled for system
#false means QMAA is disabled for system

TARGET_USES_QMAA := false
#QMAA tech team flag to override global QMAA per tech team
#true means overriding global QMAA for this tech area
#false means using global, no override
TARGET_USES_QMAA_OVERRIDE_RPMB	:= true
TARGET_USES_QMAA_OVERRIDE_DISPLAY := true
TARGET_USES_QMAA_OVERRIDE_AUDIO   := true
TARGET_USES_QMAA_OVERRIDE_VIDEO   := true
TARGET_USES_QMAA_OVERRIDE_CAMERA  := true
TARGET_USES_QMAA_OVERRIDE_GFX     := true
TARGET_USES_QMAA_OVERRIDE_WFD     := true
TARGET_USES_QMAA_OVERRIDE_GPS     := true
TARGET_USES_QMAA_OVERRIDE_ANDROID_RECOVERY := true
TARGET_USES_QMAA_OVERRIDE_ANDROID_CORE := true
TARGET_USES_QMAA_OVERRIDE_WLAN    := true
TARGET_USES_QMAA_OVERRIDE_DPM  := true
TARGET_USES_QMAA_OVERRIDE_BLUETOOTH   := true
TARGET_USES_QMAA_OVERRIDE_FM  := true
TARGET_USES_QMAA_OVERRIDE_CVP  := true
TARGET_USES_QMAA_OVERRIDE_FASTCV  := true
TARGET_USES_QMAA_OVERRIDE_SCVE  := true
TARGET_USES_QMAA_OVERRIDE_OPENVX  := true
TARGET_USES_QMAA_OVERRIDE_DIAG := true
TARGET_USES_QMAA_OVERRIDE_FTM := true
TARGET_USES_QMAA_OVERRIDE_DATA := true
TARGET_USES_QMAA_OVERRIDE_DATA_NET := true
TARGET_USES_QMAA_OVERRIDE_MSM_BUS_MODULE := true
TARGET_USES_QMAA_OVERRIDE_KERNEL_TESTS_INTERNAL := true
TARGET_USES_QMAA_OVERRIDE_MSMIRQBALANCE := true
TARGET_USES_QMAA_OVERRIDE_VIBRATOR := true
TARGET_USES_QMAA_OVERRIDE_DRM     := true
TARGET_USES_QMAA_OVERRIDE_KMGK := true
TARGET_USES_QMAA_OVERRIDE_VPP := true
TARGET_USES_QMAA_OVERRIDE_GP := true

#Full QMAA HAL List
QMAA_HAL_LIST := audio video camera display sensors gps

###########
#QMAA flags ends

#Suppot to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

#####Dynamic partition Handling
###
#### Turning this flag to TRUE will enable dynamic partition/super image creation.
PRODUCT_BUILD_ODM_IMAGE := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_PACKAGES += fastbootd
# Add default implementation of fastboot HAL.
PRODUCT_PACKAGES += android.hardware.fastboot@1.0-impl-mock

ifeq ($(ENABLE_AB),true)
ifeq ($(SYSTEMEXT_SEPARATE_PARTITION_ENABLE), true)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
else
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_noSysext.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
endif
else
ifeq ($(SYSTEMEXT_SEPARATE_PARTITION_ENABLE), true)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_non_AB.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom
else
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_non_AB_noSysext.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom
endif
endif
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2


BOARD_HAVE_BLUETOOTH := false
BOARD_HAVE_QCOM_FM := false
TARGET_DISABLE_PERF_OPTIMIATIONS := false

# privapp-permissions whitelisting (To Fix CTS :privappPermissionsMustBeEnforced)
PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce

$(call inherit-product, device/qcom/vendor-common/common64.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

###########
# Target naming
PRODUCT_NAME := lahaina
PRODUCT_DEVICE := lahaina
PRODUCT_BRAND := qti
PRODUCT_MODEL := Lahaina for arm64

PRODUCT_PACKAGES += android.hardware.configstore@1.1-service

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(TARGET_USES_QMAA), true)
ifneq ($(TARGET_USES_QMAA_OVERRIDE_WLAN), true)
include device/qcom/wlan/default/wlan.mk
else
include device/qcom/wlan/lahaina/wlan.mk
endif
else
include device/qcom/wlan/lahaina/wlan.mk
endif


#----------------------------------------------------------------------
# audio specific
#----------------------------------------------------------------------
TARGET_USES_AOSP := false
TARGET_USES_AOSP_FOR_AUDIO := false
ifeq ($(TARGET_USES_QMAA_OVERRIDE_AUDIO), false)
ifeq ($(TARGET_USES_QMAA),true)
AUDIO_USE_STUB_HAL := true
TARGET_USES_AOSP_FOR_AUDIO := true
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/common/default.mk
else
# Audio hal configuration file
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/lahaina/lahaina.mk
endif
else
# Audio hal configuration file
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/lahaina/lahaina.mk
endif

TARGET_USES_QCOM_BSP := false

# RRO configuration
TARGET_USES_RRO := true

# system prop for Bluetooth SOC type
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=hastings \
    ro.sf.lcd_density=560


TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

###########
# Kernel configurations
#Enable llvm support for kernel
KERNEL_LLVM_SUPPORT := true
#Enable sd-llvm support for kernel
KERNEL_SD_LLVM_SUPPORT := false


###########
# Target configurations

QCOM_BOARD_PLATFORMS += lahaina

TARGET_USES_QSSI := true

###QMAA Indicator Start###

#Full QMAA HAL List
QMAA_HAL_LIST :=

#Indicator for each enabled QMAA HAL for this target. Each tech team locally verified their QMAA HAL and ensure code is updated/merged, then add their HAL module name to QMAA_ENABLED_HAL_MODULES as an QMAA enabling completion indicator
QMAA_ENABLED_HAL_MODULES :=
QMAA_ENABLED_HAL_MODULES += sensors

###QMAA Indicator End###

#Default vendor image configuration
ENABLE_VENDOR_IMAGE := true

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

BOARD_FRP_PARTITION_NAME := frp

# Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

PRODUCT_PACKAGES += fs_config_files
PRODUCT_PACKAGES += gpio-keys.kl

ifeq ($(ENABLE_AB), true)
# A/B related packages
PRODUCT_PACKAGES += update_engine \
    update_engine_client \
    update_verifier \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service

PRODUCT_HOST_PACKAGES += \
    brillo_update_payload

# Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl

PRODUCT_PACKAGES += \
  update_engine_sideload
endif

PRODUCT_HOST_PACKAGES += \
    configstore_xmlparser

# QRTR related packages
PRODUCT_PACKAGES += qrtr-ns
PRODUCT_PACKAGES += qrtr-lookup
PRODUCT_PACKAGES += libqrtr

# diag-router
TARGET_HAS_DIAG_ROUTER := true

# Context hub HAL
PRODUCT_PACKAGES += \
    android.hardware.contexthub@1.0-impl.generic \
    android.hardware.contexthub@1.0-service

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Userdata checkpoint
PRODUCT_PACKAGES += \
    checkpoint_gc

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Camera configuration file. Shared by passthrough/binderized camera HAL
PRODUCT_PACKAGES += camera.device@3.2-impl
PRODUCT_PACKAGES += camera.device@1.0-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
# Enable binderized camera HAL
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-service_64

DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/lahaina/framework_manifest.xml

DEVICE_MANIFEST_FILE := device/qcom/lahaina/manifest.xml
DEVICE_MATRIX_FILE   := device/qcom/common/compatibility_matrix.xml

#TODO: Replace QCV_FAMILY_SKUS with DEVICE_MANIFEST_SKUS
QCV_FAMILY_SKUS := lahaina

#Audio DLKM
#AUDIO_DLKM := audio_apr.ko
#AUDIO_DLKM += audio_q6_pdr.ko
#AUDIO_DLKM += audio_q6_notifier.ko
#AUDIO_DLKM += audio_adsp_loader.ko
#AUDIO_DLKM += audio_q6.ko
#AUDIO_DLKM += audio_usf.ko
#AUDIO_DLKM += audio_pinctrl_wcd.ko
#AUDIO_DLKM += audio_swr.ko
#AUDIO_DLKM += audio_wcd_core.ko
#AUDIO_DLKM += audio_swr_ctrl.ko
#AUDIO_DLKM += audio_wsa881x.ko
#AUDIO_DLKM += audio_platform.ko
#AUDIO_DLKM += audio_hdmi.ko
#AUDIO_DLKM += audio_stub.ko
#AUDIO_DLKM += audio_wcd9xxx.ko
#AUDIO_DLKM += audio_mbhc.ko
#AUDIO_DLKM += audio_native.ko
#AUDIO_DLKM += audio_wcd938x.ko
#AUDIO_DLKM += audio_wcd938x_slave.ko
#AUDIO_DLKM += audio_bolero_cdc.ko
#AUDIO_DLKM += audio_wsa_macro.ko
#AUDIO_DLKM += audio_va_macro.ko
#AUDIO_DLKM += audio_rx_macro.ko
#AUDIO_DLKM += audio_tx_macro.ko
#AUDIO_DLKM += audio_machine_lahaina.ko
#AUDIO_DLKM += audio_snd_event.ko

PRODUCT_PACKAGES += $(AUDIO_DLKM)

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

ifeq ($(AUDIO_USE_STUB_HAL), true)
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_configuration_generic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/surround_sound_configuration_5_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_configuration_5_0.xml
endif

USE_LIB_PROCESS_GROUP := true

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Pro Audio feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml

#Enable full treble flag
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true
BOARD_SYSTEMSDK_VERSIONS := 28
BOARD_VNDK_VERSION := current
TARGET_MOUNT_POINTS_SYMLINKS := false

# Sensor conf files
PRODUCT_COPY_FILES += \
    device/qcom/lahaina/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml

# FaceAuth feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.biometrics.face.xml \

# Fingerprint feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \

# system prop for enabling QFS (QTI Fingerprint Solution)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qfp=true
#target specific runtime prop for qspm
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qspm.enable=true
#ANT+ stack
PRODUCT_PACKAGES += \
    libvolumelistener

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

# TODO: Make below modifications in tech team specific product mk files
# Copy permission xml's to SKU based folder for all QCV chipsets
PRODUCT_COPY_FILES += \
$(foreach DEVICE_SKU, $(QCV_FAMILY_SKUS), \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.biometrics.face.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.camera.full.xml\
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.camera.raw.xml\
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.location.gps.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.software.vulkan.deqp.level.xml \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.software.device_id_attestation.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.software.midi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(DEVICE_SKU)/handheld_core_hardware.xml )

#Charger
PRODUCT_COPY_FILES += $(LOCAL_PATH)/charger_fstab.qti:$(TARGET_COPY_OUT_VENDOR)/etc/charger_fstab.qti

PRODUCT_BOOT_JARS += tcmiface
PRODUCT_BOOT_JARS += telephony-ext
PRODUCT_PACKAGES += telephony-ext

# Vendor property to enable advanced network scanning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.enableadvancedscan=true

PRODUCT_COPY_FILES += \
    device/qcom/lahaina/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
# TODO: Relocate the system product.mk files pickup into qssi lunch, once it is up.
$(foreach sdefs, $(sort $(wildcard vendor/qcom/defs/product-defs/system/*.mk)), \
    $(call inherit-product, $(sdefs)))
$(foreach vdefs, $(sort $(wildcard vendor/qcom/defs/product-defs/vendor/*.mk)), \
    $(call inherit-product, $(vdefs)))
###################################################################################
