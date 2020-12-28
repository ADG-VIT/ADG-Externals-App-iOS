//
//  UserProfile.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 09/12/20.
//

import Foundation

struct model: Decodable {
    let userDetails: UserDetails
}
struct  UserDetails:Decodable {
    let attemptedTechnical, attemptedManagement, attemptedDesign: Bool
    let yearofstudy: Int
    let id, name, regno, phone, email: String
    let createdAt, updatedAt: String
    let githubLink: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case attemptedTechnical, attemptedManagement, attemptedDesign, yearofstudy
        case id = "_id"
        case name, regno, githubLink, phone, email, createdAt, updatedAt
        case v = "__v"
    }
}




