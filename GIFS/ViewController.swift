//
//  ViewController.swift
//  GIFS
//
//  Created by Isaac Rosenberg on 11/21/17.
//  Copyright © 2017 Isaac Rosenberg. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  var gifs = [GIF]()
  let reuseIdentifier = "GifCollectionViewCell"
  var collectionView: GIFCollectionView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addViews()
    addConstraints()
    collectionView?.register(GIFCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    fetchData()
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func addViews() {
    let gifFlowLayout = UICollectionViewFlowLayout()
    gifFlowLayout.minimumInteritemSpacing = 0
    gifFlowLayout.minimumLineSpacing = 0
    gifFlowLayout.scrollDirection = .vertical
    
    collectionView = GIFCollectionView(frame: .zero, collectionViewLayout: gifFlowLayout)
    collectionView?.backgroundColor = .white
    collectionView?.translatesAutoresizingMaskIntoConstraints = false
    collectionView?.delegate = self
    collectionView?.dataSource = self
    view.addSubview(collectionView!)
    
  }
  
  func addConstraints() {
    guard let collection = collectionView else { return }
    
    let collectionTop = NSLayoutConstraint(item: collection, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
    let collectionBottom = NSLayoutConstraint(item: collection, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    let collectionLeft = NSLayoutConstraint(item: collection, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
    let collectionRight = NSLayoutConstraint(item: collection, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
    view.addConstraints([collectionTop, collectionRight, collectionLeft, collectionBottom])
  }
  
  func fetchData() {
    Alamofire.request("https://api.giphy.com/v1/gifs/trending?api_key=9d7dbfe707004b9798b7815c5642d002").responseJSON { response in
      if let json = response.result.value as? [String: AnyObject] {
        if let data = json["data"] as? [[String: AnyObject]] {
          for gif in data {
            guard let images = gif["images"] as? [String: AnyObject] else { return }
            guard let image = images["original"] as? [String: AnyObject] else { return }
            guard let imageUrl = image["url"] as? String else { break }
            guard let width = image["width"] as? String else { break  }
            guard let height = image["height"] as? String else { break }
            self.gifs.append(GIF(imageUrl: imageUrl, width: Float(width)!, height: Float(height)!))
          }
          
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
          }
        }
      }
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gifs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let image = gifs[indexPath.item]
    
    if let width = image.width, let height = image.height {
      return CGSize(width: view.frame.width, height: CGFloat(height))
    }
    
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GIFCollectionViewCell {
      cell.imageView.animatedImage = nil
      let gif = gifs[indexPath.item]
      guard let imageUrl = gif.imageUrl else { return cell }
      
      cell.imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: [], completed: { (image, error, type, url) in
        if (error == nil) {
          
        }
      })
      return cell
    }
    
    return UICollectionViewCell()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

