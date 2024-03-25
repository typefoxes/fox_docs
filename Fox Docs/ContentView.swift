//
//  ContentView.swift
//  Fox Docs
//
//  Created by Fox on 11.02.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        HeaderHomeView()
        VStack {
            List {
                CardSectionView()
                DocsSectionView()

            }
        }
    }
}
