import ArgumentParser
import Foundation

@main
public struct XcodeMergeDriver: ParsableCommand {
    @Argument(help: "filepath to our version of the conflicted file")
    var pathToOurVersion: String
    
    @Argument(help: "filepath to the base version of the file")
    var pathToBaseVersion: String
    
    @Argument(help: "filepath to the other branches version of the file")
    var pathToOtherVersion: String
    
    var ourVersionContent: String = ""
    var baseVersionContent: String = ""
    var otherVersionContent: String = ""
    
    var output: String = ""
    public init() { }
    
    mutating public func run() throws {
        
        output = pathToOurVersion + pathToBaseVersion + pathToOtherVersion
        if ourVersionContent.isEmpty {
            ourVersionContent = try readFile(fileName: pathToOurVersion)
        }
        if baseVersionContent.isEmpty {
            baseVersionContent = try readFile(fileName: pathToBaseVersion)
        }
        if otherVersionContent.isEmpty {
            otherVersionContent = try readFile(fileName: pathToOtherVersion)
        }

        
        
        throw MergeError.wrongFilePath
    }
    
    func readFile(fileName: String) throws -> String {
        let filePath = "/Users/istvanbalogh/XcodeMergeDriver" + "/\(fileName)" //FileManager.default.currentDirectoryPath
        print(filePath)
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        return fileContent
    }
}

enum MergeError: Error {
    case wrongFilePath
}
