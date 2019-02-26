//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Kaiserdem on 26.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class Setting: NSObject { // модель ячеек
  let name: String
  let imageName: String
  
  init(name: String, imageName: String) {
    self.name = name
    self.imageName = imageName
  }
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  let blackView = UIView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.white
    return cv
  }()
  
  let cellId = "cellId"
  let cellHeight: CGFloat = 50
  
  let settings: [Setting] = {
    
    return [Setting(name: "Setting", imageName: "settings"), Setting(name: "Terms & Privacy policy", imageName: "padlock"), Setting(name: "Send Facebook", imageName: "facebook"), Setting(name: "Help", imageName: "question"), Setting(name: "Switch Account", imageName: "user"), Setting(name: "Cancel", imageName: "cancel")]
  }()
  
  var homeController: HomeController?
  
   func showSettings() {
    if let window = UIApplication.shared.keyWindow {
      
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
       // динамическая высота окна
      let height: CGFloat = CGFloat(settings.count) * cellHeight
      
      let y = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
        self.blackView.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
      }, completion: nil)
    }
  }
  @objc func handleDismiss(setting: Setting) {
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      
      self.blackView.alpha = 0
      if let window = UIApplication.shared.keyWindow { // вернуть колекцию на экран
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
    }) { (completed: Bool) in
      if setting.name != "" && setting.name != "Cancel" { // не вызывать при это елементе
        self.homeController?.showControllerForSetting(setting: setting)
      }
    }
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
    let setting = settings[indexPath.item]
    cell.setting = setting
    return cell
  }
  // резмер елемента
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  // минимальный межстрочный интервал для секции в
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let setting = self.settings[indexPath.item]
    handleDismiss(setting: setting)
    }
  
  override init() {
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
                       // загрузка ячейки
    collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
  }
}
