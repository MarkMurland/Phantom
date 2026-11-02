import os
import sys
from typing import TYPE_CHECKING

from methods import detect_darwin_sdk_path, detect_darwin_toolchain_path, print_error, print_warning
from platform_methods import validate_arch

if TYPE_CHECKING:
    from SCons.Script.SConscript import SConsEnvironment


def get_name():
    return "iOS"


def can_build():
    return False


def get_opts():
    from SCons.Variables import BoolVariable

    return [
        ("vulkan_sdk_path", "Path to the Vulkan SDK", ""),
        (("APPLE_TOOLCHAIN_PATH", "IOS_TOOLCHAIN_PATH"), "Path to the Apple toolchain", ""),
        ("IOS_SDK_PATH", "Path to the iOS SDK", ""),
        (("apple_target_triple", "ios_triple"), "Triple for the corresponding target Apple platform toolchain", ""),
        BoolVariable(("simulator", "ios_simulator"), "Build for Simulator", False),
        BoolVariable("generate_bundle", "Generate an APP bundle after building iOS/macOS binaries", False),
    ]


def get_doc_classes():
    return [
        "EditorExportPlatformIOS",
    ]


def get_doc_path():
    return "doc_classes"


def get_flags():
    return {
        "arch": "arm64",
        "target": "template_debug",
        "use_volk": False,
        "metal": True,
        "supported": ["metal", "mono"],
        "builtin_pcre2_with_jit": False,
    }


def configure(env: "SConsEnvironment"):
    raise RuntimeError("iOS support has been disabled for this build.")
