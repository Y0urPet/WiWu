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
    @Binding var dataState: WeatherDataState
    
    var body: some View {
        VStack {
            if dataState == .ready {
                
                Text("Things to prepare")
                
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
                .padding(.bottom, 20)
                
                if selectedTips == 0 {
                    TipsGridView(filteredItems: items.filter { $0.category == .clothes })
                } else if selectedTips == 1 {
                    TipsGridView(filteredItems: items.filter { $0.category == .items })
                }
            } else {
                VStack(spacing:20){
                    ShimmerView()
                        .frame(width: 200,height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.top, 175)
                    ShimmerView()
                        .frame(width: 330,height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 20)
                    ShimmerView()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 300,height: 225)
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.width - 50)
        
    }
    
    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}
