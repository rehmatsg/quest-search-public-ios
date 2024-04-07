//
//  Onboarding.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 07/04/24.
//

import SwiftUI
import SwiftUIGradientBlur
import Awesome

struct Onboarding: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            GradientImageView(
                image: Image("astronaut"),
                height: UIScreen.screenHeight,
                width: UIScreen.screenWidth,
                blurStyle: colorScheme == .light ? .light : .dark
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Quest Search")
                    .font(.custom("Unbounded", size: 30))
                    .fontWeight(.bold)
                    .italic()
                
                Text("Explore Your Curiosity: Instant Answers to Every Question")
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .foregroundStyle(.secondary)
                
                VibeButton(
                    label: "Get Started"
                )
                    .expanded()
                    .backgroundStyle(.white.opacity(1))
                    .foregroundStyle(.black)
                
                Text("By creating an account you agree to our T&C and Privacy Policy")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .safeAreaPadding(.all)
        }
    }
}

#Preview {
    Onboarding()
}
