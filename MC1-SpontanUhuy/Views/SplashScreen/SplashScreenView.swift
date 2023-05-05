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
        VStack {
            if isActive {
                VideoPlayerView().ignoresSafeArea()
            } else {
                ZStack {
                    Color(hex: Constants.Color.primaryCyan)
                        .ignoresSafeArea()
                    VStack {
                        Image("TemanRuang")
                            .resizable()
                            .scaledToFit()
                    }
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
            isFinished = true
        }
        .ignoresSafeArea()
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isFinished: Binding.constant(false))
    }
}
