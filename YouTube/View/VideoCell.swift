//
//  VideoCell.swift
//  YouTube
//
//  Created by Kaiserdem on 23.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  func setupViews() {
    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class VideoCell: BaseCell { //Ячейка
  
  var video : Video? {
    didSet {
      titleLabel.text = video?.title
      
      setupThumbnailImage()
      setupProfileImage()
      
    
      if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
        subtitleTextView.text = subtitleText
      }
      // measure title text измерение
      if let title = video?.title {
        let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
        if estimatedRect.size.height > 20 {
          titleLableHeightConstraint?.constant = 44
        } else {
          titleLableHeightConstraint?.constant = 20
        }
      }
    }
  }
  func setupProfileImage() {
    
    if let profileImageUrl = video?.channel?.profileImageName {
       userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
    }
  }
  
  func setupThumbnailImage() {
    
    if let thumbnailImageUrl = video?.thumbnailImageName {
      thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
    }
  }
  let thumbnailImageView: CustomImageView = { // эскиз изображения видео
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "homeWithDemon")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "monro")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 22 // круговое вю, коловина высоты
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Marilyn Monro - Black space"
    label.numberOfLines = 2
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "MarilynMonro - 1,604,852,259 views - 2 years ago"
    textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
    textView.textColor = UIColor.lightGray
    return textView
  }()
  
  var titleLableHeightConstraint: NSLayoutConstraint?
  
  override func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
    
    addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
    
    // vertical constraints
    addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView, separatorView)
    
    addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
    // top constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    // left constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    // right constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    // height constraints
    titleLableHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
    addConstraint(titleLableHeightConstraint!)
    
    // top constraints
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    // left constraints
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    // right constraints
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    // height constraints
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    
    
    // addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
    //  addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
    
  }
  
}
