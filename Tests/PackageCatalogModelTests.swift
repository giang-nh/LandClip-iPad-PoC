import XCTest
@testable import LandClipIPad

private struct SuccessfulScanner: PackageScanning {
    func scan(packageURL: URL) async throws -> PackageCatalog {
        PackageCatalog(
            packageName: packageURL.lastPathComponent,
            packageSize: 42,
            layers: [LayerInfo(id: "main/roads", geodatabase: "main.gdb", name: "roads", geometryType: "LineString", featureCount: 3)]
        )
    }
}

@MainActor
final class PackageCatalogModelTests: XCTestCase {
    func testScanPublishesCatalog() async {
        let model = PackageCatalogModel(scanner: SuccessfulScanner())
        await model.scan(URL(fileURLWithPath: "/tmp/sample.ppkx"))

        guard case let .ready(catalog) = model.state else {
            return XCTFail("Expected ready state")
        }
        XCTAssertEqual(catalog.packageName, "sample.ppkx")
        XCTAssertEqual(catalog.layers.first?.name, "roads")
    }
}
