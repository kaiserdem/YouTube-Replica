//
//  TrendingCell.swift
//  YouTube
//
//  Created by Kaiserdem on 28.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
  
  override func fetchVideos() {
    
    ApiService.sharedInstance.fetchTrendingFeed { (videos) in
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
}
