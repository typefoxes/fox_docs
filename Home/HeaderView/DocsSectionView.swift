//
//  DocsSectionView.swift
//  Fox Docs
//
//  Created by Дарья Котина on 21.02.2024.
//

import SwiftUI
import SwiftData

struct DocumentCardView: View {
    let documentType: DocumentType
    let onTapAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(documentType.getType())
                .foregroundColor(.white)
                .font(.title2)
            Text(documentType.getNumber())
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top, 20)
        }
        .padding(10)
        .onTapGesture {
            onTapAction()
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(documentType.getGradient())
        )
    }
}

struct DocsSectionView: View {
    @Query private var passports: [PassportModel]
    @Query private var snils: [SnilsModel]
    @Query private var passportInt: [PassportIntModel]
    @Query private var inn: [INNModel]
    @Query private var drive: [DriveModel]

    @State private var selectedDocument: DocumentWrapper?

    var body: some View {
        let allDocuments: [DocumentWrapper] = passports.map { DocumentWrapper(document: $0) } +
                                              snils.map { DocumentWrapper(document: $0) } +
                                              passportInt.map { DocumentWrapper(document: $0) } +
                                              inn.map { DocumentWrapper(document: $0) } +
                                              drive.map { DocumentWrapper(document: $0) }

        Section(header: Text("Документы")) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(allDocuments) { document in
                        DocumentCardView(documentType: getDocumentType(document.document)) {
                            selectedDocument = document
                        }
                    }
                }
            }
            .frame(height: 200)
        }
        .sheet(item: $selectedDocument) { documentWrapper in
            switch getDocumentType(documentWrapper.document) {
            case .passport(let passport):
                ShowPassportView(passport: passport)
            case .snils(let snils):
                ShowSnilsView(snils: snils)
            case .passportInt(let passportInt):
                ShowPassportIntView(passport: passportInt)
            case .inn(let inn):
                ShowInnView(inn: inn)
            case .drive(let drive):
                ShowDriveLicensView(drive: drive)
            }
        }
    }

    private func getDocumentType(_ document: Any) -> DocumentType {
        if let passport = document as? PassportModel {
            return .passport(passport)
        } else if let snils = document as? SnilsModel {
            return .snils(snils)
        } else if let passportInt = document as? PassportIntModel {
            return .passportInt(passportInt)
        } else if let inn = document as? INNModel {
            return .inn(inn)
        } else if let drive = document as? DriveModel {
            return .drive(drive)
        } else {
            fatalError("Unknown document type")
        }
    }
}
