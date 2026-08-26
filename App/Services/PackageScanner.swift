import Foundation

protocol PackageScanning: Sendable {
    func scan(packageURL: URL) async throws -> PackageCatalog
}

enum PackageScanError: LocalizedError {
    case invalidExtension
    case nativeEngineUnavailable

    var errorDescription: String? {
        switch self {
        case .invalidExtension:
            return "Hãy chọn file có phần mở rộng .ppkx."
        case .nativeEngineUnavailable:
            return "GIS engine native chưa được tích hợp trong bản PoC này."
        }
    }
}

struct MockPackageScanner: PackageScanning {
    func scan(packageURL: URL) async throws -> PackageCatalog {
        guard packageURL.pathExtension.lowercased() == "ppkx" else {
            throw PackageScanError.invalidExtension
        }
        let values = try packageURL.resourceValues(forKeys: [.fileSizeKey])
        try await Task.sleep(for: .milliseconds(350))
        return PackageCatalog(
            packageName: packageURL.lastPathComponent,
            packageSize: Int64(values.fileSize ?? 0),
            layers: []
        )
    }
}

