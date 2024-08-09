//
//  SectionView.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/07/24.
//

import SwiftUI

struct SectionView: View {
    let imageName: String
    let description: String
    let linkText: String
    let linkDestination: URL
    let header: String

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                Text(description)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(linkText, destination: linkDestination)
        } header: {
            Text(header)
        }
    }
}
