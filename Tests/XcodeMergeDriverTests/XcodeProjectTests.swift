//
//  XcodeProjectTests.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import XCTest
@testable import XcodeMergeDriver

final class XcodeProjectTests: XCTestCase {
    
    func test_init_throwsErrorWithWrongContent() {
        XCTAssertThrowsError(try XcodeProject(content: ""))
    }
    
    func test_hasConflict_returnsFalseWhenNoConflict() throws {
        let noConflictProject = try XcodeProject(content: noConflict)
        
        XCTAssertFalse(noConflictProject.hasConflict)
        XCTAssertFalse(noConflictProject.pbxBuildFile.hasConflict)
    }
    
    func test_hasConflict_returnsTrueWhenConflictExist() throws {
        let conflictProject = try XcodeProject(content: merged)
        
        XCTAssert(conflictProject.hasConflict)
        XCTAssert(conflictProject.pbxBuildFile.hasConflict)
    }
    
    func test_merge_doesntThrowsWhenFileStillHasConflicts() throws {
        let baseProject = try XcodeProject(content: base)
        let otherProject = try XcodeProject(content: other)
        let currentProject = try XcodeProject(content: current)
        
        XCTAssertNoThrow(try currentProject.mergeChanges(from: baseProject, to: otherProject) {
            try XcodeProject(content: unsupported)
        })
    }
}

private let current = """
// !$*UTF8*$!
{
    archiveVersion = 1;
    classes = {
    };
    objectVersion = 56;
    objects = {

/* Begin PBXBuildFile section */
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
        87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AD28F9F7FA00380008 /* BViewController.swift */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
        87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
        87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC76F28F9E1AB00380008 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
        87BBC77128F9E1AB00380008 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
        87BBC77328F9E1AB00380008 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
        87BBC77628F9E1AB00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
        87BBC77828F9E1AD00380008 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
        87BBC77B28F9E1AD00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
        87BBC77D28F9E1AD00380008 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC78628F9E1AD00380008 /* SampleAppTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppTests.swift; sourceTree = "<group>"; };
        87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITests.swift; sourceTree = "<group>"; };
        87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITestsLaunchTests.swift; sourceTree = "<group>"; };
        87BBC7AD28F9F7FA00380008 /* BViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = BViewController.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        87BBC76928F9E1AB00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77F28F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78928F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        87BBC76328F9E1AB00380008 = {
            isa = PBXGroup;
            children = (
                87BBC76E28F9E1AB00380008 /* SampleApp */,
                87BBC78528F9E1AD00380008 /* SampleAppTests */,
                87BBC78F28F9E1AD00380008 /* SampleAppUITests */,
                87BBC76D28F9E1AB00380008 /* Products */,
            );
            sourceTree = "<group>";
        };
        87BBC76D28F9E1AB00380008 /* Products */ = {
            isa = PBXGroup;
            children = (
                87BBC76C28F9E1AB00380008 /* SampleApp.app */,
                87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */,
                87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */,
            );
            name = Products;
            sourceTree = "<group>";
        };
        87BBC76E28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXGroup;
            children = (
                87BBC76F28F9E1AB00380008 /* AppDelegate.swift */,
                87BBC77128F9E1AB00380008 /* SceneDelegate.swift */,
                87BBC77328F9E1AB00380008 /* ViewController.swift */,
                87BBC7AD28F9F7FA00380008 /* BViewController.swift */,
                87BBC77528F9E1AB00380008 /* Main.storyboard */,
                87BBC77828F9E1AD00380008 /* Assets.xcassets */,
                87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */,
                87BBC77D28F9E1AD00380008 /* Info.plist */,
            );
            path = SampleApp;
            sourceTree = "<group>";
        };
        87BBC78528F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXGroup;
            children = (
                87BBC78628F9E1AD00380008 /* SampleAppTests.swift */,
            );
            path = SampleAppTests;
            sourceTree = "<group>";
        };
        87BBC78F28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXGroup;
            children = (
                87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */,
                87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */,
            );
            path = SampleAppUITests;
            sourceTree = "<group>";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        87BBC76B28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */;
            buildPhases = (
                87BBC76828F9E1AB00380008 /* Sources */,
                87BBC76928F9E1AB00380008 /* Frameworks */,
                87BBC76A28F9E1AB00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = SampleApp;
            productName = SampleApp;
            productReference = 87BBC76C28F9E1AB00380008 /* SampleApp.app */;
            productType = "com.apple.product-type.application";
        };
        87BBC78128F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */;
            buildPhases = (
                87BBC77E28F9E1AD00380008 /* Sources */,
                87BBC77F28F9E1AD00380008 /* Frameworks */,
                87BBC78028F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78428F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppTests;
            productName = SampleAppTests;
            productReference = 87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */;
            productType = "com.apple.product-type.bundle.unit-test";
        };
        87BBC78B28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */;
            buildPhases = (
                87BBC78828F9E1AD00380008 /* Sources */,
                87BBC78928F9E1AD00380008 /* Frameworks */,
                87BBC78A28F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78E28F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppUITests;
            productName = SampleAppUITests;
            productReference = 87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */;
            productType = "com.apple.product-type.bundle.ui-testing";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        87BBC76428F9E1AB00380008 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                BuildIndependentTargetsInParallel = 1;
                LastSwiftUpdateCheck = 1400;
                LastUpgradeCheck = 1400;
                TargetAttributes = {
                    87BBC76B28F9E1AB00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                    };
                    87BBC78128F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                    87BBC78B28F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                };
            };
            buildConfigurationList = 87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */;
            compatibilityVersion = "Xcode 14.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 87BBC76328F9E1AB00380008;
            productRefGroup = 87BBC76D28F9E1AB00380008 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                87BBC76B28F9E1AB00380008 /* SampleApp */,
                87BBC78128F9E1AD00380008 /* SampleAppTests */,
                87BBC78B28F9E1AD00380008 /* SampleAppUITests */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        87BBC76A28F9E1AB00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */,
                87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */,
                87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78028F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78A28F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */,
                87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */,
                87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77E28F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78828F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */,
                87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
        87BBC78428F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */;
        };
        87BBC78E28F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */;
        };
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
        87BBC77528F9E1AB00380008 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77628F9E1AB00380008 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "<group>";
        };
        87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77B28F9E1AD00380008 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "<group>";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        87BBC79428F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = dwarf;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                ENABLE_TESTABILITY = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_DYNAMIC_NO_PIC = NO;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_OPTIMIZATION_LEVEL = 0;
                GCC_PREPROCESSOR_DEFINITIONS = (
                    "DEBUG=1",
                    "$(inherited)",
                );
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                MTL_FAST_MATH = YES;
                ONLY_ACTIVE_ARCH = YES;
                SDKROOT = iphoneos;
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
            };
            name = Debug;
        };
        87BBC79528F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                ENABLE_NS_ASSERTIONS = NO;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = NO;
                MTL_FAST_MATH = YES;
                SDKROOT = iphoneos;
                SWIFT_COMPILATION_MODE = wholemodule;
                SWIFT_OPTIMIZATION_LEVEL = "-O";
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        87BBC79728F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        87BBC79828F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
        87BBC79A28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Debug;
        };
        87BBC79B28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Release;
        };
        87BBC79D28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Debug;
        };
        87BBC79E28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79428F9E1AD00380008 /* Debug */,
                87BBC79528F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79728F9E1AD00380008 /* Debug */,
                87BBC79828F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79A28F9E1AD00380008 /* Debug */,
                87BBC79B28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79D28F9E1AD00380008 /* Debug */,
                87BBC79E28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 87BBC76428F9E1AB00380008 /* Project object */;
}
"""

private let base = """
// !$*UTF8*$!
{
    archiveVersion = 1;
    classes = {
    };
    objectVersion = 56;
    objects = {

/* Begin PBXBuildFile section */
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
        87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
        87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC76F28F9E1AB00380008 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
        87BBC77128F9E1AB00380008 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
        87BBC77328F9E1AB00380008 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
        87BBC77628F9E1AB00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
        87BBC77828F9E1AD00380008 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
        87BBC77B28F9E1AD00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
        87BBC77D28F9E1AD00380008 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC78628F9E1AD00380008 /* SampleAppTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppTests.swift; sourceTree = "<group>"; };
        87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITests.swift; sourceTree = "<group>"; };
        87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITestsLaunchTests.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        87BBC76928F9E1AB00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77F28F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78928F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        87BBC76328F9E1AB00380008 = {
            isa = PBXGroup;
            children = (
                87BBC76E28F9E1AB00380008 /* SampleApp */,
                87BBC78528F9E1AD00380008 /* SampleAppTests */,
                87BBC78F28F9E1AD00380008 /* SampleAppUITests */,
                87BBC76D28F9E1AB00380008 /* Products */,
            );
            sourceTree = "<group>";
        };
        87BBC76D28F9E1AB00380008 /* Products */ = {
            isa = PBXGroup;
            children = (
                87BBC76C28F9E1AB00380008 /* SampleApp.app */,
                87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */,
                87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */,
            );
            name = Products;
            sourceTree = "<group>";
        };
        87BBC76E28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXGroup;
            children = (
                87BBC76F28F9E1AB00380008 /* AppDelegate.swift */,
                87BBC77128F9E1AB00380008 /* SceneDelegate.swift */,
                87BBC77328F9E1AB00380008 /* ViewController.swift */,
                87BBC77528F9E1AB00380008 /* Main.storyboard */,
                87BBC77828F9E1AD00380008 /* Assets.xcassets */,
                87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */,
                87BBC77D28F9E1AD00380008 /* Info.plist */,
            );
            path = SampleApp;
            sourceTree = "<group>";
        };
        87BBC78528F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXGroup;
            children = (
                87BBC78628F9E1AD00380008 /* SampleAppTests.swift */,
            );
            path = SampleAppTests;
            sourceTree = "<group>";
        };
        87BBC78F28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXGroup;
            children = (
                87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */,
                87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */,
            );
            path = SampleAppUITests;
            sourceTree = "<group>";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        87BBC76B28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */;
            buildPhases = (
                87BBC76828F9E1AB00380008 /* Sources */,
                87BBC76928F9E1AB00380008 /* Frameworks */,
                87BBC76A28F9E1AB00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = SampleApp;
            productName = SampleApp;
            productReference = 87BBC76C28F9E1AB00380008 /* SampleApp.app */;
            productType = "com.apple.product-type.application";
        };
        87BBC78128F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */;
            buildPhases = (
                87BBC77E28F9E1AD00380008 /* Sources */,
                87BBC77F28F9E1AD00380008 /* Frameworks */,
                87BBC78028F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78428F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppTests;
            productName = SampleAppTests;
            productReference = 87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */;
            productType = "com.apple.product-type.bundle.unit-test";
        };
        87BBC78B28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */;
            buildPhases = (
                87BBC78828F9E1AD00380008 /* Sources */,
                87BBC78928F9E1AD00380008 /* Frameworks */,
                87BBC78A28F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78E28F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppUITests;
            productName = SampleAppUITests;
            productReference = 87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */;
            productType = "com.apple.product-type.bundle.ui-testing";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        87BBC76428F9E1AB00380008 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                BuildIndependentTargetsInParallel = 1;
                LastSwiftUpdateCheck = 1400;
                LastUpgradeCheck = 1400;
                TargetAttributes = {
                    87BBC76B28F9E1AB00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                    };
                    87BBC78128F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                    87BBC78B28F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                };
            };
            buildConfigurationList = 87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */;
            compatibilityVersion = "Xcode 14.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 87BBC76328F9E1AB00380008;
            productRefGroup = 87BBC76D28F9E1AB00380008 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                87BBC76B28F9E1AB00380008 /* SampleApp */,
                87BBC78128F9E1AD00380008 /* SampleAppTests */,
                87BBC78B28F9E1AD00380008 /* SampleAppUITests */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        87BBC76A28F9E1AB00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */,
                87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */,
                87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78028F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78A28F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */,
                87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77E28F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78828F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */,
                87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
        87BBC78428F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */;
        };
        87BBC78E28F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */;
        };
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
        87BBC77528F9E1AB00380008 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77628F9E1AB00380008 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "<group>";
        };
        87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77B28F9E1AD00380008 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "<group>";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        87BBC79428F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = dwarf;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                ENABLE_TESTABILITY = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_DYNAMIC_NO_PIC = NO;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_OPTIMIZATION_LEVEL = 0;
                GCC_PREPROCESSOR_DEFINITIONS = (
                    "DEBUG=1",
                    "$(inherited)",
                );
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                MTL_FAST_MATH = YES;
                ONLY_ACTIVE_ARCH = YES;
                SDKROOT = iphoneos;
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
            };
            name = Debug;
        };
        87BBC79528F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                ENABLE_NS_ASSERTIONS = NO;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = NO;
                MTL_FAST_MATH = YES;
                SDKROOT = iphoneos;
                SWIFT_COMPILATION_MODE = wholemodule;
                SWIFT_OPTIMIZATION_LEVEL = "-O";
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        87BBC79728F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        87BBC79828F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
        87BBC79A28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Debug;
        };
        87BBC79B28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Release;
        };
        87BBC79D28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Debug;
        };
        87BBC79E28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79428F9E1AD00380008 /* Debug */,
                87BBC79528F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79728F9E1AD00380008 /* Debug */,
                87BBC79828F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79A28F9E1AD00380008 /* Debug */,
                87BBC79B28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79D28F9E1AD00380008 /* Debug */,
                87BBC79E28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 87BBC76428F9E1AB00380008 /* Project object */;
}
"""

private let other = """
// !$*UTF8*$!
{
    archiveVersion = 1;
    classes = {
    };
    objectVersion = 56;
    objects = {

/* Begin PBXBuildFile section */
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
        87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AB28F9F7E700380008 /* AViewController.swift */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
        87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
        87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC76F28F9E1AB00380008 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
        87BBC77128F9E1AB00380008 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
        87BBC77328F9E1AB00380008 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
        87BBC77628F9E1AB00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
        87BBC77828F9E1AD00380008 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
        87BBC77B28F9E1AD00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
        87BBC77D28F9E1AD00380008 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC78628F9E1AD00380008 /* SampleAppTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppTests.swift; sourceTree = "<group>"; };
        87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITests.swift; sourceTree = "<group>"; };
        87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITestsLaunchTests.swift; sourceTree = "<group>"; };
        87BBC7AB28F9F7E700380008 /* AViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AViewController.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        87BBC76928F9E1AB00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77F28F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78928F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        87BBC76328F9E1AB00380008 = {
            isa = PBXGroup;
            children = (
                87BBC76E28F9E1AB00380008 /* SampleApp */,
                87BBC78528F9E1AD00380008 /* SampleAppTests */,
                87BBC78F28F9E1AD00380008 /* SampleAppUITests */,
                87BBC76D28F9E1AB00380008 /* Products */,
            );
            sourceTree = "<group>";
        };
        87BBC76D28F9E1AB00380008 /* Products */ = {
            isa = PBXGroup;
            children = (
                87BBC76C28F9E1AB00380008 /* SampleApp.app */,
                87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */,
                87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */,
            );
            name = Products;
            sourceTree = "<group>";
        };
        87BBC76E28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXGroup;
            children = (
                87BBC76F28F9E1AB00380008 /* AppDelegate.swift */,
                87BBC77128F9E1AB00380008 /* SceneDelegate.swift */,
                87BBC77328F9E1AB00380008 /* ViewController.swift */,
                87BBC7AB28F9F7E700380008 /* AViewController.swift */,
                87BBC77528F9E1AB00380008 /* Main.storyboard */,
                87BBC77828F9E1AD00380008 /* Assets.xcassets */,
                87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */,
                87BBC77D28F9E1AD00380008 /* Info.plist */,
            );
            path = SampleApp;
            sourceTree = "<group>";
        };
        87BBC78528F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXGroup;
            children = (
                87BBC78628F9E1AD00380008 /* SampleAppTests.swift */,
            );
            path = SampleAppTests;
            sourceTree = "<group>";
        };
        87BBC78F28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXGroup;
            children = (
                87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */,
                87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */,
            );
            path = SampleAppUITests;
            sourceTree = "<group>";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        87BBC76B28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */;
            buildPhases = (
                87BBC76828F9E1AB00380008 /* Sources */,
                87BBC76928F9E1AB00380008 /* Frameworks */,
                87BBC76A28F9E1AB00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = SampleApp;
            productName = SampleApp;
            productReference = 87BBC76C28F9E1AB00380008 /* SampleApp.app */;
            productType = "com.apple.product-type.application";
        };
        87BBC78128F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */;
            buildPhases = (
                87BBC77E28F9E1AD00380008 /* Sources */,
                87BBC77F28F9E1AD00380008 /* Frameworks */,
                87BBC78028F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78428F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppTests;
            productName = SampleAppTests;
            productReference = 87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */;
            productType = "com.apple.product-type.bundle.unit-test";
        };
        87BBC78B28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */;
            buildPhases = (
                87BBC78828F9E1AD00380008 /* Sources */,
                87BBC78928F9E1AD00380008 /* Frameworks */,
                87BBC78A28F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78E28F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppUITests;
            productName = SampleAppUITests;
            productReference = 87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */;
            productType = "com.apple.product-type.bundle.ui-testing";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        87BBC76428F9E1AB00380008 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                BuildIndependentTargetsInParallel = 1;
                LastSwiftUpdateCheck = 1400;
                LastUpgradeCheck = 1400;
                TargetAttributes = {
                    87BBC76B28F9E1AB00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                    };
                    87BBC78128F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                        87BBC78B28F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                };
            };
            buildConfigurationList = 87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */;
            compatibilityVersion = "Xcode 14.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 87BBC76328F9E1AB00380008;
            productRefGroup = 87BBC76D28F9E1AB00380008 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                87BBC76B28F9E1AB00380008 /* SampleApp */,
                87BBC78128F9E1AD00380008 /* SampleAppTests */,
                87BBC78B28F9E1AD00380008 /* SampleAppUITests */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        87BBC76A28F9E1AB00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */,
                87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */,
                87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78028F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78A28F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */,
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */,
                87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77E28F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78828F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */,
                87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
        87BBC78428F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */;
        };
        87BBC78E28F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */;
        };
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
        87BBC77528F9E1AB00380008 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77628F9E1AB00380008 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "<group>";
        };
        87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77B28F9E1AD00380008 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "<group>";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        87BBC79428F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = dwarf;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                ENABLE_TESTABILITY = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_DYNAMIC_NO_PIC = NO;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_OPTIMIZATION_LEVEL = 0;
                GCC_PREPROCESSOR_DEFINITIONS = (
                    "DEBUG=1",
                    "$(inherited)",
                );
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                MTL_FAST_MATH = YES;
                ONLY_ACTIVE_ARCH = YES;
                SDKROOT = iphoneos;
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
            };
            name = Debug;
        };
        87BBC79528F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                ENABLE_NS_ASSERTIONS = NO;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = NO;
                MTL_FAST_MATH = YES;
                SDKROOT = iphoneos;
                SWIFT_COMPILATION_MODE = wholemodule;
                SWIFT_OPTIMIZATION_LEVEL = "-O";
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        87BBC79728F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        87BBC79828F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
        87BBC79A28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Debug;
        };
        87BBC79B28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Release;
        };
        87BBC79D28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Debug;
        };
        87BBC79E28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79428F9E1AD00380008 /* Debug */,
                87BBC79528F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79728F9E1AD00380008 /* Debug */,
                87BBC79828F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79A28F9E1AD00380008 /* Debug */,
                87BBC79B28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79D28F9E1AD00380008 /* Debug */,
                87BBC79E28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 87BBC76428F9E1AB00380008 /* Project object */;
}
"""

private let unsupported = """
// !$*UTF8*$!
{
<<<<<<< /Users/istvanbalogh/XcodeMergeDriver/our.pbxproj
    archiveVersion = 1;
=======
    archiveVersion = 2;
>>>>>>> /Users/istvanbalogh/XcodeMergeDriver/other.pbxproj
    classes = {
    };
    objectVersion = 56;
    objects = {

/* Begin PBXBuildFile section */
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
        87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AB28F9F7E700380008 /* AViewController.swift */; };
        87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AD28F9F7FA00380008 /* BViewController.swift */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
        87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
        87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC76F28F9E1AB00380008 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
        87BBC77128F9E1AB00380008 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
        87BBC77328F9E1AB00380008 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
        87BBC77628F9E1AB00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
        87BBC77828F9E1AD00380008 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
        87BBC77B28F9E1AD00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
        87BBC77D28F9E1AD00380008 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC78628F9E1AD00380008 /* SampleAppTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppTests.swift; sourceTree = "<group>"; };
        87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITests.swift; sourceTree = "<group>"; };
        87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITestsLaunchTests.swift; sourceTree = "<group>"; };
        87BBC7AD28F9F7FA00380008 /* BViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = BViewController.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        87BBC76928F9E1AB00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77F28F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78928F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        87BBC76328F9E1AB00380008 = {
            isa = PBXGroup;
            children = (
                87BBC76E28F9E1AB00380008 /* SampleApp */,
                87BBC78528F9E1AD00380008 /* SampleAppTests */,
                87BBC78F28F9E1AD00380008 /* SampleAppUITests */,
                87BBC76D28F9E1AB00380008 /* Products */,
            );
            sourceTree = "<group>";
        };
        87BBC76D28F9E1AB00380008 /* Products */ = {
            isa = PBXGroup;
            children = (
                87BBC76C28F9E1AB00380008 /* SampleApp.app */,
                87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */,
                87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */,
            );
            name = Products;
            sourceTree = "<group>";
        };
        87BBC76E28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXGroup;
            children = (
                87BBC76F28F9E1AB00380008 /* AppDelegate.swift */,
                87BBC77128F9E1AB00380008 /* SceneDelegate.swift */,
                87BBC77328F9E1AB00380008 /* ViewController.swift */,
                87BBC7AD28F9F7FA00380008 /* BViewController.swift */,
                87BBC77528F9E1AB00380008 /* Main.storyboard */,
                87BBC77828F9E1AD00380008 /* Assets.xcassets */,
                87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */,
                87BBC77D28F9E1AD00380008 /* Info.plist */,
            );
            path = SampleApp;
            sourceTree = "<group>";
        };
        87BBC78528F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXGroup;
            children = (
                87BBC78628F9E1AD00380008 /* SampleAppTests.swift */,
            );
            path = SampleAppTests;
            sourceTree = "<group>";
        };
        87BBC78F28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXGroup;
            children = (
                87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */,
                87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */,
            );
            path = SampleAppUITests;
            sourceTree = "<group>";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        87BBC76B28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */;
            buildPhases = (
                87BBC76828F9E1AB00380008 /* Sources */,
                87BBC76928F9E1AB00380008 /* Frameworks */,
                87BBC76A28F9E1AB00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = SampleApp;
            productName = SampleApp;
            productReference = 87BBC76C28F9E1AB00380008 /* SampleApp.app */;
            productType = "com.apple.product-type.application";
        };
        87BBC78128F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */;
            buildPhases = (
                87BBC77E28F9E1AD00380008 /* Sources */,
                87BBC77F28F9E1AD00380008 /* Frameworks */,
                87BBC78028F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78428F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppTests;
            productName = SampleAppTests;
            productReference = 87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */;
            productType = "com.apple.product-type.bundle.unit-test";
        };
        87BBC78B28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */;
            buildPhases = (
                87BBC78828F9E1AD00380008 /* Sources */,
                87BBC78928F9E1AD00380008 /* Frameworks */,
                87BBC78A28F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78E28F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppUITests;
            productName = SampleAppUITests;
            productReference = 87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */;
            productType = "com.apple.product-type.bundle.ui-testing";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        87BBC76428F9E1AB00380008 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                BuildIndependentTargetsInParallel = 1;
                LastSwiftUpdateCheck = 1400;
                LastUpgradeCheck = 1400;
                TargetAttributes = {
                    87BBC76B28F9E1AB00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                    };
                    87BBC78128F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                    87BBC78B28F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                };
            };
            buildConfigurationList = 87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */;
            compatibilityVersion = "Xcode 14.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 87BBC76328F9E1AB00380008;
            productRefGroup = 87BBC76D28F9E1AB00380008 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                87BBC76B28F9E1AB00380008 /* SampleApp */,
                87BBC78128F9E1AD00380008 /* SampleAppTests */,
                87BBC78B28F9E1AD00380008 /* SampleAppUITests */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        87BBC76A28F9E1AB00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */,
                87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */,
                87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78028F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78A28F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */,
                87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */,
                87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77E28F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78828F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */,
                87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
        87BBC78428F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */;
        };
        87BBC78E28F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */;
        };
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
        87BBC77528F9E1AB00380008 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77628F9E1AB00380008 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "<group>";
        };
        87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77B28F9E1AD00380008 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "<group>";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        87BBC79428F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = dwarf;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                ENABLE_TESTABILITY = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_DYNAMIC_NO_PIC = NO;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_OPTIMIZATION_LEVEL = 0;
                GCC_PREPROCESSOR_DEFINITIONS = (
                    "DEBUG=1",
                    "$(inherited)",
                );
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                MTL_FAST_MATH = YES;
                ONLY_ACTIVE_ARCH = YES;
                SDKROOT = iphoneos;
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
            };
            name = Debug;
        };
        87BBC79528F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                ENABLE_NS_ASSERTIONS = NO;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = NO;
                MTL_FAST_MATH = YES;
                SDKROOT = iphoneos;
                SWIFT_COMPILATION_MODE = wholemodule;
                SWIFT_OPTIMIZATION_LEVEL = "-O";
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        87BBC79728F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        87BBC79828F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
        87BBC79A28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Debug;
        };
        87BBC79B28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Release;
        };
        87BBC79D28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Debug;
        };
        87BBC79E28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79428F9E1AD00380008 /* Debug */,
                87BBC79528F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79728F9E1AD00380008 /* Debug */,
                87BBC79828F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79A28F9E1AD00380008 /* Debug */,
                87BBC79B28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79D28F9E1AD00380008 /* Debug */,
                87BBC79E28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 87BBC76428F9E1AB00380008 /* Project object */;
}
"""

private let merged = """
// !$*UTF8*$!
{
    archiveVersion = 1;
    classes = {
    };
    objectVersion = 56;
    objects = {

/* Begin PBXBuildFile section */
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
<<<<<<< /Users/istvanbalogh/XcodeMergeDriver/our.pbxproj
        87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AD28F9F7FA00380008 /* BViewController.swift */; };
=======
        87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AB28F9F7E700380008 /* AViewController.swift */; };
>>>>>>> /Users/istvanbalogh/XcodeMergeDriver/other.pbxproj
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
        87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
        87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC76F28F9E1AB00380008 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
        87BBC77128F9E1AB00380008 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
        87BBC77328F9E1AB00380008 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
        87BBC77628F9E1AB00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
        87BBC77828F9E1AD00380008 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
        87BBC77B28F9E1AD00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
        87BBC77D28F9E1AD00380008 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC78628F9E1AD00380008 /* SampleAppTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppTests.swift; sourceTree = "<group>"; };
        87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITests.swift; sourceTree = "<group>"; };
        87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITestsLaunchTests.swift; sourceTree = "<group>"; };
<<<<<<< /Users/istvanbalogh/XcodeMergeDriver/our.pbxproj
        87BBC7AD28F9F7FA00380008 /* BViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = BViewController.swift; sourceTree = "<group>"; };
=======
        87BBC7AB28F9F7E700380008 /* AViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AViewController.swift; sourceTree = "<group>"; };
>>>>>>> /Users/istvanbalogh/XcodeMergeDriver/other.pbxproj
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        87BBC76928F9E1AB00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77F28F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78928F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        87BBC76328F9E1AB00380008 = {
            isa = PBXGroup;
            children = (
                87BBC76E28F9E1AB00380008 /* SampleApp */,
                87BBC78528F9E1AD00380008 /* SampleAppTests */,
                87BBC78F28F9E1AD00380008 /* SampleAppUITests */,
                87BBC76D28F9E1AB00380008 /* Products */,
            );
            sourceTree = "<group>";
        };
        87BBC76D28F9E1AB00380008 /* Products */ = {
            isa = PBXGroup;
            children = (
                87BBC76C28F9E1AB00380008 /* SampleApp.app */,
                87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */,
                87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */,
            );
            name = Products;
            sourceTree = "<group>";
        };
        87BBC76E28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXGroup;
            children = (
                87BBC76F28F9E1AB00380008 /* AppDelegate.swift */,
                87BBC77128F9E1AB00380008 /* SceneDelegate.swift */,
                87BBC77328F9E1AB00380008 /* ViewController.swift */,
<<<<<<< /Users/istvanbalogh/XcodeMergeDriver/our.pbxproj
                87BBC7AD28F9F7FA00380008 /* BViewController.swift */,
=======
                87BBC7AB28F9F7E700380008 /* AViewController.swift */,
>>>>>>> /Users/istvanbalogh/XcodeMergeDriver/other.pbxproj
                87BBC77528F9E1AB00380008 /* Main.storyboard */,
                87BBC77828F9E1AD00380008 /* Assets.xcassets */,
                87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */,
                87BBC77D28F9E1AD00380008 /* Info.plist */,
            );
            path = SampleApp;
            sourceTree = "<group>";
        };
        87BBC78528F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXGroup;
            children = (
                87BBC78628F9E1AD00380008 /* SampleAppTests.swift */,
            );
            path = SampleAppTests;
            sourceTree = "<group>";
        };
        87BBC78F28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXGroup;
            children = (
                87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */,
                87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */,
            );
            path = SampleAppUITests;
            sourceTree = "<group>";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        87BBC76B28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */;
            buildPhases = (
                87BBC76828F9E1AB00380008 /* Sources */,
                87BBC76928F9E1AB00380008 /* Frameworks */,
                87BBC76A28F9E1AB00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = SampleApp;
            productName = SampleApp;
            productReference = 87BBC76C28F9E1AB00380008 /* SampleApp.app */;
            productType = "com.apple.product-type.application";
        };
        87BBC78128F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */;
            buildPhases = (
                87BBC77E28F9E1AD00380008 /* Sources */,
                87BBC77F28F9E1AD00380008 /* Frameworks */,
                87BBC78028F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78428F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppTests;
            productName = SampleAppTests;
            productReference = 87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */;
            productType = "com.apple.product-type.bundle.unit-test";
        };
        87BBC78B28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */;
            buildPhases = (
                87BBC78828F9E1AD00380008 /* Sources */,
                87BBC78928F9E1AD00380008 /* Frameworks */,
                87BBC78A28F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78E28F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppUITests;
            productName = SampleAppUITests;
            productReference = 87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */;
            productType = "com.apple.product-type.bundle.ui-testing";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        87BBC76428F9E1AB00380008 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                BuildIndependentTargetsInParallel = 1;
                LastSwiftUpdateCheck = 1400;
                LastUpgradeCheck = 1400;
                TargetAttributes = {
                    87BBC76B28F9E1AB00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                    };
                    87BBC78128F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                        87BBC78B28F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                };
            };
            buildConfigurationList = 87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */;
            compatibilityVersion = "Xcode 14.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 87BBC76328F9E1AB00380008;
            productRefGroup = 87BBC76D28F9E1AB00380008 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                87BBC76B28F9E1AB00380008 /* SampleApp */,
                87BBC78128F9E1AD00380008 /* SampleAppTests */,
                87BBC78B28F9E1AD00380008 /* SampleAppUITests */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        87BBC76A28F9E1AB00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */,
                87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */,
                87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78028F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78A28F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */,
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */,
                87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */,
                87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77E28F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78828F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */,
                87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
        87BBC78428F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */;
        };
        87BBC78E28F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */;
        };
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
        87BBC77528F9E1AB00380008 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77628F9E1AB00380008 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "<group>";
        };
        87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77B28F9E1AD00380008 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "<group>";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        87BBC79428F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = dwarf;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                ENABLE_TESTABILITY = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_DYNAMIC_NO_PIC = NO;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_OPTIMIZATION_LEVEL = 0;
                GCC_PREPROCESSOR_DEFINITIONS = (
                    "DEBUG=1",
                    "$(inherited)",
                );
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                MTL_FAST_MATH = YES;
                ONLY_ACTIVE_ARCH = YES;
                SDKROOT = iphoneos;
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
            };
            name = Debug;
        };
        87BBC79528F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                ENABLE_NS_ASSERTIONS = NO;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = NO;
                MTL_FAST_MATH = YES;
                SDKROOT = iphoneos;
                SWIFT_COMPILATION_MODE = wholemodule;
                SWIFT_OPTIMIZATION_LEVEL = "-O";
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        87BBC79728F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        87BBC79828F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
        87BBC79A28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Debug;
        };
        87BBC79B28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Release;
        };
        87BBC79D28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Debug;
        };
        87BBC79E28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79428F9E1AD00380008 /* Debug */,
                87BBC79528F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79728F9E1AD00380008 /* Debug */,
                87BBC79828F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79A28F9E1AD00380008 /* Debug */,
                87BBC79B28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79D28F9E1AD00380008 /* Debug */,
                87BBC79E28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 87BBC76428F9E1AB00380008 /* Project object */;
}
"""

private let noConflict = """
// !$*UTF8*$!
{
    archiveVersion = 1;
    classes = {
    };
    objectVersion = 56;
    objects = {

/* Begin PBXBuildFile section */
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
        87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AB28F9F7E700380008 /* AViewController.swift */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
        87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
        87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */ = {
            isa = PBXContainerItemProxy;
            containerPortal = 87BBC76428F9E1AB00380008 /* Project object */;
            proxyType = 1;
            remoteGlobalIDString = 87BBC76B28F9E1AB00380008;
            remoteInfo = SampleApp;
        };
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC76F28F9E1AB00380008 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
        87BBC77128F9E1AB00380008 /* SceneDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SceneDelegate.swift; sourceTree = "<group>"; };
        87BBC77328F9E1AB00380008 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
        87BBC77628F9E1AB00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
        87BBC77828F9E1AD00380008 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
        87BBC77B28F9E1AD00380008 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
        87BBC77D28F9E1AD00380008 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC78628F9E1AD00380008 /* SampleAppTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppTests.swift; sourceTree = "<group>"; };
        87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = SampleAppUITests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITests.swift; sourceTree = "<group>"; };
        87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SampleAppUITestsLaunchTests.swift; sourceTree = "<group>"; };
        87BBC7AB28F9F7E700380008 /* AViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AViewController.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
        87BBC76928F9E1AB00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77F28F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78928F9E1AD00380008 /* Frameworks */ = {
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
        87BBC76328F9E1AB00380008 = {
            isa = PBXGroup;
            children = (
                87BBC76E28F9E1AB00380008 /* SampleApp */,
                87BBC78528F9E1AD00380008 /* SampleAppTests */,
                87BBC78F28F9E1AD00380008 /* SampleAppUITests */,
                87BBC76D28F9E1AB00380008 /* Products */,
            );
            sourceTree = "<group>";
        };
        87BBC76D28F9E1AB00380008 /* Products */ = {
            isa = PBXGroup;
            children = (
                87BBC76C28F9E1AB00380008 /* SampleApp.app */,
                87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */,
                87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */,
            );
            name = Products;
            sourceTree = "<group>";
        };
        87BBC76E28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXGroup;
            children = (
                87BBC76F28F9E1AB00380008 /* AppDelegate.swift */,
                87BBC77128F9E1AB00380008 /* SceneDelegate.swift */,
                87BBC77328F9E1AB00380008 /* ViewController.swift */,
                87BBC7AB28F9F7E700380008 /* AViewController.swift */,
                87BBC77528F9E1AB00380008 /* Main.storyboard */,
                87BBC77828F9E1AD00380008 /* Assets.xcassets */,
                87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */,
                87BBC77D28F9E1AD00380008 /* Info.plist */,
            );
            path = SampleApp;
            sourceTree = "<group>";
        };
        87BBC78528F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXGroup;
            children = (
                87BBC78628F9E1AD00380008 /* SampleAppTests.swift */,
            );
            path = SampleAppTests;
            sourceTree = "<group>";
        };
        87BBC78F28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXGroup;
            children = (
                87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */,
                87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */,
            );
            path = SampleAppUITests;
            sourceTree = "<group>";
        };
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
        87BBC76B28F9E1AB00380008 /* SampleApp */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */;
            buildPhases = (
                87BBC76828F9E1AB00380008 /* Sources */,
                87BBC76928F9E1AB00380008 /* Frameworks */,
                87BBC76A28F9E1AB00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
            );
            name = SampleApp;
            productName = SampleApp;
            productReference = 87BBC76C28F9E1AB00380008 /* SampleApp.app */;
            productType = "com.apple.product-type.application";
        };
        87BBC78128F9E1AD00380008 /* SampleAppTests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */;
            buildPhases = (
                87BBC77E28F9E1AD00380008 /* Sources */,
                87BBC77F28F9E1AD00380008 /* Frameworks */,
                87BBC78028F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78428F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppTests;
            productName = SampleAppTests;
            productReference = 87BBC78228F9E1AD00380008 /* SampleAppTests.xctest */;
            productType = "com.apple.product-type.bundle.unit-test";
        };
        87BBC78B28F9E1AD00380008 /* SampleAppUITests */ = {
            isa = PBXNativeTarget;
            buildConfigurationList = 87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */;
            buildPhases = (
                87BBC78828F9E1AD00380008 /* Sources */,
                87BBC78928F9E1AD00380008 /* Frameworks */,
                87BBC78A28F9E1AD00380008 /* Resources */,
            );
            buildRules = (
            );
            dependencies = (
                87BBC78E28F9E1AD00380008 /* PBXTargetDependency */,
            );
            name = SampleAppUITests;
            productName = SampleAppUITests;
            productReference = 87BBC78C28F9E1AD00380008 /* SampleAppUITests.xctest */;
            productType = "com.apple.product-type.bundle.ui-testing";
        };
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        87BBC76428F9E1AB00380008 /* Project object */ = {
            isa = PBXProject;
            attributes = {
                BuildIndependentTargetsInParallel = 1;
                LastSwiftUpdateCheck = 1400;
                LastUpgradeCheck = 1400;
                TargetAttributes = {
                    87BBC76B28F9E1AB00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                    };
                    87BBC78128F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                        87BBC78B28F9E1AD00380008 = {
                        CreatedOnToolsVersion = 14.0.1;
                        TestTargetID = 87BBC76B28F9E1AB00380008;
                    };
                };
            };
            buildConfigurationList = 87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */;
            compatibilityVersion = "Xcode 14.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            knownRegions = (
                en,
                Base,
            );
            mainGroup = 87BBC76328F9E1AB00380008;
            productRefGroup = 87BBC76D28F9E1AB00380008 /* Products */;
            projectDirPath = "";
            projectRoot = "";
            targets = (
                87BBC76B28F9E1AB00380008 /* SampleApp */,
                87BBC78128F9E1AD00380008 /* SampleAppTests */,
                87BBC78B28F9E1AD00380008 /* SampleAppUITests */,
            );
        };
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
        87BBC76A28F9E1AB00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */,
                87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */,
                87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78028F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78A28F9E1AD00380008 /* Resources */ = {
            isa = PBXResourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */,
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */,
                87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC77E28F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
        87BBC78828F9E1AD00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */,
                87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */,
            );
            runOnlyForDeploymentPostprocessing = 0;
        };
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
        87BBC78428F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78328F9E1AD00380008 /* PBXContainerItemProxy */;
        };
        87BBC78E28F9E1AD00380008 /* PBXTargetDependency */ = {
            isa = PBXTargetDependency;
            target = 87BBC76B28F9E1AB00380008 /* SampleApp */;
            targetProxy = 87BBC78D28F9E1AD00380008 /* PBXContainerItemProxy */;
        };
/* End PBXTargetDependency section */

/* Begin PBXVariantGroup section */
        87BBC77528F9E1AB00380008 /* Main.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77628F9E1AB00380008 /* Base */,
            );
            name = Main.storyboard;
            sourceTree = "<group>";
        };
        87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */ = {
            isa = PBXVariantGroup;
            children = (
                87BBC77B28F9E1AD00380008 /* Base */,
            );
            name = LaunchScreen.storyboard;
            sourceTree = "<group>";
        };
/* End PBXVariantGroup section */

/* Begin XCBuildConfiguration section */
        87BBC79428F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = dwarf;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                ENABLE_TESTABILITY = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_DYNAMIC_NO_PIC = NO;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_OPTIMIZATION_LEVEL = 0;
                GCC_PREPROCESSOR_DEFINITIONS = (
                    "DEBUG=1",
                    "$(inherited)",
                );
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                MTL_FAST_MATH = YES;
                ONLY_ACTIVE_ARCH = YES;
                SDKROOT = iphoneos;
                SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                SWIFT_OPTIMIZATION_LEVEL = "-Onone";
            };
            name = Debug;
        };
        87BBC79528F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_SEARCH_USER_PATHS = NO;
                CLANG_ANALYZER_NONNULL = YES;
                CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
                CLANG_ENABLE_MODULES = YES;
                CLANG_ENABLE_OBJC_ARC = YES;
                CLANG_ENABLE_OBJC_WEAK = YES;
                CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                CLANG_WARN_BOOL_CONVERSION = YES;
                CLANG_WARN_COMMA = YES;
                CLANG_WARN_CONSTANT_CONVERSION = YES;
                CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                CLANG_WARN_EMPTY_BODY = YES;
                CLANG_WARN_ENUM_CONVERSION = YES;
                CLANG_WARN_INFINITE_RECURSION = YES;
                CLANG_WARN_INT_CONVERSION = YES;
                CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
                CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                CLANG_WARN_STRICT_PROTOTYPES = YES;
                CLANG_WARN_SUSPICIOUS_MOVE = YES;
                CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                CLANG_WARN_UNREACHABLE_CODE = YES;
                CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                COPY_PHASE_STRIP = NO;
                DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                ENABLE_NS_ASSERTIONS = NO;
                ENABLE_STRICT_OBJC_MSGSEND = YES;
                GCC_C_LANGUAGE_STANDARD = gnu11;
                GCC_NO_COMMON_BLOCKS = YES;
                GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                GCC_WARN_UNDECLARED_SELECTOR = YES;
                GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                GCC_WARN_UNUSED_FUNCTION = YES;
                GCC_WARN_UNUSED_VARIABLE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MTL_ENABLE_DEBUG_INFO = NO;
                MTL_FAST_MATH = YES;
                SDKROOT = iphoneos;
                SWIFT_COMPILATION_MODE = wholemodule;
                SWIFT_OPTIMIZATION_LEVEL = "-O";
                VALIDATE_PRODUCT = YES;
            };
            name = Release;
        };
        87BBC79728F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Debug;
        };
        87BBC79828F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                INFOPLIST_FILE = SampleApp/Info.plist;
                INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
                INFOPLIST_KEY_UILaunchStoryboardName = LaunchScreen;
                INFOPLIST_KEY_UIMainStoryboardFile = Main;
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                );
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleApp;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = YES;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
            };
            name = Release;
        };
        87BBC79A28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Debug;
        };
        87BBC79B28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                IPHONEOS_DEPLOYMENT_TARGET = 16.0;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/SampleApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/SampleApp";
            };
            name = Release;
        };
        87BBC79D28F9E1AD00380008 /* Debug */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Debug;
        };
        87BBC79E28F9E1AD00380008 /* Release */ = {
            isa = XCBuildConfiguration;
            buildSettings = {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                CODE_SIGN_STYLE = Automatic;
                CURRENT_PROJECT_VERSION = 1;
                DEVELOPMENT_TEAM = 943X8ZW8WL;
                GENERATE_INFOPLIST_FILE = YES;
                MARKETING_VERSION = 1.0;
                PRODUCT_BUNDLE_IDENTIFIER = com.istvanBalogh.SampleAppUITests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_EMIT_LOC_STRINGS = NO;
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_TARGET_NAME = SampleApp;
            };
            name = Release;
        };
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        87BBC76728F9E1AB00380008 /* Build configuration list for PBXProject "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79428F9E1AD00380008 /* Debug */,
                87BBC79528F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79628F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleApp" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79728F9E1AD00380008 /* Debug */,
                87BBC79828F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79928F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppTests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79A28F9E1AD00380008 /* Debug */,
                87BBC79B28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
        87BBC79C28F9E1AD00380008 /* Build configuration list for PBXNativeTarget "SampleAppUITests" */ = {
            isa = XCConfigurationList;
            buildConfigurations = (
                87BBC79D28F9E1AD00380008 /* Debug */,
                87BBC79E28F9E1AD00380008 /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        };
/* End XCConfigurationList section */
    };
    rootObject = 87BBC76428F9E1AB00380008 /* Project object */;
}
"""
