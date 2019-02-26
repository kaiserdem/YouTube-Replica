//
//  Extensions.swift
//  YouTube
//
//  Created by Kaiserdem on 23.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
}

extension UIView {
  func addConstraintsWithFormat(format: String, views: UIView...) {
    
    var viewsDictionary = [String: UIView]()
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
  }
}
let imageChach = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
  
  var imageUrlString: String?
  
  func loadImageUsingUrlString(urlString: String) { // загружает картинку из сети
    
    imageUrlString = urlString
    
    let url = URL(string: urlString)
    
    image = nil
    //  если есть берем из кеша
    if let imageFromCache = imageChach.object(forKey: urlString as AnyObject) as? UIImage {
      self.image = imageFromCache
      return
    }
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      if error != nil {
        print(error!)
        return
      }
      DispatchQueue.main.async {
        
        let imageToCache = UIImage(data: data!)
        
        if self.imageUrlString == urlString {
          self.image = imageToCache
        }
        
        imageChach.setObject(imageToCache!, forKey: urlString as AnyObject)
      }
      }.resume()
  }
}
