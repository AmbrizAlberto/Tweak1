ARCHS = arm64 arm64e
TARGET = iphone:clang::12.0
THEOS_DEVICE_IP = 192.168.1.84

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tweak1

Tweak1_FILES = Tweak.xm
Tweak1_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
