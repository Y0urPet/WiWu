//
//  WeeklyWeatherView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 13/07/24.
//

import SwiftUI

struct DayWeatherView: View {
  let day: String
  let imageName: String

  var body: some View {
    HStack {
      Text(day)
      Image(systemName: imageName)
    }
  }
}

struct WeeklyWeatherView: View {
    @State var selection = Item(id: "item-1", name: "Mon", image: "sun.max.fill")
    let weekDay: [Item] = [
        Item(id: "item-1", name: "Mon", image: "sun.max.fill"),
        Item(id: "item-2", name: "Tue", image: "sun.max.fill"),
        Item(id: "item-3", name: "Wed", image: "sun.max.fill"),
        Item(id: "item-4", name: "Thu", image: "sun.max.fill"),
        Item(id: "item-5", name: "Fri", image: "sun.max.fill"),
        Item(id: "item-6", name: "Sat", image: "sun.max.fill"),
        Item(id: "item-7", name: "Sun", image: "sun.max.fill"),
    ]
    
    @State var isExpandedTimes: Bool = false

    var body: some View {
        ZStack{
            Color.detailBackground.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    ScrollView(Axis.Set.horizontal) {
                        CustomPicker(items: weekDay, selection: $selection) { item in
                            VStack(spacing:12) {
                                Text("\(item.name)")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                if selection == item {
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 32,height: 32)
                                    //                                    .foregroundStyle(.white)
                                        .symbolRenderingMode(.multicolor)
                                } else {
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 32,height: 32)
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(12)
                            //                            .padding(.bottom, 10)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .frame(width: 385)
                    
                    HStack(alignment: .center,spacing:20) {
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 95,height: 95)
                            .foregroundStyle(.sun)
                        VStack(alignment: .leading, spacing: 10){
                            Text("Saturday, 13 July 2024")
                                .font(.system(size: 20))
                            VStack(alignment: .leading, spacing: 1){
                                Text("Perfect to go out")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                HStack(alignment: .bottom, spacing: 1){
                                    Text("from 9")
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
                                    Text("AM")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                    Text(" - 11")
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
                                    Text("AM")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        
                    }
                    .offset(x: -18)
                    
                    List {
                        Section {
                            Text("BEST TIMES TODAY")
                                .foregroundStyle(.header)
                                .fontWeight(.bold)
                            HStack(spacing: 16){
                                VStack {
                                    Text("Now")
                                        .fontWeight(.bold)
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                                Image("arrowRight")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                VStack {
                                    HStack(alignment: .bottom, spacing: 0){
                                        Text("11").fontWeight(.bold)
                                        Text("AM").font(.system(size: 12))
                                    }
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                            HStack(spacing: 16){
                                VStack {
                                    Text("Now")
                                        .fontWeight(.bold)
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                                Image("arrowRight")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                VStack {
                                    HStack(alignment: .bottom, spacing: 0){
                                        Text("11").fontWeight(.bold)
                                        Text("AM").font(.system(size: 12))
                                    }
                                    Image(systemName: "sun.max.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                            Section(isExpanded: $isExpandedTimes) {
                                ScrollView(Axis.Set.horizontal) {
                                    HStack{
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                        VStack {
                                            Text("Now")
                                                .fontWeight(.bold)
                                            Image(systemName: "sun.max.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            Text("29°")
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            } header: {
                                Text("HOURLY FORECAST")
                            }
                        }
                        Section {
                            Text("THINGS TO PREPARE")
                                .foregroundStyle(.header)
                                .fontWeight(.bold)
                            HStack(spacing: 14){
                                Image(systemName: "drop.fill")
                                    .resizable()
                                    .frame(width: 17, height: 25)
                                    .foregroundStyle(.defaultIcon)
                                Text("Stay hydrated thorought the day")
                            }
                            .padding(.leading, 9)
                            HStack(spacing: 14){
                                Image(systemName: "bag.fill.badge.questionmark")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.defaultIcon)
                                Text("Use breathable clothing")
                            }
                            .padding(.leading, 2)
                            HStack(spacing: 14){
                                Image(systemName: "bag.fill.badge.questionmark")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.defaultIcon)
                                Text("Remember to use sunscreen")
                            }
                            .padding(.leading, 2)
                        }
                        
                    }
                    .listStyle(.sidebar)
                    .listSectionSpacing(.compact)
                    .scrollContentBackground(.hidden)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-200)
                    .offset(y:-20)
                }.padding()
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct CustomPicker<T: Identifiable & Equatable, C: RandomAccessCollection<T>, Content: View>: View  {
    let items: C
    @Binding var selection: T
    @ViewBuilder let itemBuilder: (T) -> Content
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { source in
                Button {
                    selection = source
                } label: {
                    itemBuilder(source)
//                        .padding()
                        .background(selection == source ? Color.white : Color.clear)
                        .cornerRadius(10)
                        .foregroundColor(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .animation(.default, value: selection)
            }
        }
        .padding(4)
        .background(Color.pickerBackground)
        .cornerRadius(10)
        
    }
}

struct CustomPickerForHome<T: Identifiable & Equatable, C: RandomAccessCollection<T>, Content: View>: View  {
    let items: C
    @Binding var selection: T
    @ViewBuilder let itemBuilder: (T) -> Content
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { source in
                Button {
                    selection = source
                } label: {
                    itemBuilder(source)
                        .cornerRadius(50)
                        .foregroundColor(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .animation(.default, value: selection)
            }
        }
        .padding(4)
        .background(Color.pickerHome)
        .cornerRadius(50)
        
    }
}

struct Item: Identifiable, Equatable {
    let id: String
    let name: String
    let image: String
}

#Preview {
    WeeklyWeatherView()
}
