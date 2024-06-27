//
//  DetailView.swift
//  CryptoTracker
//
//  Created by NJ Development on 27/06/24.
//

import SwiftUI

struct DetailView: View {
    let coin: Coin
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.shared.coin)
}
