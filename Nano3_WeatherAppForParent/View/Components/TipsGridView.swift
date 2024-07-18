//
//  TipsGridView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Althaf Nafi Anwar on 17/07/24.
//

import SwiftUI

struct TipsGridView: View {
    var filteredItems: [PrepItem]
    
    var body: some View {
        let cols = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        LazyVGrid(columns: cols, spacing: 15) {
            ForEach (filteredItems) { item in
                VStack {
                    Image(systemName: item.icon)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.infoIcon)
                    Text(item.title)
                        .font(.system(size: 12))
                        .frame(width: 150)
                        .multilineTextAlignment(TextAlignment.center)
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
                .background(.pickerInfoBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
