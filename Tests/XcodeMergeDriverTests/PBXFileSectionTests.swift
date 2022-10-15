//
//  PBXBuildFileTests.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import XCTest
@testable import XcodeMergeDriver

final class PBXFileSectionTests: XCTestCase {
    
    func test_changeSet_returnsCorrectChangeWhenLineAdded() throws {
        let base = try PBXFileSection(content: baseFile, type: .build)
        var current = try PBXFileSection(content: currentFile, type: .build)
        let other = try PBXFileSection(content: otherFile, type: .build)
        
        let otherChangeset = other.difference(from: base)
        try current.applying(otherChangeset)
        
        XCTAssertEqual(current, try PBXFileSection(content: resolvedFile, type: .build))
    }
    
}

private let baseFile = """
        87BBC77028F9E1AB00380008 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC76F28F9E1AB00380008 /* AppDelegate.swift */; };
        87BBC77228F9E1AB00380008 /* SceneDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77128F9E1AB00380008 /* SceneDelegate.swift */; };
        87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC77328F9E1AB00380008 /* ViewController.swift */; };
        87BBC77728F9E1AB00380008 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77528F9E1AB00380008 /* Main.storyboard */; };
        87BBC77928F9E1AD00380008 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77828F9E1AD00380008 /* Assets.xcassets */; };
        87BBC77C28F9E1AD00380008 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 87BBC77A28F9E1AD00380008 /* LaunchScreen.storyboard */; };
        87BBC78728F9E1AD00380008 /* SampleAppTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC78628F9E1AD00380008 /* SampleAppTests.swift */; };
        87BBC79128F9E1AD00380008 /* SampleAppUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79028F9E1AD00380008 /* SampleAppUITests.swift */; };
        87BBC79328F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 87BBC79228F9E1AD00380008 /* SampleAppUITestsLaunchTests.swift */; };
"""

private let currentFile = """
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
"""

private let otherFile = """
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
"""

private let resolvedFile = """
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
"""
