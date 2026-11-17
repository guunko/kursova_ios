import Foundation

// MARK: - Основна модель станції (відповідь Open Charge Map: масив таких об'єктів)
struct ChargingStation: Codable, Identifiable, Hashable {
    let id: Int
    let addressInfo: AddressInfo
    let connections: [Connection]?
    let operatorInfo: OperatorInfo?
    let usageCost: String?
    let numberOfPoints: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case addressInfo = "AddressInfo"
        case connections = "Connections"
        case operatorInfo = "OperatorInfo"
        case usageCost = "UsageCost"
        case numberOfPoints = "NumberOfPoints"
    }
}

struct AddressInfo: Codable, Hashable {
    let title: String
    let addressLine1: String?
    let town: String?
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case addressLine1 = "AddressLine1"
        case town = "Town"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

struct Connection: Codable, Identifiable, Hashable {
    let id: Int
    let powerKW: Double?
    let connectionType: ConnectionType?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case powerKW = "PowerKW"
        case connectionType = "ConnectionType"
    }
}

struct ConnectionType: Codable, Hashable {
    let title: String?

    enum CodingKeys: String, CodingKey { case title = "Title" }
}

struct OperatorInfo: Codable, Hashable {
    let title: String?

    enum CodingKeys: String, CodingKey { case title = "Title" }
}

// MARK: - Допоміжні властивості для UI
extension ChargingStation {
    /// Адреса одним рядком (для списку та копіювання)
    var fullAddress: String {
        [addressInfo.title, addressInfo.addressLine1, addressInfo.town]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }

    /// Максимальна потужність серед усіх конекторів
    var maxPowerKW: Double? {
        connections?.compactMap { $0.powerKW }.max()
    }
}
