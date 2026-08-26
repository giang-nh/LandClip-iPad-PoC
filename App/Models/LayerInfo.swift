import Foundation

struct LayerInfo: Identifiable, Equatable, Sendable {
    let id: String
    let geodatabase: String
    let name: String
    let geometryType: String
    let featureCount: Int?
}

struct PackageCatalog: Equatable, Sendable {
    let packageName: String
    let packageSize: Int64
    let layers: [LayerInfo]
}

