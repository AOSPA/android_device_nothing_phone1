DEVICE_PATH := device/nothing/phone1

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service \
    checkpoint_gc \
    otapreopt_script

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# API
BOARD_SHIPPING_API_LEVEL := 30
BOARD_API_LEVEL := 30
PRODUCT_SHIPPING_API_LEVEL := 30

# Architecture
TARGET_BOARD_PLATFORM := lahaina
TARGET_BOOTLOADER_BOARD_NAME := lahaina

# Authsecret
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0.vendor

# AVB
BOARD_AVB_ENABLE := true

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/mixer_paths_yupikqrd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_yupik/mixer_paths_yupikqrd.xml

# Camera
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/public.libraries.system_ext.txt:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/public.libraries.txt \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    libcamera2ndk_vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Display
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.use_latest_hwc_vsync_period=0

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.drm@1.4-service.clearkey

# Emulated Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Filesystem
PRODUCT_PACKAGES += \
    fs_config_files

# Fingerprint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.phone1 \
    android.hardware.biometrics.fingerprint@2.3.vendor

TARGET_USES_FOD_ZPOS := true

# FM
BOARD_HAVE_QCOM_FM := false

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0 \
    android.hardware.gatekeeper@1.0.vendor

# Generic Kernel Headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl-qti \
    android.hardware.health@2.1-service

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.memory.block@1.0.vendor

# Init
PRODUCT_PACKAGES += \
    charger_fw_fstab.qti \
    fstab.default \
    init.phone1.display.rc \
    init.phone1.perf.rc \
    init.qti.media.rc \
    init.qti.media.sh \
    init.target.rc \
    ueventd.nothing.rc

# Keymaster
PRODUCT_PACKAGES += \
   android.hardware.keymaster@4.1 \
   android.hardware.keymaster@4.1.vendor

# Manifests
DEVICE_MANIFEST_FILE += \
    $(DEVICE_PATH)/manifest_yupik.xml \
    $(DEVICE_PATH)/manifest_phone1.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(DEVICE_PATH)/phone1_vendor_framework_compatibility_matrix.xml

# Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Neural networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2.vendor \
    android.hardware.nfc@1.0-impl:64 \
    NfcNci \
    Tag

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \

# Overlays
PRODUCT_PACKAGES += \
    Phone1CarrierConfig \
    Phone1Frameworks \
    Phone1FrameworksAOSPA \
    Phone1Settings \
    Phone1SystemUI \
    Phone1SystemUIAOSPA \
    WifiResTarget

# Paranoid Glyph
PRODUCT_PACKAGES += \
    ParanoidGlyph

# Partitions - Dynamic
PRODUCT_BUILD_ODM_IMAGE := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

PRODUCT_COPY_FILES += $(DEVICE_PATH)/init/fstab.default:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.default

# Perf
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Powershare
PRODUCT_PACKAGES += \
    vendor.aospa.powershare-service

# QTI Components
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    audio \
    av \
    bt \
    display \
    gps \
    init \
    media \
    overlay \
    perf \
    telephony \
    usb \
    wfd \
    wlan

# Sensors
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    $(DEVICE_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.phone1-multihal \
    android.hardware.sensors@2.0-ScopedWakelock \
    libsensorndkbridge \
    sensors.nothing

# Storage
PRODUCT_CHARACTERISTICS := nosdcard

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# System Helper
PRODUCT_PACKAGES += \
    vendor.qti.hardware.systemhelper@1.0.vendor

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-V1-ndk.vendor

PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/vibrator/excluded-input-devices.xml:vendor/etc/excluded-input-devices.xml

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 30

# WLAN
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# Proprietary Vendor
$(call inherit-product, vendor/nothing/phone1/phone1-vendor.mk)
#$(call inherit-product, vendor/nothing/camera/nothing-camera.mk)
