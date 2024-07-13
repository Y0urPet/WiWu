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
    @State var frameHeight: CGFloat = 1000
    @State var backgroundOffset: CGFloat = -90
    
    @State var selection = Item(id: "item-8", name: "Weather", image: "cloud.sun.fill")
    let weekDay: [Item] = [
        Item(id: "item-8", name: "Weather", image: "cloud.sun.fill"),
        Item(id: "item-9", name: "Info", image: "info.circle.fill"),
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.clearDayOne, .clearDayTwo]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                ScrollView {
                    ZStack {
                        Image("sunny")
                            .offset(y: backgroundOffset)
                        VStack(spacing: 10) {
                            VStack(spacing:30){
                                SearchBarView(searchText: $searchText)
                                CustomPickerForHome(items: weekDay, selection: $selection) { item in
                                    if selection == item {
                                        if selection.name == "Weather" {
                                            Image(systemName: item.image)
                                                .resizable()
                                                .frame(width: 34,height: 25)
                                                .foregroundStyle(.black)
                                                .padding(.top, 5)
                                                .padding(.bottom, 5)
                                                .padding(.horizontal, 10)
                                        } else {
                                            Image(systemName: item.image)
                                                .resizable()
                                                .frame(width: 25,height: 25)
                                                .foregroundStyle(.black)
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
                            }
                            .offset(y: -245)
                            Text("Sampora")
                                .font(.system(size: 20))
                            VStack(spacing: 5) {
                                Text("Perfect for Outdoor Fun!")
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                                HStack(alignment: .bottom,spacing: 1) {
                                    Text("Clear Skies until 11")
                                        .font(.system(size: 24))
                                        .fontWeight(.bold)
                                    Text("AM")
                                        .font(.system(size: 18))
                                        .fontWeight(.semibold)
                                }
                            }
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
                                            .onAppear{
                                                if !isExpandedDays && isExpandedTimes && frameHeight == 1000 {
                                                    print("changing!")
                                                    frameHeight = 1100
//                                                    backgroundOffset = -190
                                                }
                                            }
                                        }
                                    } header: {
                                        Text("HOURLY FORECAST")
                                    }
                                }
                                // BEST DAYS THIS WEEK
                                Section {
                                    Text("BEST DAYS THIS WEEK")
                                        .foregroundStyle(.header)
                                        .fontWeight(.bold)
                                    NavigationLink {
                                        // Detail View
                                        WeeklyWeatherView()
                                    } label: {
                                        HStack(spacing: 10){
                                            Text("Sat")
                                            HStack {
                                                Image(systemName: "cloud.sun.fill")
                                                    .frame(width: 30,height: 30)
                                                Text("Clody, great for a walk")
                                            }
                                        }
                                    }
                                    Section(isExpanded: $isExpandedDays) {
                                        VStack{
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Mon")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Tue")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Wed")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Thu")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Fri")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Sat")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                            NavigationLink {
                                                // Detail View
                                                WeeklyWeatherView()
                                            } label: {
                                                HStack(spacing: 10){
                                                    Text("Sun")
                                                    HStack {
                                                        Image(systemName: "cloud.sun.fill")
                                                            .frame(width: 30,height: 30)
                                                        Text("Clody, great for a walk")
                                                    }
                                                }
                                            }
                                        }
                                        .onAppear{
                                            if isExpandedDays {
                                                if isExpandedTimes {
                                                    print("isExpanded!!")
                                                    frameHeight = 1400
                                                    backgroundOffset = -250
                                                } else {
                                                    print("isExpanded!!")
                                                    frameHeight = 1300
                                                    backgroundOffset = -200
                                                }
                                            }
                                        }
                                    } header: {
                                        Text("HOURLY FORECAST")
                                    }
                                }
                            }
                            .listStyle(.sidebar)
                            .listSectionSpacing(.compact)
                            .scrollContentBackground(.hidden)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            Spacer()
                        }
                        .frame(height: frameHeight)
                        .offset(y: 300)
                    }
                }
                .searchable(text: $searchText)
                .toolbar(.hidden, for: .navigationBar)
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

#Preview {
    MainView()
}
