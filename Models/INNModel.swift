//
//  INNModel.swift
//  Fox Docs
//
//  Created by Fox on 14.02.2024.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI

@Model
final class INNModel: Identifiable {
    var id = UUID()
    var number: String
    var name: String
    var gender: Sex
    var dateOfBirth: String
    var placeOfBirth: String
    var type = "ИНН"

    init(number: String, name: String, gender: Sex, dateOfBirth: String, placeOfBirth: String, type: String = "ИНН") {
        self.number = number
        self.name = name
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.placeOfBirth = placeOfBirth
        self.type = type
    }
}
