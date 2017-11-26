//
//  GIF.swift
//  GIFS
//
//  Created by Isaac Rosenberg on 11/25/17.
//  Copyright © 2017 Isaac Rosenberg. All rights reserved.
//

import UIKit

class GIF: NSObject {
  var imageUrl: URL?
  var width: Float?
  var height: Float?
  init(imageUrl: String, width: Float, height: Float) {
    self.imageUrl = URL(string: imageUrl)
    self.width = width
    self.height = height
    super.init()
  }
  
  required init!(coder: NSCoder!) {
    fatalError("init(coder:) has not been implemented")
  }
}
