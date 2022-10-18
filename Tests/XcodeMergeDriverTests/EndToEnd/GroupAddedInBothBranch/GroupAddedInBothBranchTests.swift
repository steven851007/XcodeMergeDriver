//
//  FileAddedInBothBranchTests.swift
//  
//
//  Created by Istvan Balogh on 16.10.22.
//

import XCTest
@testable import XcodeMergeDriver

final class GroupAddedInBothBranchTests: XCTestCase {

    private let filePath = "/Tests/XcodeMergeDriverTests/EndToEnd/GroupAddedInBothBranch/"
    private lazy var resolvedPath = FileManager().currentDirectoryPath + filePath + "resolved"
    private lazy var outputPath = FileManager().currentDirectoryPath + filePath + "output"
    private lazy var currentPath = FileManager().currentDirectoryPath + filePath + "current"
    private var currentContentToReset: String!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        currentContentToReset = try String(contentsOf: URL(fileURLWithPath: currentPath), encoding: .utf8)
    }
    
    override func tearDownWithError() throws {
        try currentContentToReset.write(toFile: currentPath, atomically: true, encoding: .utf8)
        try super.tearDownWithError()
    }
    
    func test_merge_groupAddedInBothBranch() throws {
        var driver = makeSUT()
        
        try driver.run()
        
        let resolved = try xcodeProjectFromFile(fileName: resolvedPath)
        let output = try xcodeProjectFromFile(fileName: outputPath)
        XCTAssertEqual(resolved.pbxBuildFile, output.pbxBuildFile, "Resolved pbxBuildFile different from output pbxBuildFile")
        XCTAssertEqual(resolved.pbxfileReference, output.pbxfileReference, "Resolved pbxfileReference different from output pbxfileReference")
        XCTAssertEqual(resolved.pbxGroupSection, output.pbxGroupSection, "Resolved pbxGroupSection different from output pbxGroupSection")
        XCTAssertEqual(resolved.content, output.content, "Resolved content different from output content")
        XCTAssert(FileManager().contentsEqual(atPath: resolvedPath, andPath: outputPath))
    }
    
    func xcodeProjectFromFile(fileName: String) throws -> XcodeProject {
        let fileURL = URL(fileURLWithPath: fileName)
        let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        return try XcodeProject(content: fileContent)
    }
    
    private func makeSUT() -> XcodeMergeDriver {
        var driver = XcodeMergeDriver()
        driver.currentFile = filePath + "current"
        driver.baseFile = filePath + "base"
        driver.otherFile = filePath + "other"
        driver.outputFile = filePath + "output"
        driver.launcehdFromXcode = true
        
        return driver
    }
}
