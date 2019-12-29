THEOS_DEVICE_IP = 192.168.1.100

include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:11.2:11.0
export ARCHS = arm64

BUNDLE_NAME = pstycc
pstycc_BUNDLE_EXTENSION = bundle
pstycc_FILES = pstycc.m
pstycc_PRIVATE_FRAMEWORKS = ControlCenterUIKit
pstycc_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
