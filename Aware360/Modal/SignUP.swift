//
//  SignUP.swift
//  Aware360
//
//  Created by Sayeed Syed on 2/11/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - Welcome
struct SignUPModal: Codable {
    let token: String?
    let data: SignUPDataclass
    let error: SError
}

// MARK: - DataClass
struct SignUPDataclass: Codable {
    let isNone, isVerified: Bool?
    let city, state, country: String?
    let isNewsletter, isTerm, isActive: Bool?
    let id: Int?
    let email, mobile, address, ssn: String?
    let roleID: String?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case isNone = "is_none"
        case isVerified = "is_verified"
        case city, state, country
        case isNewsletter = "is_newsletter"
        case isTerm = "is_term"
        case isActive = "is_active"
        case id, email, mobile, address, ssn
        case roleID = "role_id"
        case updatedAt, createdAt
    }
}

// MARK: - Error
struct SError: Codable {
    let code: Int?
    let message, fields: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
