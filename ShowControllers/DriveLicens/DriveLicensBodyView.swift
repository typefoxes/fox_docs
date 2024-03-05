//
//  DriveLicensView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI

struct DriveLicensBodyView: View {
    private enum Constants {
        static let mainTitle: String = "ВОДИТЕЛЬСКОЕ УДОСТОВЕРЕНИЕ"
        static let pointOne: String = "1."
        static let pointTwo: String = "2."
        static let pointThree: String = "3."
        static let pointThreeA: String = "3a."
        static let pointFourA: String = "4a."
        static let pointFourB: String = "4b."
        static let pointFourC: String = "4c."
        static let pointFive: String = "5."
        static let pointSix: String = "6."
        static let pointSeven: String = "7."
        static let pointEight: String = "8."
        static let pointNine: String = "9."
        static let emptyLine: String = "---"
        static let cornerRadius: CGFloat = 20
        static let padding: CGFloat = 10
    }
    let drive: DriveModel
    var shareAction: String
    
    var body: some View {
        VStack {
            Text(Constants.mainTitle)
                .foregroundColor(.white)
                .padding(.top, Constants.padding)
                .font(.system(.body, design: .rounded))
                .fontWeight(.heavy)
            
            VStack(spacing: Constants.padding) {
                DetailRow(title: Constants.pointOne, value: "\(drive.surname) / \(drive.surnameEng)", position: .horizontal)
                DetailRow(title: Constants.pointTwo, value: "\(drive.name) / \(drive.nameEng)", position: .horizontal)
                DetailRow(title: Constants.pointThree, value: "\(drive.dateOfBirth)", position: .horizontal)
                DetailRow(title: Constants.pointThreeA, value: "\(drive.cityOfBirth)", position: .horizontal)
                DetailRow(title: Constants.pointFourA, value: "\(drive.dateOfIssue)", position: .horizontal)
                DetailRow(title: Constants.pointFourB, value: "\(drive.dateOfExpire)", position: .horizontal)
                DetailRow(title: Constants.pointFourC, value: "\(drive.authority)", position: .horizontal)
                DetailRow(title: Constants.pointFive, value: "\(drive.number)", position: .horizontal)
                DetailRow(title: Constants.pointSix, value: Constants.emptyLine, position: .horizontal)
                DetailRow(title: Constants.pointSeven, value: Constants.emptyLine, position: .horizontal)
                DetailRow(title: Constants.pointEight, value: "\(drive.cityOfIssue)", position: .horizontal)
                DetailRow(title: Constants.pointNine, value: drive.category.map { String(describing: $0.rawValue) }.joined(separator: ", "), position: .horizontal)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                    .fill(LinearGradient(colors: [Color.indigo, Color.cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .padding(Constants.padding)
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(LinearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        ShareLinkButton(action: shareAction, shareTitle: "Водительское удостоверение")
    }
}
