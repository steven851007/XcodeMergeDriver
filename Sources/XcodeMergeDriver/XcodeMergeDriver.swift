import ArgumentParser
import Foundation

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
        
        
        output = currentFile + baseFile + otherFile
        if currentContent.isEmpty {
            currentContent = try readFile(fileName: currentFile)
        }
        if baseContent.isEmpty {
            baseContent = try readFile(fileName: baseFile)
        }
        if otherContent.isEmpty {
            otherContent = try readFile(fileName: otherFile)
        }

        let bash: CommandExecuting = Bash()
        try bash.run(commandName: "git", arguments: ["merge-file", currentFile, baseFile, otherFile])
        
        throw MergeError.wrongFilePath
    }
    
    func readFile(fileName: String) throws -> String {
//        let filePath = "/Users/istvanbalogh/XcodeMergeDriver" + "/\(fileName)" //FileManager.default.currentDirectoryPath
//        print(filePath)
        let fileURL = URL(fileURLWithPath: fileName)
        let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        return fileContent
    }
}

enum MergeError: Error {
    case wrongFilePath
}
