//
//  WeatherAnimation.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 15/07/24.
//

import SwiftUI

struct WeatherAnimation: View {
    let totalDuration = 1.0
    let isViewingTips: Bool
    let todaysWeather: String
    @Binding var isNight: Bool
    
    var body: some View {
        if isNight {
            switch todaysWeather {
            case "Clear":
                LinearGradient(gradient: Gradient(colors: [.nightClearTop, .nightClearBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Image("ClearStar")
                    .offset(y:-280)
                if !isViewingTips {
                    MoonNight(isHot: false,isCloudy: false, isRain: false, isClear: true)
                } else {
                    EmptyView()
                }
            case "Partly Cloudy":
                LinearGradient(gradient: Gradient(colors: [.nightClaudyTop, .nightClaudyBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    MoonNight(isHot: false, isCloudy: true, isRain: false, isClear: false)
                } else {
                    EmptyView()
                }
            case "Cloudy":
                LinearGradient(gradient: Gradient(colors: [.nightDrizzleTop, .nightDrizzleBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    MoonNight(isHot: false,isCloudy: false, isRain: false, isClear: false)
                } else {
                    EmptyView()
                }
            case "Rain":
                LinearGradient(gradient: Gradient(colors: [.nightHeavyRainTop, .nightHeavyRainBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Image("rain")
                    .offset(y:-280)
                if !isViewingTips {
                    MoonNight(isHot: false,isCloudy: false, isRain: true, isClear: false)
                } else {
                    EmptyView()
                }
            case "Hot":
                LinearGradient(gradient: Gradient(colors: [.nightHotTop, .nightHotBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Image("NightHeatWave")
                    .offset(y:-50)
                if !isViewingTips {
                    MoonNight(isHot: true,isCloudy: false, isRain: false, isClear: false)
                } else {
                    EmptyView()
                }
            default:
                LinearGradient(gradient: Gradient(colors: [.nightClearTop, .nightClearBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    MoonNight(isHot: false,isCloudy: false, isRain: false, isClear: true)
                } else {
                    EmptyView()
                }
            }
        } else {
            switch todaysWeather {
            case "Clear":
                LinearGradient(gradient: Gradient(colors: [.clearTop, .clearBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    SunnyDay(isHot: false,isCloudy: false, isRain: false, isClear: true)
                } else {
                    EmptyView()
                }
            case "Partly Cloudy":
                LinearGradient(gradient: Gradient(colors: [.claudyTop, .claudyBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    SunnyDay(isHot: false, isCloudy: true, isRain: false, isClear: false)
                } else {
                    EmptyView()
                }
            case "Cloudy":
                LinearGradient(gradient: Gradient(colors: [.drizzleTop, .drizzleBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    SunnyDay(isHot: false,isCloudy: false, isRain: false, isClear: false)
                } else {
                    EmptyView()
                }
            case "Rain":
                LinearGradient(gradient: Gradient(colors: [.heavyRainTop, .heavyRainBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Image("rain")
                    .offset(y:-280)
                if !isViewingTips {
                    SunnyDay(isHot: false,isCloudy: false, isRain: true, isClear: false)
                } else {
                    EmptyView()
                }
            case "Hot":
                LinearGradient(gradient: Gradient(colors: [.hotTop, .hotBottom]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Image("HeatWave")
                    .offset(y:-50)
                if !isViewingTips {
                    SunnyDay(isHot: true,isCloudy: false, isRain: false, isClear: false)
                } else {
                    EmptyView()
                }
            default:
                LinearGradient(gradient: Gradient(colors: [.clearDayOne, .clearDayTwo]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if !isViewingTips {
                    SunnyDay(isHot: false,isCloudy: false, isRain: false, isClear: true)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct SunnyDay: View {
    let totalDuration = 1.0
    @State var rotateDegree: Double = 0.0
    var isHot: Bool
    var isCloudy: Bool
    var isRain: Bool
    var isClear: Bool
    
    var body: some View {
        ZStack{
            if isHot && !isCloudy && !isRain && !isClear {
                ZStack {
                    ForEach(0..<12) { index in
                        RotateLight(
                            angle: Angle(degrees: Double(index) / Double(12)) * 360.0,
                            light: "HotLight"
                        )
                    }
                    .offset(y:-190)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 15).repeatForever(autoreverses: false)) {
                            rotateDegree = 360
                        }
                    }
                }
                .rotationEffect(.degrees(rotateDegree))
                Image("HotFace")
            } else if !isHot && isCloudy && !isRain && !isClear {
                ZStack {
                    ForEach(0..<12) { index in
                        RotateLight(
                            angle: Angle(degrees: Double(index) / Double(12)) * 360.0,
                            light: "CloudyLight"
                        )
                    }
                    .offset(y:-190)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 15).repeatForever(autoreverses: false)) {
                            rotateDegree = 360
                        }
                    }
                }
                .rotationEffect(.degrees(rotateDegree))
                Image("CloudyFace")
                Image("Clouds")
                    .offset(x: -40,y:50)
            } else if !isHot && !isCloudy && !isRain && isClear {
                ZStack {
                    ForEach(0..<12) { index in
                        RotateLight(
                            angle: Angle(degrees: Double(index) / Double(12)) * 360.0,
                            light: "ClearLight"
                        )
                    }
                    .offset(y:-190)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 15).repeatForever(autoreverses: false)) {
                            rotateDegree = 360
                        }
                    }
                }
                .rotationEffect(.degrees(rotateDegree))
                Image("ClearFace")
            } else if !isHot && !isCloudy && isRain && !isClear {
                Image("HeavyRainFace")
            } else if !isHot && !isCloudy && !isRain && !isClear {
                Image("DrizzleFace")
            }
        }
        .transition(.move(edge: .bottom))
        .position(CGPoint(x: UIScreen.main.bounds.width/2, y: 360))
        .keyframeAnimator(initialValue: AnimationProperties1(), repeating: true) { content, value in
            content
                .offset(y: value.yTranslation)
        } keyframes: { _ in
            KeyframeTrack(\.yTranslation) {
                CubicKeyframe(0, duration: totalDuration * 0.1)
                CubicKeyframe(-20, duration: totalDuration * 2)
                CubicKeyframe(0, duration: totalDuration * 2)
            }
        }
    }
}

struct MoonNight: View {
    let totalDuration = 1.0
    var isHot: Bool
    var isCloudy: Bool
    var isRain: Bool
    var isClear: Bool
    
    var body: some View {
        ZStack{
            if isHot && !isCloudy && !isRain && !isClear {
                Image("NightHotFace")
            } else if !isHot && isCloudy && !isRain && !isClear {
                Image("NightCloudyFace")
            } else if !isHot && !isCloudy && !isRain && isClear {
                Image("NightClearFace")
            } else if !isHot && !isCloudy && isRain && !isClear {
                Image("NightHeavyRainFace")
            } else if !isHot && !isCloudy && !isRain && !isClear {
                Image("NightDrizzleFace")
            }
        }
        .transition(.move(edge: .bottom))
        .position(CGPoint(x: UIScreen.main.bounds.width/2, y: 360))
        .keyframeAnimator(initialValue: AnimationProperties1(), repeating: true) { content, value in
            content
                .offset(y: value.yTranslation)
        } keyframes: { _ in
            KeyframeTrack(\.yTranslation) {
                CubicKeyframe(0, duration: totalDuration * 0.1)
                CubicKeyframe(-20, duration: totalDuration * 2)
                CubicKeyframe(0, duration: totalDuration * 2)
            }
        }
    }
}

struct RotateLight: View {
    let angle: Angle
    var light: String
    
    var body: some View {
        Image(light)
            .resizable()
            .frame(width: 45, height: 100)
            .padding(140)
            .rotationEffect(angle, anchor: .bottom)
    }
}
