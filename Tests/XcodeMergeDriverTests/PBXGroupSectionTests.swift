//
//  PBXGroupSectionTests.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import XCTest
@testable import XcodeMergeDriver

class PBXGroupChildLine: Equatable {
    let content: String
    let comparableValue: String?
    
    init(content: String?) throws {
        guard let content else { throw MergeError.parsingError }
        self.content = content
        self.comparableValue = content.slice(from: " /* ", to: " */,")
    }
    
    static func == (lhs: PBXGroupChildLine, rhs: PBXGroupChildLine) -> Bool {
        lhs.comparableValue == rhs.comparableValue
    }
}

class PBXGroup: Equatable {
    
    private(set) var content: String
    private(set) var children: [PBXGroupChildLine]
    let name: String
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let childrenSeparator = (begin: "children = (\n", end: ");\n")
    
    init(content: String) throws {
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        let children = self.content
            .slice(from: childrenSeparator.begin, to: childrenSeparator.end)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n") ?? []
        self.children = try children.map { try PBXGroupChildLine(content: $0) }
        self.name = self.content.slice(from: " /* ", to: " */ = {") ?? "Main"
    }
    
    func difference(from base: PBXGroup) -> CollectionDifference<PBXGroupChildLine> {
        let difference = children.difference(from: base.children) { $0 == $1 }
        return difference
    }

    @discardableResult
    func applying(_ difference: CollectionDifference<PBXGroupChildLine>) throws -> String {
        let oldContent = content
        let oldChildren = children.map { $0.content }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        guard let changedChildren = children.applying(difference) else {
            throw MergeError.unsupported
        }
        children = changedChildren
        let newChildren = children.map { $0.content }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: oldChildren, with: newChildren)
        return oldContent
    }
    
    static func == (lhs: PBXGroup, rhs: PBXGroup) -> Bool {
        lhs.content == rhs.content
    }
}

class PBXGroupSection: Equatable {
    private(set) var content: String
    private(set) var groups: [PBXGroup]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String) throws {
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.groups = try self.content.components(separatedBy: "};\n").map { try PBXGroup(content: $0) }
    }
    
    func mergeChanges(from base: PBXGroupSection, to other: PBXGroupSection, merged: PBXGroupSection) throws {
        try merged.groups.forEach { conflictGroup in
            if conflictGroup.hasConflict,
               let sameBaseGroup = base.groupWithName(conflictGroup.name),
               let sameOtherGroup = other.groupWithName(conflictGroup.name),
               let sameCurrentGroup = groupWithName(conflictGroup.name)
            {
                let difference = sameOtherGroup.difference(from: sameBaseGroup)
                let oldGroupContent = try sameCurrentGroup.applying(difference)
                content = content.replacingOccurrences(of: oldGroupContent, with: sameCurrentGroup.content)
            }
        }
    }
    
    func groupWithName(_ name: String) -> PBXGroup? {
        groups.first { $0.name == name }
    }
    
    static func == (lhs: PBXGroupSection, rhs: PBXGroupSection) -> Bool {
        lhs.content == rhs.content
    }
}

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
"""
