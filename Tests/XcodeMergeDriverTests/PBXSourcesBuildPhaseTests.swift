//
//  PBXSourcesBuildPhaseTests.swift
//  
//
//  Created by Istvan Balogh on 16.10.22.
//

import XCTest
@testable import XcodeMergeDriver

final class PBXSourcesBuildPhaseTests: XCTestCase {

    func test_init_throwsWithWrongContent() {
        XCTAssertThrowsError(try PBXSourcesBuildPhaseSection(content: ""))
    }
    
    func test_init_parseCorrectly() throws {
        let base = try PBXSourcesBuildPhaseSection(content: base)
        let expectedFileCounts = [4, 1, 2]
        
        base.buildPhases.enumerated().forEach { sequence in
            XCTAssertEqual(sequence.element.files.count, expectedFileCounts[sequence.offset])
        }
        
        XCTAssertEqual(base.buildPhases.count, 3)
        XCTAssertEqual(base.buildPhases.first?.files.first, try PBXGroupChildLine(content: " /* ViewController.swift in Sources */,"))
    }
    
    func test_hasConflict() throws {
        let conflict = try PBXSourcesBuildPhaseSection(content: conflict)
        XCTAssertFalse(try PBXSourcesBuildPhaseSection(content: base).hasConflict)
        XCTAssert(conflict.hasConflict)
        XCTAssert(conflict.buildPhases[0].hasConflict)
    }
    
    func test_mergeChanges_correctlyMergesChanges() throws {
        let base = try PBXSourcesBuildPhaseSection(content: base)
        let current = try PBXSourcesBuildPhaseSection(content: current)
        let other = try PBXSourcesBuildPhaseSection(content: other)
        let conflict = try PBXSourcesBuildPhaseSection(content: conflict)

        try current.mergeChanges(from: base, to: other, merged: conflict)

        XCTAssertEqual(current, try PBXSourcesBuildPhaseSection(content: resolved))
    }

}

private let resolved = """
/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC7B528FBFC4E00380008 /* CViewController.swift in Sources */,
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
"""

private let other = """
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
"""

private let current = """
/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
                87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */,
                87BBC7B528FBFC4E00380008 /* CViewController.swift in Sources */,
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
"""

private let conflict = """
/* Begin PBXSourcesBuildPhase section */
        87BBC76828F9E1AB00380008 /* Sources */ = {
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                87BBC77428F9E1AB00380008 /* ViewController.swift in Sources */,
<<<<<<< /Users/istvanbalogh/XcodeMergeDriver/Tests/XcodeMergeDriverTests/EndToEnd/FileAddedAndRemoved/current
                87BBC7AE28F9F7FA00380008 /* BViewController.swift in Sources */,
                87BBC7B528FBFC4E00380008 /* CViewController.swift in Sources */,
=======
>>>>>>> /Users/istvanbalogh/XcodeMergeDriver/Tests/XcodeMergeDriverTests/EndToEnd/FileAddedAndRemoved/other
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
"""

private let base = """
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
"""
