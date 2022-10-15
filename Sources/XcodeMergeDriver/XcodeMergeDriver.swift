import ArgumentParser
import Foundation

@available(macOS 10.15, *)
@main
public struct XcodeMergeDriver: ParsableCommand {
    @Argument(help: "filepath to our version of the conflicted file")
    var currentFile: String
    
    @Argument(help: "filepath to the base version of the file")
    var baseFile: String
    
    @Argument(help: "filepath to the other branches version of the file")
    var otherFile: String
    
    var currentContent: String = ""
    var baseContent: String = ""
    var otherContent: String = ""
    
    var output: String = ""
    
    public init() { }
    
    mutating public func run() throws {
        
        var currentXcodeProject = try xcodeProjectFromFile(fileName: currentFile)
        let baseXcodeProject = try xcodeProjectFromFile(fileName: baseFile)
        let otherXcodeProject = try xcodeProjectFromFile(fileName: otherFile)

        try Bash().run(commandName: "git", arguments: ["merge-file", currentFile, baseFile, otherFile])
        
        let mergedXcodeProject = try xcodeProjectFromFile(fileName: currentFile)
        
        guard mergedXcodeProject.hasConflict else { return }
        
        try currentXcodeProject.mergeChanges(from: baseXcodeProject, to: otherXcodeProject, merged: mergedXcodeProject)
        
        throw MergeError.wrongFilePath
    }
    
    
    func xcodeProjectFromFile(fileName: String) throws -> XcodeProject {
//        let filePath = "/Users/istvanbalogh/XcodeMergeDriver" + "/\(fileName)" //FileManager.default.currentDirectoryPath
//        print(filePath)
        let fileURL = URL(fileURLWithPath: fileName)
        let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        return try XcodeProject(content: fileContent)
    }
}

enum MergeError: Error {
    case wrongFilePath
    case unsupported
}

