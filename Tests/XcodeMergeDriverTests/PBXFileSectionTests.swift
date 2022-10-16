//
//  PBXBuildFileTests.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import XCTest
@testable import XcodeMergeDriver

final class PBXFileSectionTests: XCTestCase {
    
    func test_changeSet_returnsCorrectChangeWhenLineAddedBuildType() throws {
        let base = try PBXFileSection(content: baseBuildFile, type: .build)
        var current = try PBXFileSection(content: currentBuildFile, type: .build)
        let other = try PBXFileSection(content: otherBuildFile, type: .build)
        
        let otherChangeset = other.difference(from: base)
        current.applying(otherChangeset)
        
        XCTAssertEqual(current, try PBXFileSection(content: resolvedBuildFile, type: .build))
    }
    
    func test_changeSet_returnsCorrectChangeWhenLineAddedReferenceType() throws {
        let base = try PBXFileSection(content: baseReferenceFile, type: .reference)
        var current = try PBXFileSection(content: currentReferenceFile, type: .reference)
        let other = try PBXFileSection(content: otherReferenceFile, type: .reference)
        
        let otherChangeset = other.difference(from: base)
        current.applying(otherChangeset)
        
        XCTAssertEqual(current, try PBXFileSection(content: resolvedReferenceFile, type: .reference))
    }
    
    func test_changeSet_returnsCorrectChangeWhenLineWhenManyDeleted() throws {
        let base = try PBXFileSection(content: baseDeletedFile, type: .reference)
        var current = try PBXFileSection(content: otherDeletedFile, type: .reference)
        let other = try PBXFileSection(content: currentDeletedFile, type: .reference)
        
        let otherChangeset = other.difference(from: base)
        current.applying(otherChangeset)
        
        XCTAssertEqual(current, try PBXFileSection(content: resolvedDeletedFile, type: .reference))
    }
    
}

private let resolvedDeletedFile = """
    /* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
        87BBC7AD28F9F7FA00380008 /* BViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = BViewController.swift; sourceTree = "<group>"; };
        87BBC7AB28F9F7E700380008 /* AViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AViewController.swift; sourceTree = "<group>"; };
    /* End PBXFileReference section */
"""

private let currentDeletedFile = """
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
        87BBC7AB28F9F7E700380008 /* AViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AViewController.swift; sourceTree = "<group>"; };
    /* End PBXFileReference section */
"""

private let otherDeletedFile = """
    /* Begin PBXFileReference section */
        87BBC76C28F9E1AB00380008 /* SampleApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SampleApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
    /* End PBXFileReference section */
"""

private let baseDeletedFile = """
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
"""

private let resolvedReferenceFile = """
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
        87BBC7AB28F9F7E700380008 /* AViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AViewController.swift; sourceTree = "<group>"; };
    /* End PBXFileReference section */
"""

private let currentReferenceFile = """
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
"""

private let otherReferenceFile = """
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
"""

private let baseReferenceFile = """
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
"""

private let baseBuildFile = """
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
"""

private let currentBuildFile = """
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
"""

private let otherBuildFile = """
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
"""

private let resolvedBuildFile = """
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
        87BBC7AC28F9F7E700380008 /* AViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC7AB28F9F7E700380008 /* AViewController.swift */; };
    /* End PBXBuildFile section */
"""
