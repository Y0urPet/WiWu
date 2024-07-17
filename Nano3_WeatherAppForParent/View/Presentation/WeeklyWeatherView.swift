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
    var date = Date()
    let weather: WeatherViewModel
    @State var selectedDay = UUID()
    @State var todayData: DayWeather
    @State var selection = Item(id: "mon", name: "Mon", image: "sun.max.fill")
    let weekDay: [Item] = [
        Item(id: "mon", name: "Mon", image: "sun.max.fill"),
        Item(id: "tue", name: "Tue", image: "sun.max.fill"),
        Item(id: "wed", name: "Wed", image: "sun.max.fill"),
        Item(id: "thu", name: "Thu", image: "sun.max.fill"),
        Item(id: "fri", name: "Fri", image: "sun.max.fill"),
        Item(id: "sat", name: "Sat", image: "sun.max.fill"),
        Item(id: "sun", name: "Sun", image: "sun.max.fill"),
    ]
    
    @State var isExpandedTimes: Bool = false

    var body: some View {
        ZStack{
            Color.detailBackground.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    ScrollView(Axis.Set.horizontal) {
                        HStack{
                        ForEach(weather.dailyWeather){ item in
                                VStack(spacing:12) {
                                    Text("\(item.date.threeLetter())")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.iconNameDetail)
                                    if  item.condition == "Clear" {
                                        Image(systemName: "sun.max.fill")
                                            .resizable()
                                            .frame(width: 32,height: 32)
                                        //                                    .foregroundStyle(.white)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.orange, .gray)
                                    } else if item.condition == "Cloudy"{
                                        Image(systemName: "cloud.fill")
                                            .resizable()
                                            .frame(width: 32,height: 32)
                                            .foregroundStyle(.white)
                                    }else if item.condition == "Partly Cloudy"{
                                        Image(systemName: "cloud.sun.fill")
                                            .resizable()
                                            .frame(width: 32,height: 32)
                                            .foregroundStyle(.white)
                                    }else if item.condition == "Rain"{
                                        Image(systemName: "cloud.heavyrain.fill")
                                            .resizable()
                                            .frame(width: 32,height: 32)
                                            .foregroundStyle(.white)
                                    }else{
                                        Image(systemName: "icloud.slash")
                                            .resizable()
                                            .frame(width: 32,height: 32)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .padding(12)
                                .onTapGesture {
                                    selectedDay = item.id
                                    todayData = weather.getDailyWeather(by: selectedDay) ?? todayData
                                    print("rama = \(todayData)")
                                }
                                //                            .padding(.bottom, 10)
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .frame(width: 385)
                    
                    HStack(alignment: .center,spacing:20) {
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 95,height: 95)
                            .foregroundStyle(.orange)
                        VStack(alignment: .leading, spacing: 10){
                            Text("\(todayData.date.formattedDate())")
                                .font(.system(size: 20))
                            VStack(alignment: .leading, spacing: 1){
                                Text(todayData.dailySummary.summary)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                HStack(alignment: .bottom, spacing: 1){
                                    Text("from \(todayData.dailySummary.bestTimes[0].startTime.getHour())")
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
//                                    Text("AM")
//                                        .font(.system(size: 20))
//                                        .fontWeight(.semibold)
                                    Text(" - \(todayData.dailySummary.bestTimes[0].endTime.getHour())")
                                        .font(.system(size: 25))
                                        .fontWeight(.bold)
//                                    Text("AM")
//                                        .font(.system(size: 20))
//                                        .fontWeight(.semibold)
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
                                .padding(.top, 10)
                            ForEach(0..<1) { index in
                                HStack(spacing: 16){
                                    VStack {
                                        Text("\(todayData.dailySummary.bestTimes[0].startTime.getHour())")
                                            .fontWeight(.bold)
                                        Image(systemName: "sun.max.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(.orange)
                                    }
                                    Image("arrowRight")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                    VStack {
                                        HStack(alignment: .bottom, spacing: 0){
                                            Text("\(todayData.dailySummary.bestTimes[0].endTime.getHour())").fontWeight(.bold)
//                                            Text("AM").font(.system(size: 12))
                                        }
                                        Image(systemName: "sun.max.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(.orange)
                                    }
                                }
                            }
                            Section(isExpanded: $isExpandedTimes) {
                                ScrollView(Axis.Set.horizontal) {
                                    HStack(spacing: 16){
                                        ForEach(todayData.hourlyWeather) { hour in
                                            VStack {
//
                                                Text("\(hour.date.getHour())")
                                                        .fontWeight(.bold)
//
                                                Image(systemName: "sun.max.fill")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundStyle(.orange)
                                                Text("\(hour.temperature.formattedTemperature())")
                                                    .fontWeight(.bold)
                                            }
                                        }
                                      
//                                        ForEach(0..<24) { index in
//                                            VStack {
//                                                if index < 10 {
//                                                    Text("0\(index)")
//                                                        .fontWeight(.bold)
//                                                } else {
//                                                    Text("\(index)")
//                                                        .fontWeight(.bold)
//                                                }
//                                                Image(systemName: "sun.max.fill")
//                                                    .resizable()
//                                                    .frame(width: 30, height: 30)
//                                                Text("29°")
//                                                    .fontWeight(.bold)
//                                            }
//                                        }
                                    }
                                }
                            } header: {
                                Text("HOURLY FORECAST")
                                    .padding(.vertical, 16)
                            }
                        }
                        Section {
                            Text("THINGS TO PREPARE")
                                .foregroundStyle(.header)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                            ForEach(0..<4) { index in
                                HStack(spacing: 14){
                                    Image(systemName: "bag.fill.badge.questionmark")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(.defaultIcon)
                                    Text("Stay hydrated thorought the day")
                                }
                                .padding(.leading, 2)
                            }
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
                        .background(selection == source ? Color.iconPickerDetail : Color.clear)
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


