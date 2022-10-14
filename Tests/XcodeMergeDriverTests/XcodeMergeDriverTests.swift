import XCTest
@testable import XcodeMergeDriver

final class XcodeMergeDriverTests: XCTestCase {
    func testExample() throws {
        var driver = XcodeMergeDriver()
        driver.pathToOurVersion = "my-file.mrg"
        driver.pathToBaseVersion = "Hello, World!"
        driver.pathToOtherVersion = "Hello, World!"
        try driver.run()
        XCTAssertEqual(driver.output, "my-file.mrgHello, World!Hello, World!")
    }
}
