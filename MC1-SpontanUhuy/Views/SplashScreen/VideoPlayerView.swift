//
//  VideoPlayerView.swift
//  MC1-SpontanUhuy
//
//  Created by Martinus Andika Novanawa on 03/05/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoPlayerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // DO NOTHING !!!
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load The Resource
        var fileUrl: URL?
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            fileUrl = Bundle.main.url(forResource: "TemanRuangVideo_Iphone", withExtension: "mp4")
        } else {
            if UIDevice.current.orientation == .landscapeLeft {
                fileUrl = Bundle.main.url(forResource: "TemanRuangVideo_Landscape", withExtension: "mp4")
            } else if UIDevice.current.orientation == .landscapeRight {
                fileUrl = Bundle.main.url(forResource: "TemanRuangVideo_Landscape", withExtension: "mp4")
            } else {
                fileUrl = Bundle.main.url(forResource: "TemanRuangVideo_Portrait", withExtension: "mp4")
            }
        }
        
        if let url = fileUrl {
            let player = AVPlayer(url: url)
            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)
            
            // Setup Looping
    //        player.actionAtItemEnd = .none
    //        NotificationCenter.default.addObserver(self,
    //                                               selector: #selector(playerItemDidReachEnd(notification:)),
    //                                               name: .AVPlayerItemDidPlayToEndTime,
    //                                               object: player.currentItem)

            // Start the video
            player.play()
        }
    }
    
    @objc
    func playerItemDidReachEnd(notification: Notification) {
        playerLayer.player?.seek(to: CMTime.zero)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
