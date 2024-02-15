//
//  SnilsModel.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI

@Model
final class SnilsModel {

    var number: String
    var name: String
    var dateAndPlace: String
    var sex: Sex
    var type: String

    init(number: String, name: String, dateAndPlace: String, sex: Sex, type: String) {
        self.number = number
        self.name = name
        self.dateAndPlace = dateAndPlace
        self.sex = sex
        self.type = type
    }
}
