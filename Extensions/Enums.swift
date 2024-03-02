//
//  Gender.swift
//  Fox Docs
//
//  Created by Fox on 13.02.2024.
//
import SwiftData
import SwiftUI
import UIKit
import Foundation

enum Sex: String, Codable, Hashable {
    case female = "Женский"
    case male = "Мужской"
    case none = "Выбрать"
}

enum Gender: String, Codable, Hashable {
    case f = "Ж / F"
    case m = "М / M"
    case none = "Выбрать"
}

enum TypeOfDocs: String, Codable, Hashable {
    case passportRF = "Паспорт РФ"
    case passportInt = "Загран.Паспорт"
    case snils = "СНИЛС"
    case inn = "ИНН"
}

enum DriveCategory: String, Codable, Hashable {
    case none = "Выбрать"
    case a = "A"
    case a1 = "A1"
    case b = "B"
    case b1 = "B1"
    case c = "C"
    case c1 = "C1"
    case d = "D1"
    case be = "BE"
    case c1e = "C1E"
    case de = "DE"
    case d1e = "D1E"
    case m = "M"
    case tm = "Tm"
    case tb = "Tb"
}

enum ActiveKeyboardFields {
    case cardNumber
    case cardHolderName
    case expirationDate
    case cvv
}

enum ActiveKeyboardFieldsPassport {
    case fullName
    case seriaAndNumber
    case dateOfVidachy
    case whoGive
    case codePodrazdelenia
    case dateOfBirth
    case placeOfBirth
}

extension DriveCategory {
    static var allCases: [DriveCategory] {
        return [.none, .a, .a1, .b, .b1, .c, .c1, .d, .be, .c1e, .de, .d1e, .m, .tm, .tb]
    }
}

enum DocumentType {
    case passport(PassportModel)
    case snils(SnilsModel)
    case passportInt(PassportIntModel)
    case inn(INNModel)
    case drive(DriveModel)

    func getType() -> String {
        switch self {
        case .passport(let document): return document.type
        case .snils(let document): return document.type
        case .passportInt(let document): return document.type
        case .inn(let document): return document.type
        case .drive(let document): return document.type
        }
    }

    func getNumber() -> String {
        switch self {
        case .passport(let document): return document.seriaAndNumber
        case .snils(let document): return document.number
        case .passportInt(let document): return document.number
        case .inn(let document): return document.number
        case .drive(let document): return document.number
        }
    }

    func getGradient() -> LinearGradient {
        switch self {
        case .passport: return LinearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .snils: return LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .passportInt: return LinearGradient(colors: [Color.yellow, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .inn: return LinearGradient(colors: [Color.gray, Color.black], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .drive: return LinearGradient(colors: [Color.pink, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

enum onChangeAddView {
    case none
    case date
    case number
}
