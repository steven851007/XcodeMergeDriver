//
//  PBXGroupSectionTests.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import XCTest
@testable import XcodeMergeDriver

final class PBXGroupSectionTests: XCTestCase {

    func test_init_parseCorrectly() throws {
        let base = try PBXGroupSection(content: baseGroup)
        let expectedChildrenCounts = [4, 3, 7, 1, 2]
        let expectedNames = ["Main", "Products", "SampleApp", "SampleAppTests", "SampleAppUITests"]
        
        base.groups.enumerated().forEach { sequence in
            XCTAssertEqual(sequence.element.children.count, expectedChildrenCounts[sequence.offset])
            XCTAssertEqual(sequence.element.name, expectedNames[sequence.offset])
        }
        
        XCTAssertEqual(base.groups.count, 5)
        XCTAssertEqual(base.groups.first?.children.first, try PBXGroupChildLine(content: " /* SampleApp */,"))
    }
    
    func test_hasConflict() throws {
        let conflict = try PBXGroupSection(content: conflictGroup)
        XCTAssertFalse(try PBXGroupSection(content: baseGroup).hasConflict)
        XCTAssert(conflict.hasConflict)
        XCTAssert(conflict.groups[2].hasConflict)
    }
    
    func test() throws {
        let base = try PBXGroupSection(content: baseGroup)
        let current = try PBXGroupSection(content: currentGroup)
        let other = try PBXGroupSection(content: otherGroup)
        let conflict = try PBXGroupSection(content: conflictGroup)

        try current.mergeChanges(from: base, to: other, merged: conflict)

        XCTAssertEqual(current, try PBXGroupSection(content: resolvedGroup))
    }
}

private let currentGroup = """
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
"""

private let otherGroup = """
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
"""

private let resolvedGroup = """
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
"""

private let conflictGroup = """
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
"""

private let baseGroup = """
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
"""
