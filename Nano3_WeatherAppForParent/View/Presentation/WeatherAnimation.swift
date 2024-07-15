//
//  WeatherAnimation.swift
//  Nano3_WeatherAppForParent
//
//  Created by Timothy Andrian on 15/07/24.
//

import SwiftUI

struct WeatherAnimation: View {
    @State var rotateDegree: Double = 0.0
    var badgeSymbols: some View {
        ForEach(0..<12) { index in
            RotateBadgeSymbol(
                angle: Angle(degrees: Double(index) / Double(12)) * 360.0
            )
        }
    }
    
    var body: some View {
        ZStack{
            ZStack {
                badgeSymbols
                    .offset(y:-190)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 15).repeatForever(autoreverses: false)) {
                            rotateDegree += 360
                        }
                    }
            }
            .rotationEffect(.degrees(rotateDegree))
            Image("sunFace")
        }
        
    }
}

struct RotateBadgeSymbol: View {
    let angle: Angle
    
    var body: some View {
        Image("sunLight")
            .resizable()
            .frame(width: 45, height: 100)
            .padding(140)
            .rotationEffect(angle, anchor: .bottom)
    }
}

#Preview {
    WeatherAnimation()
}
