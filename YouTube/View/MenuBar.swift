//
//  MenuBar.swift
//  YouTube
//
//  Created by Kaiserdem on 23.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  let cellId = "cellId"
  let imageNames = ["home", "trending", "subscriptions", "account"]
  
  var homeController: HomeController? // ссылка на другой контроллер
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    
    addSubview(collectionView)
    addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
    addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)

    let selectedIndexPath = NSIndexPath(item: 0, section: 0)
    collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .bottom)
    
    setupHorizontalBar()
    
  }
  var horizontalBarLeftAnchorConstaint: NSLayoutConstraint? // левый край белого бара
  
  func setupHorizontalBar() { // белый бар
    
    let horizontalBarView = UIView()
    horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(horizontalBarView)
    
    horizontalBarLeftAnchorConstaint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
      horizontalBarLeftAnchorConstaint?.isActive = true
    horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    horizontalBarView.heightAnchor.constraint(equalToConstant: 8).isActive = true
  }
                     // выбрал ячейку бара по индексу
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    /*
    // граница выбора 1/4
    let x = CGFloat(indexPath.item) * frame.width / 4
    horizontalBarLeftAnchorConstaint?.constant = x
    
                    // передвижение по анимации
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      self.layoutIfNeeded()
    }, completion: nil)
 */
                        // скрол по индексу
    homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
    cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 4, height:frame.height)

  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class MenuCell: BaseCell {
 
  let imageView: UIImageView = { // картинка на баре
    let iv = UIImageView()
    iv.image = UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    return iv
  }()
  
  override var isHighlighted: Bool { // если выделена
    didSet {
      print("isHighlighted")
      DispatchQueue.main.async {
        self.imageView.tintColor = self.isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
      }
    }
  }
  override var isSelected: Bool { // вызвана
    didSet {
      print("isSelected")
      DispatchQueue.main.async {
        self.imageView.tintColor = self.isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)

      }
    }
  }
  override func setupViews() {
    super.setupViews()

    addSubview(imageView)
    addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
    addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)

    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}
