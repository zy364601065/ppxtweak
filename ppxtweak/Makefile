TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

SRC = $(wildcard *.m)

TWEAK_NAME = ppxtweak

ppxtweak_FILES = $(wildcard *.m) Tweak.xm
ppxtweak_CFLAGS = -fobjc-arc
ppxtweak_ICON = "./set.png"

include $(THEOS_MAKE_PATH)/tweak.mk