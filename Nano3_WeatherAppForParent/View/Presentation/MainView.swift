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
    @State var frameHeight: CGFloat = 1100
    @State var isViewingTips: Bool = false
    @State var isReady: Bool = false
    var todaysWeather: String = "Clear"
    
    @State private var weather = WeatherViewModel()
    
    @State var selection = Item(id: "item-8", name: "Weather", image: "cloud.sun.fill")
    let weekDay: [Item] = [
        Item(id: "item-8", name: "Weather", image: "cloud.sun.fill"),
        Item(id: "item-9", name: "Info", image: "info.circle.fill"),
    ]
    
    var body: some View {
        NavigationStack{
            switch (weather.dataState) {
            case .ready:
            ZStack{
                if isReady {
                    WeatherAnimation(isViewingTips: isViewingTips, todaysWeather: todaysWeather)
                } else {
                    ShimmerView()
                        .clipShape(Circle())
                        .frame(width: 315)
                        .offset(y:-70)
                    // ini untuk showcase nunggu loading 3 detik
                        .onAppear{
                            withAnimation {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    isReady = true
                                }
                            }
                        }
                }
                ScrollView {
                    ZStack {
                        if isReady {
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
//                            VStack(spacing:30){
////                                SearchBarView(searchText: $searchText)
//                            }
                            if selection.id == "item-8" {
                                if isReady {
                                    Text("Sampora")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.titleText)
                                    VStack(spacing: 5) {
                                        Text("Perfect for Outdoor Fun!")
                                            .foregroundStyle(.titleText)
                                            .font(.system(size: 24))
                                            .fontWeight(.bold)
                                        
                                        HStack(alignment: .bottom,spacing: 1) {
                                            Text("Clear Skies until 11")
                                                .font(.system(size: 24))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.titleText)
                                            Text("AM")
                                                .font(.system(size: 18))
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.titleText)
                                        }
                                    }
                                    List {
                                        Section {
                                            Text("BEST TIMES TODAY")
                                                .foregroundStyle(.header)
                                                .fontWeight(.bold)
                                                .padding(.top, 10)
                                            ForEach(0..<2) { index in
                                                HStack(spacing: 16){
                                                    VStack {
                                                        if index == 0 {
                                                            Text("Now")
                                                                .fontWeight(.bold)
                                                        } else {
                                                            HStack(alignment:.bottom, spacing:0){
                                                                if index < 10 {
                                                                    Text("0\(index)")
                                                                        .fontWeight(.bold)
                                                                } else {
                                                                    Text("\(index)")
                                                                        .fontWeight(.bold)
                                                                }
                                                                Text("AM").font(.system(size: 12))
                                                            }
                                                        }
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
                                                            if index < 10 {
                                                                Text("0\(index+1)")
                                                                    .fontWeight(.bold)
                                                            } else {
                                                                Text("\(index)")
                                                                    .fontWeight(.bold)
                                                            }
                                                            Text("AM").font(.system(size: 12))
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
                                                        ForEach(0..<24) { index in
                                                            VStack {
                                                                if index < 10 {
                                                                    Text("0\(index)")
                                                                        .fontWeight(.bold)
                                                                } else {
                                                                    Text("\(index)")
                                                                        .fontWeight(.bold)
                                                                }
                                                                Image(systemName: "sun.max.fill")
                                                                    .resizable()
                                                                    .frame(width: 30, height: 30)
                                                                    .foregroundStyle(.orange)
                                                                Text("29°")
                                                                    .fontWeight(.bold)
                                                            }
                                                        }
                                                    }
                                                    .onAppear{
                                                        withAnimation {
                                                            if !isExpandedDays && isExpandedTimes && frameHeight == 1000 {
                                                                print("changing!")
                                                                frameHeight = 1200
                                                            } else if isExpandedDays && isExpandedTimes {
                                                                print("More Big!")
                                                                frameHeight = 1400
                                                            }
                                                        }
                                                    }
                                                    .onDisappear() {
                                                        withAnimation {
                                                            if !isExpandedDays && !isExpandedTimes && frameHeight != 1000 {
                                                                print("changing!")
                                                                frameHeight = 1100
                                                            } else if isExpandedDays && !isExpandedTimes {
                                                                print("More Big!")
                                                                frameHeight = 1300
                                                            }
                                                        }
                                                    }
                                                }
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

                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Sat")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                            .symbolRenderingMode(.palette)
                                                            .foregroundStyle(.gray, .orange)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            Section(isExpanded: $isExpandedDays) {
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Mon")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.heavyrain.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Tue")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.heavyrain.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Wed")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.heavyrain.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Thu")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.heavyrain.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Fri")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.heavyrain.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Sat")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.sun.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray,.orange)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                NavigationLink {
                                                    // Detail View
                                                    WeeklyWeatherView().navigationTitle("Weekly Forecast").navigationBarTitleDisplayMode(.inline)
                                                } label: {
                                                    HStack(spacing: 10){
                                                        Text("Sun")
                                                            .frame(width: 35)
                                                        HStack {
                                                            Image(systemName: "cloud.heavyrain.fill")
                                                                .frame(width: 30,height: 30)
                                                                .foregroundStyle(.gray)
                                                            Text("Clody, great for a walk")
                                                        }
                                                    }
                                                }
                                                .onAppear{
                                                    withAnimation {
                                                        if isExpandedDays {
                                                            if isExpandedTimes {
                                                                frameHeight = 1500
                                                            } else {
                                                                frameHeight = 1300
                                                            }
                                                        }
                                                    }
                                                }
                                                .onDisappear {
                                                    withAnimation {
                                                        if !isExpandedDays && !isExpandedTimes {
                                                            frameHeight = 1100
                                                        } else if !isExpandedDays && isExpandedTimes {
                                                            frameHeight = 1100
                                                        }
                                                    }
                                                }
                                            } header: {
                                                Text("WEEKLY FORECAST")
                                                    .padding(.vertical, 16)
                                            }
                                        }
                                    }
                                    .listStyle(.sidebar)
                                    .listSectionSpacing(.compact)
                                    .scrollContentBackground(.hidden)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+100)
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
                                InfoView()
                                    .transition(.slide)
                                    .onAppear{
                                        withAnimation {
                                            isViewingTips.toggle()
                                        }
                                    }
                                    .onDisappear {
                                        withAnimation {
                                            isViewingTips.toggle()
                                        }
                                    }
                                    .offset(y: -340)
                            }
                        }
                        .frame(height: frameHeight)
                        .offset(y: isViewingTips ? 0 : 300)
                    }
                }
                .scrollIndicators(.hidden)
//                .searchable(text: $searchText)
//                .toolbar(.hidden, for: .navigationBar)
//                Rectangle()
//                    .frame(width: 355,height: 290)
//                    .position(CGPoint(x: UIScreen.main.bounds.midX, y:450))
//                    .animation(.none)
                
//                Rectangle()
//                    .frame(width: 355,height: 160)
//                    .position(CGPoint(x: UIScreen.main.bounds.midX, y:690))
//                    .animation(.none)
            }
//            .symbolRenderingMode(.multicolor)
                
            default:
                Text("Loading")
            }
        }
        .onAppear{
            weather.weatherManager.fetch()
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
