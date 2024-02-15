//
//  CardsModel.swift
//  Fox Docs
//
//  Created by Fox on 11.02.2024.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI

@Model
final class CardViewModel {
    var name: String
    var number: String
    var cvv: String
    var type: BankType
    var date: String
    var bank: Bank

    var gradient: LinearGradient {
        switch bank {
        case .sber:
            return LinearGradient(colors: [Color.sber, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .noBank:
            return LinearGradient(colors: [Color.noBank, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .alfa:
            return LinearGradient(colors: [Color.alfa, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .tinkoff:
            return LinearGradient(colors: [Color.tinkoff, Color.secondary], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .tinkoffPlatinum:
            return LinearGradient(colors: [Color.tinkoffPlatinum, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .ozon:
            return LinearGradient(colors: [Color.ozon, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .yandex:
            return LinearGradient(colors: [Color.yandex, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .vtb:
            return LinearGradient(colors: [Color.vtb, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .gazprom:
            return LinearGradient(colors: [Color.gazprom, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .mkb:
            return LinearGradient(colors: [Color.mkb, Color(white: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .raifazen:
            return LinearGradient(colors: [Color.raifazen, Color(white: 0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    init(name: String, number: String, cvv: String, type: BankType, date: String, bank: Bank) {
        self.name = name
        self.number = number
        self.cvv = cvv
        self.type = type
        self.date = date
        self.bank = bank
    }
}

enum Bank: String, Codable, Hashable {
    case noBank = "Выберать банк"
    case sber = "Сбер"
    case alfa = "Альфа"
    case tinkoff = "Тинькофф"
    case tinkoffPlatinum = "Тинькофф Platinum"
    case ozon = "OZON"
    case yandex = "Яндекс"
    case vtb = "ВТБ"
    case gazprom = "Газпромбанк"
    case mkb = "МКБ"
    case raifazen = "Райффайзенбанк"
}

enum BankType: String, Codable, Hashable {
    case noType = "Тип карты"
    case visa = "Visa"
    case masterCard = "MasterCard"
    case mir = "МИР"
    case unionPay = "UnionPay"
    case others = "Другое"
}

