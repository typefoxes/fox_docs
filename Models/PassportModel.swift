//
//  PassportModel.swift
//  Fox Docs
//
//  Created by Fox on 12.02.2024.
//

import SwiftData
import SwiftUI

@Model
final class PassportModel {
    var id = UUID()
    var fullName: String
    var seriaAndNumber: String
    var dateOfVidachy: String
    var whoGive: String
    var codePodrazdelenia: String
    var dateOfBirth: String
    var placeOfBirth: String
    var type: String
    var sex: Sex

    init(fullName: String, seriaAndNumber: String, dateOfVidachy: String, whoGive: String, codePodrazdelenia: String, dateOfBirth: String, placeOfBirth: String, type: String, sex: Sex) {
        self.fullName = fullName
        self.seriaAndNumber = seriaAndNumber
        self.dateOfVidachy = dateOfVidachy
        self.whoGive = whoGive
        self.codePodrazdelenia = codePodrazdelenia
        self.dateOfBirth = dateOfBirth
        self.placeOfBirth = placeOfBirth
        self.type = type
        self.sex = sex
    }
}
