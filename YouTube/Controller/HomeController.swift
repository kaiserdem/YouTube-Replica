//
//  ViewController.swift
//  YouTube
//
//  Created by Kaiserdem on 22.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
  let cellId = "cellId"
  
  let titles = ["Home", "Trending", "Subscriptions", "Account"]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.isTranslucent = false
    
    // навигейшен бар
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "  Home"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
    
    setupCollectionView()
    setupMenuBar()
    setupNavBarButtons()
  }
  func setupCollectionView() { // окно с колекцией
    
    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
      flowLayout.minimumLineSpacing = 0 // реборо ячейки
    }
    collectionView?.backgroundColor = UIColor.white
  
    collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    
  collectionView?.isPagingEnabled = true // скрол по одной ячейке
    
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
    scrollToMenuIndex(menuIndex: 2)
    print("handleSearch")
  }
  
  func scrollToMenuIndex(menuIndex: Int) { // скрол меню по индексу
    let indexPath = NSIndexPath(item: menuIndex, section: 0)
    collectionView?.scrollToItem(at: indexPath as IndexPath, at: .init(rawValue: 0), animated: true)
    
    setTitleForIndex(menuIndex)
  }
  private func setTitleForIndex(_ index: Int) { // задать титул по индексу
    if let titleLabel =  navigationItem.titleView as? UILabel {
      titleLabel.text = " \(titles[index])"
    }
  }
  lazy var menuBar: MenuBar = {
    let mb = MenuBar()
    mb.homeController = self
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
        // был выполнен скрол
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset.x)
    menuBar.horizontalBarLeftAnchorConstaint?.constant = scrollView.contentOffset.x / 4
  }
                  // прокрутка закончится перетаскиванием, со скоростью
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
                    // целевой контент отключен
    let index = targetContentOffset.pointee.x / view.frame.width

    let indexPath = NSIndexPath(item: Int(index), section: 0)
    menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .top)
    
//    if let titleLabel =  navigationItem.titleView as? UILabel {
//      titleLabel.text = " \(titles[Int(index)])"
//    }
    setTitleForIndex(Int(index))
  }
                          // количество предметов в разделе раздела
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
                     // ячейка для элемента с индексом
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    
    return cell
  }
               //   размер для элемента в индексе
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height - 50)
  }
}
