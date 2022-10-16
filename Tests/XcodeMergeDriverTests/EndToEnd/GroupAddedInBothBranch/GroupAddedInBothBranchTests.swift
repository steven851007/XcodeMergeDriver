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
    
    func test_merge_fileAddedInBothBranch() throws {
        var driver = makeSUT()
        
        try driver.run()
        
        XCTAssert(FileManager().contentsEqual(atPath: resolvedPath, andPath: outputPath))
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
