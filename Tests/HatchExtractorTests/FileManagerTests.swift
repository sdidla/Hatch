import XCTest
@testable import HatchExtractor

final class FileManagerTests: XCTestCase {
    func testFilePathsInDirectory() throws {
        let resourceURL = try XCTUnwrap(Bundle.module.resourceURL)
        let directoryURL = resourceURL.appendingPathComponent("RootDirectoryMock", isDirectory: true)
        let fileURLs = FileManager.default.filesInDirectory(directoryURL)

        XCTAssertEqual(fileURLs.count, 3)
        XCTAssertEqual(fileURLs[0].lastPathComponent, "SubdirectoryFile.swift")
        XCTAssertEqual(fileURLs[1].lastPathComponent, "DirectoryFile.swift")
        XCTAssertEqual(fileURLs[2].lastPathComponent, "TestFile.swift")
    }
}

 
