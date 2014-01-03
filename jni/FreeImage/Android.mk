LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/Makefile.srcs

LOCAL_MODULE := FreeImage
APPDIR := $(shell readlink $(LOCAL_PATH)/src)

APP_SUBDIRS := $(patsubst $(LOCAL_PATH)/%, %, $(shell find $(LOCAL_PATH)/$(APPDIR) -path '*/.svn' -prune -o -type d -print))
ifneq ($(APPLICATION_SUBDIRS_BUILD),)
APPLICATION_SUBDIRS_BUILD_NONRECURSIVE := $(addprefix $(APPDIR)/, $(filter-out %/*, $(APPLICATION_SUBDIRS_BUILD)))
APPLICATION_SUBDIRS_BUILD_RECURSIVE := $(patsubst %/*, %, $(filter %/*,$(APPLICATION_SUBDIRS_BUILD)))
APPLICATION_SUBDIRS_BUILD_RECURSIVE := $(foreach FINDDIR, $(APPLICATION_SUBDIRS_BUILD_RECURSIVE), $(shell find $(LOCAL_PATH)/$(APPDIR)/$(FINDDIR) -path '*/.svn' -prune -o -type d -print))
APPLICATION_SUBDIRS_BUILD_RECURSIVE := $(patsubst $(LOCAL_PATH)/%, %, $(APPLICATION_SUBDIRS_BUILD_RECURSIVE) )
APP_SUBDIRS := $(APPLICATION_SUBDIRS_BUILD_NONRECURSIVE) $(APPLICATION_SUBDIRS_BUILD_RECURSIVE)
endif

LOCAL_SRC_FILES := $(filter %.c %.cpp, $(APP_SUBDIRS))
APP_SUBDIRS := $(filter-out %.c %.cpp, $(APP_SUBDIRS))
#LOCAL_SRC_FILES += $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.cpp))))
#LOCAL_SRC_FILES += $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.c))))
LOCAL_SRC_FILES += $(SRCS)

LOCAL_CFLAGS :=
LOCAL_C_INCLUDES :=

LOCAL_CFLAGS +=  -I. -I$(LOCAL_PATH)/Source -I$(LOCAL_PATH)/Source/Metadata -I$(LOCAL_PATH)/Source/FreeImageToolkit -I$(LOCAL_PATH)/Source/LibJPEG -I$(LOCAL_PATH)/Source/LibPNG -I$(LOCAL_PATH)/Source/LibTIFF4 -I$(LOCAL_PATH)/Source/ZLib -I$(LOCAL_PATH)/Source/LibOpenJPEG -I$(LOCAL_PATH)/Source/OpenEXR -I$(LOCAL_PATH)/Source/OpenEXR/Half -I$(LOCAL_PATH)/Source/OpenEXR/Iex -I$(LOCAL_PATH)/Source/OpenEXR/IlmImf -I$(LOCAL_PATH)/Source/OpenEXR/IlmThread -I$(LOCAL_PATH)/Source/OpenEXR/Imath -I$(LOCAL_PATH)/Source/LibRawLite -I$(LOCAL_PATH)/Source/LibRawLite/dcraw -I$(LOCAL_PATH)/Source/LibRawLite/internal -I$(LOCAL_PATH)/Source/LibRawLite/libraw -I$(LOCAL_PATH)/Source/LibRawLite/src
LOCAL_CFLAGS +=  -fexceptions -fvisibility=hidden -Wno-ctor-dtor-privacy --rtti

#Change C++ file extension as appropriate
LOCAL_CPP_EXTENSION := .cpp

LOCAL_SHARED_LIBRARIES :=

LOCAL_STATIC_LIBRARIES :=

LOCAL_STATIC_LIBRARIES += 

LOCAL_LDLIBS :=

LOCAL_LDFLAGS :=


#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)
