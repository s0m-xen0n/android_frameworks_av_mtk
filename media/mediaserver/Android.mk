LOCAL_PATH:= $(call my-dir)

ifneq ($(BOARD_USE_CUSTOM_MEDIASERVEREXTENSIONS),true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := register.cpp
LOCAL_MODULE := libregistermsext
LOCAL_MODULE_TAGS := optional
include $(BUILD_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	main_mediaserver.cpp 

LOCAL_SHARED_LIBRARIES := \
	libaudioflinger \
	libcameraservice \
	libmedialogservice \
	libcutils \
	libnbaio \
	libmedia \
	libmediaplayerservice \
	libutils \
	liblog \
	libbinder

LOCAL_STATIC_LIBRARIES := \
	libregistermsext

ifeq ($(BOARD_USE_SECTVOUT),true)
	LOCAL_CFLAGS += -DSECTVOUT
	LOCAL_SHARED_LIBRARIES += libTVOut
endif

LOCAL_C_INCLUDES := \
    frameworks/av/media/libmediaplayerservice \
    frameworks/av/services/medialog \
    frameworks/av/services/audioflinger \
    frameworks/av/services/camera/libcameraservice

ifeq ($(strip $(AUDIO_FEATURE_ENABLED_LISTEN)),true)
  LOCAL_SHARED_LIBRARIES += liblisten
  LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-listen
  LOCAL_CFLAGS += -DAUDIO_LISTEN_ENABLED
endif

ifeq ($(strip $(BOARD_USES_MTK_AUDIO)),true)
LOCAL_C_INCLUDES += \
        hardware/mediatek/common/audio/include \
        frameworks-ext/av/include/media \
        frameworks-ext/av/services/audioflinger \
        mediatek-min/external/audiodcremoveflt
endif

ifeq ($(strip $(MTK_VIDEO_HEVC_SUPPORT)), yes)
   LOCAL_CFLAGS += -DMTK_VIDEO_HEVC_SUPPORT
   LOCAL_SHARED_LIBRARIES += \
       libmemorydumper \
       libdl
endif

LOCAL_MODULE:= mediaserver

include $(BUILD_EXECUTABLE)
