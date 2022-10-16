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
    
    var outputFile: String?
    var launcehdFromXcode: Bool = false
    
    public init() { }
    
    mutating public func run() throws {
        print("Merge driver launched")
        if launcehdFromXcode {
            currentFile = FileManager().currentDirectoryPath + "/" + currentFile
            baseFile = FileManager().currentDirectoryPath + "/" + baseFile
            otherFile = FileManager().currentDirectoryPath + "/" + otherFile
        }
        let outputFile = FileManager().currentDirectoryPath + "/" + (outputFile ?? currentFile)
        
        let currentXcodeProject = try xcodeProjectFromFile(fileName: currentFile)
        let baseXcodeProject = try xcodeProjectFromFile(fileName: baseFile)
        let otherXcodeProject = try xcodeProjectFromFile(fileName: otherFile)
        
        print("Resolving conflicts")
        try currentXcodeProject.mergeChanges(from: baseXcodeProject, to: otherXcodeProject) {
            try Bash().run(commandName: "git", arguments: ["merge-file", currentFile, baseFile, otherFile])
            return try xcodeProjectFromFile(fileName: currentFile)
        }
        
        print("All conflicts resolved")
        try xcodeProjectToFile(currentXcodeProject, fileName: outputFile)
    }
    
    
    func xcodeProjectFromFile(fileName: String) throws -> XcodeProject {
        let fileURL = URL(fileURLWithPath: fileName)
        let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        return try XcodeProject(content: fileContent)
    }
    
    func xcodeProjectToFile(_ project: XcodeProject, fileName: String) throws {
        try project.content.write(toFile: fileName, atomically: true, encoding: .utf8)
    }
}

enum MergeError: Error {
    case wrongFilePath
    case unsupported
    case parsingError
}

