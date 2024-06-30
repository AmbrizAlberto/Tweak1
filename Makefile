TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = 	


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tweak1

Tweak1_FILES = Tweak.x
Tweak1_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
