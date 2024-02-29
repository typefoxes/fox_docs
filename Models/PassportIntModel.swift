//
//  PassportIntModel.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI

@Model
final class PassportIntModel: Identifiable {
    var id = UUID()
    var surname: String
    var givenName: String
    var dateOfBirth: String
    var gender: Gender
    var placeOfBirth: String
    var dateOfexpire: String
    var dateOfIssue: String
    var authority: String
    var number: String
    var type = "Загранпаспорт"

    init(id: UUID = UUID(), surname: String, givenName: String, dateOfBirth: String, gender: Gender, placeOfBirth: String, dateOfexpire: String, dateOfIssue: String, authority: String, number: String, type: String = "Загранпаспорт") {
        self.id = id
        self.surname = surname
        self.givenName = givenName
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.dateOfexpire = dateOfexpire
        self.dateOfIssue = dateOfIssue
        self.authority = authority
        self.number = number
        self.type = type
    }
}
