LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# Radio image
#----------------------------------------------------------------------
ifeq ($(ADD_RADIO_FILES), true)
radio_dir := $(LOCAL_PATH)/radio
RADIO_FILES := $(notdir $(wildcard $(radio_dir)/*))
$(foreach f, $(RADIO_FILES), \
    $(call add-radio-file,radio/$(f)))
endif
