//
//  ViewController.swift
//  YouTube
//
//  Created by Kaiserdem on 22.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var videos: [Video]?
  
  func fetchVideos() { //открывает джейсон
    
    let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
      if error != nil {
        print(error)
        return
      }
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        
        self.videos = [Video]()
        
        for dictionary in json as! [[String: AnyObject]] {
          
          let video = Video()
          video.title = dictionary["title"] as? String
          video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
          
          let channelDictionary = dictionary["channel"] as! [String: AnyObject]
          
          let channel = Channel()
          channel.name = channelDictionary["name"] as? String
          channel.profileImageName = channelDictionary["profile_image_name"] as? String
          video.channel = channel
          
          self.videos?.append(video)
        }
        DispatchQueue.main.async {
           self.collectionView?.reloadData()
        }
      } catch let jsonError {
        print(jsonError)
      }
      }.resume()
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchVideos()
    
    navigationController?.navigationBar.isTranslucent = false
    
    // навигейшен бар
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "  Home"
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

  lazy var settingsLauncher: SettingsLauncher = {
    let launcher = SettingsLauncher()
    launcher.homeController = self
    return launcher
  }()
  
  @objc func handleMore() {
    
    settingsLauncher.showSettings()
  }
  
  func showControllerForSetting(setting: Setting) {
    
    let dummySettingsViewController = UIViewController()
    dummySettingsViewController.view.backgroundColor = UIColor.white
    dummySettingsViewController.navigationItem.title = setting.name.rawValue
    navigationController?.navigationBar.tintColor = UIColor.white
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.pushViewController(dummySettingsViewController, animated: true)
  }
  
  @objc func handleSearch() {
    print("handleSearch")
  }
  let menuBar: MenuBar = {
    let mb = MenuBar()
    return mb
  }()
  
  private func setupMenuBar() {
    
    navigationController?.hidesBarsOnSwipe = true // убрать бар при свайпе
    
    let redView = UIView()
    redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    view.addSubview(redView)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
    view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
    
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
    
    menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
  }
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
    cell.video = videos?[indexPath.item]
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: height + 16 + 88)
  }
           // минимальный межстрочный интервал для секции в
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

