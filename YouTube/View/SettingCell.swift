//
//  SettingCell.swift
//  YouTube
//
//  Created by Kaiserdem on 26.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SettingCell: BaseCell { // ячейка из кнопки настройки
  
  override var isSelected: Bool { // когда вызвана ячейка
    didSet {
      DispatchQueue.main.async {
        self.backgroundColor = self.isSelected ? UIColor.darkGray : .white
        self.nameLabel.textColor = self.isSelected ? UIColor.white : .black
        self.iconImageView.tintColor = self.isSelected ? UIColor.white : .black
      }
    }
  }
  
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.name.rawValue
      if let imageName = setting?.imageName {
        iconImageView.image = UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        iconImageView.tintColor = UIColor.darkGray
      }
    }
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Setting"
    label.font = UIFont.systemFont(ofSize: 15)
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
    
    addConstraintsWithFormat(format: "H:|-8-[v0(25)]-12-[v1]|", views:iconImageView, nameLabel)
    addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
    addConstraintsWithFormat(format: "V:[v0(25)]", views: iconImageView)
    // картинку
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}
