//
//  SpecialistModal.swift
//  Aware Lawyer
//
//  Created by AshwiniSankar on 2021-02-17.
//  Copyright © 2021 AshwiniSankar. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct SpecialistModal: Codable {
    let data: [SPDatum]
    let error: ESPrror
}

// MARK: - Datum
struct SPDatum: Codable {
    let id: Int?
    let name: String?
    let isActive: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case isActive = "is_active"
        case createdAt, updatedAt
    }
}

// MARK: - Error
struct ESPrror: Codable {
    let code: Int?
    let message, fields: String?
}
