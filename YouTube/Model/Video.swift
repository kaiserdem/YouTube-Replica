//
//  Video.swift
//  YouTube
//
//  Created by Kaiserdem on 24.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class Video: NSObject { //
  
  var thumbnailImageName: String? // миниатюра
  var title: String?
  var numberOfViews: NSNumber?
  var uploadDate: NSData?
  var channel: Channel?
}

class Channel: NSObject {
  
  var name: String?
  var profileImageName: String?
}
