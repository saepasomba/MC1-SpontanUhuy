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
    
    var body: some View {
        NavigationView {
            VStack {
                if isActive {
                    VideoPlayerView(
                        onVideoFinished: {
                            goToHome = true
                        }
                    )
                } else {
                    ZStack {
                        VStack {
                            Image("TemanRuang")
                                .resizable()
                                .scaledToFit()
                                .ignoresSafeArea()
                                .background{
                                    Color(
                                }
                        }
                    }.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
                
                NavigationLink(
                    destination: Testing()
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
