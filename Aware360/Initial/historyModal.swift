//
//  historyModal.swift
//  Aware360
//
//  Created by Tecnovators on 26/04/21.
//

import Foundation

// MARK: - Welcome
struct HistoryModal: Codable {
    let data: hisDataClass?
    let error: hisError?
}

// MARK: - DataClass
struct hisDataClass: Codable {
    let count: Int?
    let rows: [hisRow]?
}

// MARK: - Row
struct hisRow: Codable {
    let id, civilianID: Int
      let lawyerID: Int?
      let priorityID, callCentreID, safetyConsultantID, requestStatusID: Int?
      let  duration, address, zipCode: String?
      let latitude, longitude: Double?
      let createdAt, updatedAt,roomID: String?
      let civilian, safetyConsultant: Civilian?
      let lawyer: Civilian?
      let callCentre: CallCentre?
      let requestStatus, priority: Priority?
      let notInRequests: [JSONAny]?
      let url: String?
    
      enum CodingKeys: String, CodingKey {
          case id
          case civilianID = "civilian_id"
          case lawyerID = "lawyer_id"
          case priorityID = "priority_id"
          case callCentreID = "call_centre_id"
          case safetyConsultantID = "safety_consultant_id"
          case requestStatusID = "request_status_id"
          case roomID = "room_id"
          case duration, address
          case zipCode = "zip_code"
          case latitude, longitude, createdAt, updatedAt, civilian
          case safetyConsultant = "safety_consultant"
          case lawyer
          case callCentre = "call_centre"
          case requestStatus = "request_status"
          case priority,url
          case notInRequests = "not_in_requests"
      }
}

// MARK: - CallCentre
struct CallCentre: Codable {
    let id: Int?
    let name: String?
    let callCentreDescription: String?
    let latitude, longitude: Int?
    let mobileCode, mobile: String?
    let email: String?
    let address: String?
    let zipCode: String?
    let city: String?
    let state:  String?
    let country: String?
    let userID, ratingCount : Int?
    let ratingAvg : Double?
    let isActive, isDelete: Bool?
    let createdAt: String?
    let updatedAt: String?
    let attachments: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id, name
        case callCentreDescription = "description"
        case latitude, longitude
        case mobileCode = "mobile_code"
        case mobile, email, address
        case zipCode = "zip_code"
        case city, state, country
        case userID = "user_id"
        case ratingCount = "rating_count"
        case ratingAvg = "rating_avg"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case createdAt, updatedAt, attachments
    }
}
// MARK: - Civilian
struct Civilian: Codable {
    let id, roleID: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let mobileCode: String?
    let mobile: String?
    let updateMobile, updateMobileCode, dob, biography: String?
    let genderID: Int?
    let password: String?
    let isNotification: Bool?
    let latitude, longitude: Double?
    let otp: String?
    let isEmailVerified: Int
    let mobileOtp: String?
    let mobileOtpValidity: String?
    let isMobileVerified: Int?
    let passwordToken, pin, specialityID: Int?
    let deviceID, deviceName, deviceToken, deviceType: String?
    let ssn: String?
    let address: String?
    let addressLine1, addressLine2: String?
    let city: String?
    let state: String?
    let country: String?
    let zipCode: String?
    let ext, fax: String?
    let callCentreID: Int?
    let ratingCount : Int?
    let ratingAvg : Double?
    let isNewsletter: Bool?
    let emerFirstName, emerLastName, emerRelationship, emerEmail: String?
    let emerMobileCode, emerMobile, emer1FirstName, emer1LastName: String?
    let emer1Relationship, emer1Email, emer1MobileCode, emer1Mobile: String?
    let isTerm, isActive: Bool?
    let isDelete: JSONNull?
    let createdAt: String?
    let updatedAt: String?
    let attachment: [FAttachment]?

    enum CodingKeys: String, CodingKey {
        case id
        case roleID = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case mobileCode = "mobile_code"
        case mobile
        case updateMobile = "update_mobile"
        case updateMobileCode = "update_mobile_code"
        case dob, biography
        case genderID = "gender_id"
        case password
        case isNotification = "is_notification"
        case latitude, longitude, otp
        case isEmailVerified = "is_email_verified"
        case mobileOtp = "mobile_otp"
        case mobileOtpValidity = "mobile_otp_validity"
        case isMobileVerified = "is_mobile_verified"
        case passwordToken = "password_token"
        case pin
        case specialityID = "speciality_id"
        case deviceID = "device_id"
        case deviceName = "device_name"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case ssn, address
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case city, state, country
        case zipCode = "zip_code"
        case ext, fax
        case callCentreID = "call_centre_id"
        case ratingCount = "rating_count"
        case ratingAvg = "rating_avg"
        case isNewsletter = "is_newsletter"
        case emerFirstName = "emer_first_name"
        case emerLastName = "emer_last_name"
        case emerRelationship = "emer_relationship"
        case emerEmail = "emer_email"
        case emerMobileCode = "emer_mobile_code"
        case emerMobile = "emer_mobile"
        case emer1FirstName = "emer1_first_name"
        case emer1LastName = "emer1_last_name"
        case emer1Relationship = "emer1_relationship"
        case emer1Email = "emer1_email"
        case emer1MobileCode = "emer1_mobile_code"
        case emer1Mobile = "emer1_mobile"
        case isTerm = "is_term"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case createdAt, updatedAt
        case attachment = "attachments"

    }
}
// MARK: - Attachment
struct FAttachment: Codable {
    let id: Int?
    let attachmentClass: String?
    let isPrimary: Bool?
    let foreignID: Int?
    let fileName, dir: String?
    let fileSize: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case attachmentClass = "class"
        case isPrimary = "is_primary"
        case foreignID = "foreign_id"
        case fileName = "file_name"
        case dir
        case fileSize = "file_size"
        case createdAt, updatedAt
    }
}

// MARK: - Priority
struct Priority: Codable {
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

struct hisError: Codable {
    let code: Int
    let message, fields: String
}
