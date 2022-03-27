import Foundation

extension FileManager {
    /// Performs a deep enumeration of a directory and returns URLs of all files within it
    public func filesInDirectory(_ directoryURL: URL) -> [URL] {
        guard let enumerator = enumerator(at: directoryURL, includingPropertiesForKeys: []) else {
            return []
        }

        return enumerator
            .compactMap { $0 as? URL }
            .filter { $0.hasDirectoryPath == false }
    }
}
