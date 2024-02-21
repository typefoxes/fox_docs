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

struct DocumentWrapper: Identifiable {
    let id = UUID()
    let document: Any
}
