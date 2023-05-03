//
//  VideoPlayerView.swift
//  MC1-SpontanUhuy
//
//  Created by Martinus Andika Novanawa on 03/05/23.
//

import SwiftUI
import UIKit
import AVKit
import AVFoundation
import Foundation

struct VideoPlayerView: View {
    let onVideoFinished: () -> Void
    
    let avPlayer = AVPlayer(
        url: Bundle.main.url(forResource: "TemanRuangVideo", withExtension: "mp4")!
    )
    
    var body: some View {
        AVPlayerControllerRepresented(player: avPlayer)
            .disabled(true)
            .onDisappear(){
                avPlayer.isMuted = false
            }
            .onAppear()
    }
}

struct AVPlayerControllerRepresented: UIViewControllerRepresentable{
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = AVPlayerViewController()
        view.showsPlaybackControls = false
        view.player = player
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
