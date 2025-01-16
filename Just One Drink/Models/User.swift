//
//  User.swift
//  Just One Drink
//
//  Created by Luke Mulcahy on 1/15/25.
//

import Foundation
import SwiftData

@Model
class User {
    var weight: Int
    var sex: Sex
    
    init(weight: Int, sex: Sex) {
        self.weight = weight
        self.sex = sex
    }
    
    enum Sex: String, Codable, CaseIterable {
        case male = "Male"
        case female = "Female"
    }
}
