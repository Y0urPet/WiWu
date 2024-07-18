//
//  MainView.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 13/07/24.
//

import SwiftUI

struct MainView: View {
    @State var isExpandedTimes: Bool = false
    @State var isExpandedDays: Bool = false
    @State var searchText: String = ""
    @State var frameHeight: CGFloat = 800
    @State var isViewingTips: Bool = false
    @State var isReady: Bool = false
    var todaysWeather: String = "Clear"
    @State var isNight: Bool = false
    
    let baseFrameHeight: CGFloat = 1000
    let expandedDaysFrameH: CGFloat = 550
    let expandedTimesFrameH: CGFloat = 50
    
    @State private var scrollViewContentSize: CGSize = .zero
    
    @State private var weather = WeatherViewModel()
    
    @State var selection = Item(id: "item-8", name: "Weather", image: "cloud.sun.fill")
    let weekDay: [Item] = [
        Item(id: "item-8", name: "Weather", image: "cloud.sun.fill"),
        Item(id: "item-9", name: "Info", image: "info.circle.fill"),
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                if weather.dataState == .ready {
                    WeatherAnimation(isViewingTips: isViewingTips, todaysWeather: weather.dailyWeather.first?.condition ?? "Clear", isNight: $isNight)
                } else {
                    ShimmerView()
                        .clipShape(Circle())
                        .frame(width: 315)
                        .offset(y:-70)
                }
                ScrollView {
                    ZStack {
                        if weather.dataState == .ready {
                            CustomPickerForHome(items: weekDay, selection: $selection) { item in
                                if selection == item {
                                    if selection.name == "Weather" {
                                        Image(systemName: item.image)
                                            .resizable()
                                            .frame(width: 34,height: 25)
                                            .foregroundStyle(.pickerIconHome)
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 10)
                                    } else {
                                        Image(systemName: item.image)
                                            .resizable()
                                            .frame(width: 25,height: 25)
                                            .foregroundStyle(.pickerIconHome)
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 10)
                                    }
                                } else {
                                    if selection.name == "Weather" {
                                        Image(systemName: item.image)
                                            .resizable()
                                            .frame(width: 25,height: 25)
                                            .foregroundStyle(.defaultPickerHome)
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 10)
                                    } else {
                                        Image(systemName: item.image)
                                            .resizable()
                                            .frame(width: 34,height: 25)
                                            .foregroundStyle(.defaultPickerHome)
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 10)
                                    }
                                }
                            }
                            .symbolRenderingMode(.monochrome)
                            .position(CGPoint(x: UIScreen.main.bounds.midX, y:50))
                        } else {
                            ShimmerView()
                                .foregroundStyle(.white)
                                .frame(width: 107,height: 43)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .position(CGPoint(x: UIScreen.main.bounds.midX, y:50))
                        }
                        
                        VStack(spacing:0) {
                            LinearGradient(gradient: Gradient(colors: [.clear, .mainInfo]), startPoint: .top, endPoint: .bottom)
                                .frame(height: 80)
                            Rectangle()
                                .foregroundStyle(.mainInfo)
                                .frame(height: 1100)
                        }
                        .position(CGPoint(x: UIScreen.main.bounds.midX, y: isViewingTips ? 770 : 1070))
                        
                        VStack(spacing: 10) {
                            if selection.id == "item-8" {
                                if weather.dataState == .ready {
                                    Text(weather.locationName)
                                        .font(.system(size: 20))
                                        .foregroundStyle(.titleText)
                                    VStack(spacing: 5) {
                                        HStack {
                                            VStack {
                                                Text(weather.dailyWeather.first?.dailySummary.summary ?? "")
                                                    .foregroundStyle(.titleText)
                                                    .font(.system(size: 24))
                                                    .fontWeight(.bold)
                                                    .frame(maxWidth: UIScreen.main.bounds.width - 40)
                                                    .multilineTextAlignment(.center)
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                        // TODO: Benerin ini sesuai sama best times
                                        if (weather.dailyWeather.first?.dailySummary.bestTimes != []) {
                                            HStack(alignment: .bottom,spacing: 1) {
                                                Text("\(weather.dailyWeather.first?.condition ?? "") \(String(localized: "until")) \(String( weather.dailyWeather.first?.dailySummary.bestTimes[0].endTime.getHourString()[0] ?? "")) ")
                                                    .font(.system(size: 24))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.titleText)
                                                Text(weather.dailyWeather.first?.dailySummary.bestTimes[0].endTime.getHourString()[1] ?? "")
                                                    .font(.system(size: 18))
                                                    .fontWeight(.semibold)
                                                    .foregroundStyle(.titleText)
                                            }
                                        }
                                    }
                                    List {
                                        Section {
                                            Text("BEST TIMES TODAY")
                                                .foregroundStyle(.header)
                                                .fontWeight(.bold)
                                                .padding(.top, 10)
                                            if (weather.dailyWeather.first?.dailySummary.bestTimes != []) {
                                                ForEach(weather.dailyWeather[0].dailySummary.bestTimes) { time in
                                                    HStack{
                                                        Spacer()
                                                        VStack {
                                                            
                                                            HStack(alignment:.bottom, spacing:0){
                                                                Text("\(time.startTime.getHourMinute())").fontWeight(.bold)
//
                                                            }
                                                            
                                                            Image(systemName: "sun.max.fill")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                                .foregroundStyle(.orange)
                                                        }
                                                        Image("arrowRight")
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
                                                            Text("\(time.endTime.getHourMinute())")
                                                                    .fontWeight(.bold)
                                                            }
                                                            Image(systemName: "sun.max.fill")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                                .foregroundStyle(.orange)
                                                            
                                                        }
                                                        Spacer()
                                                    }
                                                }
                                            } else {
                                                HStack {
                                                    Text("Not recommended to go out today")
                                                }

                                            }
                                            Section(isExpanded: $isExpandedTimes) {
                                                ScrollView(Axis.Set.horizontal) {
                                                    if (weather.dailyWeather.first?.hourlyWeather != []) {
                                                        HStack(spacing: 16){
                                                            ForEach(weather.dailyWeather.first?.hourlyWeather ?? []) { hour in
                                                                VStack {
                                                                    //
                                                                    Text("\(hour.date.getHour())")
                                                                        .fontWeight(.bold)
                                                                    //
                                                                    Image(systemName: "\(hour.symbolName).fill")
                                                                        .resizable()
                                                                        .frame(width: 30, height: 30)
                                                                        .foregroundStyle(.orange)
                                                                    Text("\(hour.temperature.formattedTemperature())")
                                                                        .fontWeight(.bold)
                                                                }
                                                            }
                                                        }
                                                        .onAppear{
                                                            withAnimation {
                                                                frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
                                                            }
                                                            print("hourly: ", weather.dailyWeather[0].hourlyWeather.count)
                                                        }
                                                        .onDisappear() {
                                                            withAnimation {
                                                                
                                                                frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
                                                            }
                                                        }
                                                    }
                                                }
                                                .scrollDisabled(false)
                                            } header: {
                                                Text("HOURLY FORECAST")
                                                    .padding(.vertical, 16)
                                            }
                                        }

                                        // BEST DAYS THIS WEEK
                                        Section {
                                            Text("BEST DAYS THIS WEEK")
                                                .foregroundStyle(.header)
                                                .fontWeight(.bold)
                                                .padding(.top, 10)

                                            ForEach(weather.dailyWeather.sorted { $0.dailySummary.scoreOutOfTen > $1.dailySummary.scoreOutOfTen }.prefix(2).sorted { $0.date > $1.date }) { day in
                                                if day.dailySummary.summary != "" {
                                                    NavigationLink {
                                                        // Detail View
                                                        WeeklyWeatherView(date: day.date,weather: weather, todayData: day).navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                    } label: {
                                                        HStack(spacing: 10){
                                                            Text(day.date.threeLetter())
                                                                .frame(width: 35)
                                                            HStack {
                                                                Image(systemName: day.symbolName)
                                                                    .frame(width: 30,height: 30)
                                                                    .foregroundStyle(.orange, .gray)
                                                                Text(day.dailySummary.summary)
                                                            }
                                                        }
                                                    }
                                                    .onAppear{
                                                        withAnimation {
                                                            
                                                            frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
                                                        }
                                                    }
                                                    .onDisappear {
                                                        withAnimation {
                                                            frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            Section(isExpanded: $isExpandedDays) {
                                                ForEach(weather.dailyWeather) { day in
                                                    if day.dailySummary.summary != "" {
                                                        NavigationLink {
                                                            // Detail View
                                                            WeeklyWeatherView(date: day.date,weather: weather, todayData: day).navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                        } label: {
                                                            HStack(spacing: 10){
                                                                Text(day.date.threeLetter())
                                                                    .frame(width: 35)
                                                                HStack {
                                                                    Image(systemName: day.symbolName)
                                                                        .frame(width: 30,height: 30)
                                                                        .foregroundStyle(.orange, .gray)
                                                                    Text("\(day.condition), \(day.dailySummary.summary.lowercased())")
                                                                }
                                                            }
                                                        }
                                                        .onAppear{
                                                            withAnimation {
                                                                frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
                                                            }
                                                        }
                                                        .onDisappear {
                                                            withAnimation {
                                                                frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
                                                            }
                                                        }
                                                    }
                                                    
                                                }
                                            } header: {
                                                Text("WEEKLY FORECAST")
                                                    .padding(.vertical, 16)
                                            }
                                        }
                                    }
                                    .scrollDisabled(true)
                                    .listStyle(.sidebar)
                                    .listSectionSpacing(.compact)
                                    .scrollContentBackground(.hidden)
                                    Spacer()
                                } else {
                                    VStack(spacing:20){
                                        VStack(spacing:8) {
                                            ShimmerView()
                                                .frame(width: 100,height: 25)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                            VStack(spacing:5) {
                                                ShimmerView()
                                                    .frame(width: 280,height: 30)
                                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                                ShimmerView()
                                                    .frame(width: 250,height: 30)
                                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                            }
                                        }
                                        VStack{
                                            ShimmerView()
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .frame(width: 355,height: 290)
                                            ShimmerView()
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .frame(width: 355,height: 160)
                                        }
                                    }
                                    .offset(y:-300)
                                }
                                
                            } else if selection.id == "item-9" {
                                if let prepItems = weather.dailyWeather.first?.dailySummary.prepItems {
                                    InfoView(items: prepItems, dataState: $weather.dataState)
                                    .transition(.slide)
                                    .onAppear {
                                        withAnimation {
                                            isViewingTips.toggle()
                                        }
                                        print(prepItems.count)
                                    }
                                    .onDisappear {
                                        withAnimation {
                                            isViewingTips.toggle()
                                        }
                                    }
                                    .offset(y: -340)
                                }
                            }
                        }
                        .frame(height: frameHeight)
                        .offset(y: isViewingTips ? 0 : 300)
                    }
                    .background(
                        GeometryReader { geo -> Color in
                            DispatchQueue.main.async {
                                scrollViewContentSize = geo.size
                            }
                            return Color.clear
                        }
                    )
                }
                .scrollIndicators(.hidden)
                .scrollDisabled(selection.id != "item-8")
            }
        }
        .onChange(of: selection) {
            if selection.id == "item-8" {
                frameHeight = baseFrameHeight + (isExpandedDays ? expandedDaysFrameH : 0) + (isExpandedTimes ? expandedTimesFrameH : 0)
            } else {
                frameHeight = 500
            }
            
            print(frameHeight)
        }
        .onAppear{
            Task {
                weather.weatherManager.fetch()
                let currentDate = Date()
                let calendar = Calendar.current
                let currentHour = calendar.component(.hour, from: currentDate)

                // Check if the current hour is less than 18 (6 PM)
                isNight = currentHour >= 18 || currentHour <= 4
                isReady = true
            }
        }
        .refreshable {
            Task {
                weather.weatherManager.fetch()
                let currentDate = Date()
                let calendar = Calendar.current
                let currentHour = calendar.component(.hour, from: currentDate)

                // Check if the current hour is less than 18 (6 PM)
                isNight = currentHour >= 18 || currentHour <= 4
                weather.weatherManager.fetch()
            }
        }
        
    }
}

struct SearchBarView: View {
  @Binding var searchText: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
      TextField("Search", text: $searchText)
    }
    .frame(width: 345, height: 36)
    .padding(.leading, 8)
    .background(.white)
    .cornerRadius(10)
  }
}

struct AnimationProperties1 {
    var yTranslation = 0.0
}

#Preview {
    MainView()
}
