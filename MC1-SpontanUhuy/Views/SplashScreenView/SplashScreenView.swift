//
//  SplashScreenView.swift
//  MC1-SpontanUhuy
//
//  Created by Martinus Andika Novanawa on 03/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var goToHome = false
    @State var scale: Double = 0
    @Binding var isFinished: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                if isActive {
                    VideoPlayerView()
                    .ignoresSafeArea()
                } else {
                    ZStack {
                        Color(hex: Constants.Color.primaryBlue)
                            .ignoresSafeArea()
                    }.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
                NavigationLink(
                    destination: OnboardpageView()
                        .navigationBarBackButtonHidden()
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 1)) {
                                scale = 1
                            }
                        }.opacity(scale),
                    isActive: $goToHome,
                    label: {
                        Text("")
                    }
                )
            }
            .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
                            isFinished = true
            }
            .ignoresSafeArea()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isFinished: Binding.constant(false))
    }
}
