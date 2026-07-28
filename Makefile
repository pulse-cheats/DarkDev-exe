TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkDevExecutor

DarkDevExecutor_FILES = Tweak.xm DarkDevUI.mm
DarkDevExecutor_FRAMEWORKS = UIKit CoreGraphics Foundation

include $(THEOS_MAKEFILES_DIR)/tweak.mk
