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
      thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
      
      if let profileImageName = video?.channel?.profileImageName {
        userProfileImageView.image = UIImage(named: profileImageName)
      }
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
      
      if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
        let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
        subtitleTextView.text = subtitleText
      }
      
    }
  }
  
  let thumbnailImageView: UIImageView = { // эскиз изображения
    let imageView = UIImageView()
    imageView.image = UIImage(named: "homeWithDemon")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
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
  
  override func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
    
    addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
    
    // vertical constraints
    addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView,userProfileImageView, separatorView)
    
    addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
    // top constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    // left constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    // right constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    // height constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    
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
