//
//  InfoView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 14/07/24.
//

import SwiftUI


struct InfoView: View {
    @State var selectedTips: Int = 0
    @State var items: [PrepItem]
    
    var body: some View {
        VStack {
            // TODO: Remove count for debug
            Text("Things to prepare \(items.count)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 16)
            Picker("", selection: $selectedTips) {
                Text("Clothes").tag(0)
                Text("Items").tag(1)
            }
            .pickerStyle(.segmented)
            .background(.pickerInfoBackground)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            if selectedTips == 0 {
                ForEach(items.filter { $0.category == .clothes }, id: \.self) { item in
                    VStack {
                        Image(systemName: item.icon)
                            .resizable()
                            .frame(width: 50, height: 40)
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
            } else if selectedTips == 1 {
                ForEach(items.filter { $0.category == .items }, id: \.self) { item in
                    VStack {
                        Image(systemName: item.icon)
                            .resizable()
                            .frame(width: 60, height: 30)
                            .foregroundStyle(.infoIcon)
                            .padding(.bottom, 10)
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
        .padding()
    }
}

//#Preview {
//    InfoView()
//}
