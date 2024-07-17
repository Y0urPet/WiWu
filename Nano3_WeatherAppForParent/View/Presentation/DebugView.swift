//
//  DailyView.swift
//  Nano3_WeatherAppForParent
//
//



import SwiftUI

struct DailyView: View {
    @State private var weather = WeatherViewModel()
    @State private var isExpanded = false

    var body: some View {
        VStack {
            HStack {
                Text("Weather Forecast")
                    .font(.headline)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(UIColor.systemTeal).opacity(0.2))
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(weather.dailyWeather) { day in
                            dailyWeatherView(for: day)
                        }
                        refreshButton
                    }
                    .padding()
                }
                .transition(.slide)
            }
        }
        .onAppear {
            weather.weatherManager.fetch()
        }
    }

    private var refreshButton: some View {
        Button("Refresh Weather") {
            weather.weatherManager.fetch()
        }
        .padding()
        .background(Color(UIColor.systemTeal))
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    private func dailyWeatherView(for day: DayWeather) -> some View {
        VStack(alignment: .leading) {
            Text("Date: \(day.date.formatted("dd/MM/yyyy"))")
                .font(.subheadline)
                .padding(.bottom, 5)

//            if let summary = day.dailySummary {
//                Text("Summary: \(summary.summary)")
//                    .font(.subheadline)
//                    .padding(.bottom, 5)
//            }
            
            
            Text("Summary: \(day.dailySummary.summary)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

            ForEach(day.hourlyWeather) { hour in
                hourlyWeatherView(for: hour)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }

    private func hourlyWeatherView(for hour: HourlyWeather) -> some View {
        VStack(alignment: .leading) {
            Text("Time: \(hour.date.formatted("HH:mm"))")
                .font(.subheadline)
            Text("Condition: \(hour.condition)")
                .font(.subheadline)
            Text("Temperature: \(hour.temperature, specifier: "%.1f") °C")
                .font(.subheadline)
        }
        .padding()
        .background(Color(UIColor.systemTeal).opacity(0.1))
        .cornerRadius(5)
        .padding(.bottom, 5)
    }
}

extension Date {
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

#Preview {
    DailyView()
}
