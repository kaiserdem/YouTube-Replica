//
//  SettingCell.swift
//  YouTube
//
//  Created by Kaiserdem on 26.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Setting"
    return label
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "settings")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  override func setupViews() {
    super.setupViews()

    addSubview(nameLabel)
    addSubview(iconImageView)
    
    addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views:iconImageView, nameLabel)
    addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
    addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
                               // картинку
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}
