TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

SRC = $(wildcard src/*.m)

TWEAK_NAME = ppxtweak

ppxtweak_FILES = $(wildcard src/*.m) src/Tweak.xm
ppxtweak_CFLAGS = -fobjc-arc
ppxtweak_ICON = "./set.png"

include $(THEOS_MAKE_PATH)/tweak.mk
