//
//  domain.swift
//  ADG-VIT
//
//  Created by Gokul Nair on 29/12/20.
//

import Foundation

struct domain: Decodable {
    let userDetails: UserDetail
}

struct UserDetail: Codable {
    let isEmailVerified, attemptedTechnical, attemptedManagement, attemptedDesign: Bool
    let yearofstudy: Int
    let isSelectedTechnical, isSelectedDesign, isSelectedManagement: Bool
    let id, name, regno, email: String
    let phone, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case isEmailVerified, attemptedTechnical, attemptedManagement, attemptedDesign, yearofstudy, isSelectedTechnical, isSelectedDesign, isSelectedManagement
        case id = "_id"
        case name, regno, email, phone, createdAt, updatedAt
        case v = "__v"
    }
}

