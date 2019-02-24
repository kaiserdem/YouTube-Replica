//
//  ViewController.swift
//  YouTube
//
//  Created by Kaiserdem on 22.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var videos: [Video] = {
    
    var kanyeChannel = Channel() // канал
    kanyeChannel.name = "Natasha Koroleva Igor Nikolaev"
    kanyeChannel.profileImageName = "team"
    
    var blankSpaceVideo = Video()
    blankSpaceVideo.title = "Marilyn Monro - Blank Space"
    blankSpaceVideo.thumbnailImageName = "homeWithDemon" // картинка
    blankSpaceVideo.channel = kanyeChannel // канал
    blankSpaceVideo.numberOfViews = 3453457632
    
    var badblondVideo = Video()
    badblondVideo.title = "Bad Blond - Hello world"
    badblondVideo.thumbnailImageName = "badBlond"
    badblondVideo.channel = kanyeChannel
    badblondVideo.numberOfViews = 53426367769
    
    return [badblondVideo, blankSpaceVideo]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    navigationController?.navigationBar.isTranslucent = false
    
    // навигейшен бар
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "Home"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
    
    collectionView?.backgroundColor = UIColor.white
    
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    
    collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    
    setupMenuBar()
    setupNavBarButtons()
  }
  
  func setupNavBarButtons(){
    
    let searchImage = UIImage(named: "search24")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    
    let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
    
    let moreButton = UIBarButtonItem(image: UIImage(named: "more24")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    
    navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
  }
  
  @objc func handleMore() {
    print("handleMore")

  }
  @objc func handleSearch() {
    print("handleSearch")
  }
  let menuBar: MenuBar = {
    let mb = MenuBar()
    return mb
  }()
  
  private func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat(format: "V:|[v0(50)]|", views: menuBar)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos.count
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
    
    cell.video = videos[indexPath.item]
    
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: height + 16 + 12 + 68)
  }
           // минимальный межстрочный интервал для секции в
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}


