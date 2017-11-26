//
//  GIFCollectionViewCell.swift
//  GIFS
//
//  Created by Isaac Rosenberg on 11/25/17.
//  Copyright © 2017 Isaac Rosenberg. All rights reserved.
//

import UIKit
import SDWebImage

class GIFCollectionViewCell: UICollectionViewCell {
  var imageView = FLAnimatedImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  func setupView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    addSubview(imageView)
    
    let constraintViews = ["imageView" : imageView]
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView]-|", options: [], metrics: nil, views: constraintViews))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageView]-|", options: [], metrics: nil, views: constraintViews))
  }
}
