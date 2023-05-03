////
////  SplashScreenView.swift
////  MC1-SpontanUhuy
////
////  Created by Naufal Fawwaz Andriawan on 23/04/23.
////
//
//import SwiftUI
//import AVKit
//
//struct SplashScreenView: View {
//    @State private var isFinished = false
//    var playerVC = {
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = AVPlayer(url: Bundle.main.url(forResource: "TemanRuang", withExtension: "mp4")!)
//        playerViewController.showsPlaybackControls = false
//        return playerViewController
//    }()
//    
//    var body: some View {
//        VideoPlayer(player: playerVC.player)
//            .onAppear{
//                playerVC.player?.play()
//            }
////            .onAppear {
////                playVideo()
////            }
//            .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
//                isFinished = true
//            }
//            .fullScreenCover(isPresented: $isFinished, content: {
//                ContentView()
//            })
//            
//            .ignoresSafeArea()
//    }
//    
//
//    private func playVideo() {
////        guard let videoURL = videoURL else {
////            debugPrint("TemanRuang.mp4 not found")
////            return
////        }
//        let videoURL = Bundle.main.url(forResource: "TemanRuang", withExtension: "mp4")!
//        
//        let player = AVPlayer(url: videoURL)
//        player.play()
//    }
//}
//
//struct SplashScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreenView()
//    }
//}
