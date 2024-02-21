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
    var surnameEng: String
    var givenName: String
    var givenNameEng: String
    var dateOfBirth: String
    var gender: Gender
    var placeOfBirth: String
    var placeOfBirthEng: String
    var dateOfexpire: String
    var dateOfIssue: String
    var authority: String
    var number: String
    var type: String

    init(surname: String, surnameEng: String, givenName: String, givenNameEng: String, dateOfBirth: String, gender: Gender, placeOfBirth: String, placeOfBirthEng: String, dateOfexpire: String, dateOfIssue: String, authority: String, number: String, type: String) {
        self.surname = surname
        self.surnameEng = surnameEng
        self.givenName = givenName
        self.givenNameEng = givenNameEng
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.placeOfBirthEng = placeOfBirthEng
        self.dateOfexpire = dateOfexpire
        self.dateOfIssue = dateOfIssue
        self.authority = authority
        self.number = number
        self.type = type
    }
}
