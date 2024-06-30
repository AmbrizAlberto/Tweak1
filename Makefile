ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:12.0
THEOS_DEVICE_IP = 192.168.1.75

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tweak1

MyTweak_FILES = Tweak.xm
MyTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
