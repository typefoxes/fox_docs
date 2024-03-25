//
//  DriveModel.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI

@Model
final class DriveModel: Identifiable {
    var id = UUID()
    var surname: String
    var surnameEng: String
    var name: String
    var nameEng: String
    var dateOfBirth: String
    var cityOfBirth: String
    var cityOfBirthEng: String
    var dateOfIssue: String
    var dateOfExpire: String
    var authority: String
    var number: String
    var category: [DriveCategory]
    var cityOfIssue: String
    var type = "Права"

    init(
        surname: String,
        surnameEng: String,
        name: String,
        nameEng: String,
        dateOfBirth: String,
        cityOfBirth: String,
        cityOfBirthEng: String,
        dateOfIssue: String,
        dateOfExpire: String,
        authority: String,
        number: String,
        category: [DriveCategory],
        cityOfIssue: String
    ) {
        self.surname = surname
        self.surnameEng = surnameEng
        self.name = name
        self.nameEng = nameEng
        self.dateOfBirth = dateOfBirth
        self.cityOfBirth = cityOfBirth
        self.cityOfBirthEng = cityOfBirthEng
        self.dateOfIssue = dateOfIssue
        self.dateOfExpire = dateOfExpire
        self.authority = authority
        self.number = number
        self.category = category
        self.cityOfIssue = cityOfIssue
    }
}
