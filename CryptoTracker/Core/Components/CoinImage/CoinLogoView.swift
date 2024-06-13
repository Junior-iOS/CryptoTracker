//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/06/24.
//

import SwiftUI

struct CoinLogoView: View {
    @State var coin: Coin
    
    var body: some View {
        VStack {
            CoinImage(coin: coin)
                .frame(width: 50)
            
            Text(coin.symbol.uppercased())
                .font(.title3)
                .fontWeight(.bold)
            
            Text(coin.name)
                .font(.footnote)
                .foregroundStyle(Color.theme.secondaryText)
        }
        .padding()
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.shared.coin)
}
