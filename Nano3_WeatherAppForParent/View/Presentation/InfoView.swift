//
//  InfoView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 14/07/24.
//

import SwiftUI

struct InfoView: View {
    @State var selectedTips: Int = 0
    var body: some View {
            VStack {
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
                if selectedTips == 0 {
                    HStack {
                        VStack {
                            Image(systemName: "tshirt.fill")
                                .resizable()
                                .frame(width: 50, height: 40)
                                .foregroundStyle(.infoIcon)
                            Text("Short sleeved cotton or linen shirt")
                                .font(.system(size: 12))
                                .frame(width: 150)
                                .multilineTextAlignment(TextAlignment.center)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(.pickerInfoBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack {
                            Image(systemName: "tshirt.fill")
                                .resizable()
                                .frame(width: 50, height: 40)
                                .foregroundStyle(.infoIcon)
                            Text("Thigh to knee length pants")
                                .font(.system(size: 12))
                                .frame(width: 150)
                                .multilineTextAlignment(TextAlignment.center)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(.pickerInfoBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    HStack {
                        VStack {
                            Image(systemName: "shoe.fill")
                                .resizable()
                                .frame(width: 60, height: 30)
                                .foregroundStyle(.infoIcon)
                                .padding(.bottom, 10)
                            Text("Thick soled shoes or sandals")
                                .font(.system(size: 12))
                                .frame(width: 150)
                                .multilineTextAlignment(TextAlignment.center)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(.pickerInfoBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack {
                            Image(systemName: "tshirt.fill")
                                .resizable()
                                .frame(width: 50, height: 40)
                                .foregroundStyle(.infoIcon)
                            Text("Thin and lightweight jacket")
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
                    HStack {
                        VStack {
                            Image(systemName: "shoe.fill")
                                .resizable()
                                .frame(width: 60, height: 30)
                                .foregroundStyle(.infoIcon)
                                .padding(.bottom, 10)
                            Text("Thick soled shoes or sandals")
                                .font(.system(size: 12))
                                .frame(width: 150)
                                .multilineTextAlignment(TextAlignment.center)
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(.pickerInfoBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack {
                            Image(systemName: "tshirt.fill")
                                .resizable()
                                .frame(width: 50, height: 40)
                                .foregroundStyle(.infoIcon)
                            Text("Thin and lightweight jacket")
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

#Preview {
    InfoView()
}
