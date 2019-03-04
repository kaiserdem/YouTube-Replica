//
//   VideoLauncher.swift
//  YouTube
//
//  Created by Kaiserdem on 03.03.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlyerView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .black
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a93-3bc8-410f-84d3-38332af9c726"
    if let url = NSURL(string: urlString) {
      let player = AVPlayer(url: url as URL)
    
      let playerLayer = AVPlayer(
      self.layer.addSublayer(playerLayer)
      playerLayer.frame = self.frame
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class VideoLauncher: NSObject {
  
  func showVideoPlayer() {
    print("showVideoPlayer")
    
    if let keyWindow = UIApplication.shared.keyWindow {
      let view = UIView(frame: keyWindow.frame)
      view.backgroundColor = .white
      view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
      
      let height = keyWindow.frame.width * 9 / 16
      
      let videoPlayFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
      let videoPlayView = VideoPlyerView(frame: videoPlayFrame)
      view.addSubview(videoPlayView)
      
      
      keyWindow.addSubview(view)

      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
        view.frame = keyWindow.frame
        
      }) { (completedAnimation) in

        UIApplication.shared.isStatusBarHidden = true // крыть статус бар
      }
    }
    
  }
}
