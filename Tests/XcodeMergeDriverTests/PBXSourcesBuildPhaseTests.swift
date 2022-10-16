//
//  PBXSourcesBuildPhaseTests.swift
//  
//
//  Created by Istvan Balogh on 16.10.22.
//

import XCTest
@testable import XcodeMergeDriver

class PBXSourcesBuildPhase: Equatable {
    
    private(set) var content: String
    private(set) var files: [PBXGroupChildLine]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let filesSeparator = Separator(begin: "files = (\n", end: ");\n")
    
    init(content: String) throws {
        self.content = content
        let files = self.content
            .sliceBetween(filesSeparator)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n") ?? []
        self.files = try files.map { try PBXGroupChildLine(content: $0) }
    }
    
    func difference(from base: PBXSourcesBuildPhase) -> CollectionDifference<PBXGroupChildLine> {
        let difference = files.difference(from: base.files) { $0 == $1 }
        return difference
    }
    
    @discardableResult
    func applying(_ difference: CollectionDifference<PBXGroupChildLine>) throws -> String {
        let oldContent = content
        let oldFiles = files.map { $0.content }.joined(separator: "\n")
        guard let changedFiles = files.applying(difference) else {
            throw MergeError.unsupported
        }
        files = changedFiles
        let newFiles = files.map { $0.content }.joined(separator: "\n")
        content = content.replacingOccurrences(of: oldFiles, with: newFiles)
        return oldContent
    }
    
    static func == (lhs: PBXSourcesBuildPhase, rhs: PBXSourcesBuildPhase) -> Bool {
        lhs.content == rhs.content
    }
}

class PBXSourcesBuildPhaseSection: Equatable {
    
    static let sourcesBuildPhaseSeparator = Separator(begin: "/* Begin PBXSourcesBuildPhase section */\n", end: "\n/* End PBXSourcesBuildPhase section */")
    
    private(set) var content: String
    let buildPhases: [PBXSourcesBuildPhase]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?) throws {
        guard let content = content?.sliceBetween(Self.sourcesBuildPhaseSeparator)?.trimmingCharacters(in: .whitespacesAndNewlines) else { throw MergeError.parsingError }
        self.content = content
        self.buildPhases = try self.content.components(separatedBy: "};\n").map { try PBXSourcesBuildPhase(content: $0) }
    }
    
    func mergeChanges(from base: PBXSourcesBuildPhaseSection, to other: PBXSourcesBuildPhaseSection, merged: PBXSourcesBuildPhaseSection) throws {
        try merged.buildPhases.enumerated().forEach { conflictGroupSequence in
            if conflictGroupSequence.element.hasConflict {
                let sameBaseGroup = base.buildPhases[conflictGroupSequence.offset]
                let sameOtherGroup = other.buildPhases[conflictGroupSequence.offset]
                let sameCurrentGroup = buildPhases[conflictGroupSequence.offset]
                let difference = sameOtherGroup.difference(from: sameBaseGroup)
                let oldGroupContent = try sameCurrentGroup.applying(difference)
                content = content.replacingOccurrences(of: oldGroupContent, with: sameCurrentGroup.content)
            }
        }
    }
    
    static func == (lhs: PBXSourcesBuildPhaseSection, rhs: PBXSourcesBuildPhaseSection) -> Bool {
        lhs.content == rhs.content
    }
}

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
