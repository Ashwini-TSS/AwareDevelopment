//
//  errorModal.swift
//  Aware360
//
//  Created by mac on 13/02/21.
//

import Foundation

// MARK: - Welcome
struct errorModal: Codable {
    let data: String
    let error: MError
}

// MARK: - Error
struct MError: Codable {
    let code: Int?
    let message, fields: String?
}
// MARK: - Welcome
struct errorSModal: Codable {
    let data: String
    let error: KJError
}

// MARK: - Error
struct KJError: Codable {
    let code: Int?
    let message, fields: String?
}
