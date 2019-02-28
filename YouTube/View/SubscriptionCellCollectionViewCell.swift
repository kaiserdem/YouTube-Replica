//
//  SubscriptionCellCollectionViewCell.swift
//  YouTube
//
//  Created by Kaiserdem on 28.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell { // ячейка
  
  override func fetchVideos() {
    
    ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
}
