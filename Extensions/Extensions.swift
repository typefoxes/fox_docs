//
//  Extensions.swift
//  Fox Docs
//
//  Created by Fox on 11.02.2024.
//

import Foundation
import UIKit
import SwiftUI

extension View {
    @ViewBuilder
    func disableWithOpacity(_ status: Bool) -> some View {
        self
            .disabled(status)
            .opacity(status ? 0.6 : 1)
    }
}

extension String {
    static let empty = ""

    func chunkFormatted(withChunkSize chunkSize: Int, withSeparator separator: Character) -> String {
        return self.filter { $0 != separator }.enumerated().reduce(into: .empty) { result, pair in
            if pair.offset > 0 && pair.offset % chunkSize == 0 {
                result.append(separator)
            }
            result.append(pair.element)
        }
    }

    func dateFormateString(_ value: String) -> String {
        var result = value.replacingOccurrences(of: ".", with: "")
        let nonDecimalCharacters = CharacterSet.decimalDigits.inverted
        let updatedTextWithoutDots = value.components(separatedBy: nonDecimalCharacters).joined()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        var formattedDate = ""
        var index = 0

        for character in updatedTextWithoutDots {
            if index == 2 || index == 4 {
                formattedDate.append(".")
            }

            formattedDate.append(character)
            index += 1
        }
        result = formattedDate
        return String(result.prefix(10))
    }
}
