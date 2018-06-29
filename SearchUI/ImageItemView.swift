//
//  ImageItemView.swift
//  SearchUI
//
//  Created by Luke Zhao on 2018-06-28.
//  Copyright © 2018 Luke Zhao. All rights reserved.
//

import UIKit
import PINRemoteImage

class DefaultShadowView: View {
  override func viewDidLoad() {
    super.viewDidLoad()

    backgroundColor = .white
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 14)
    layer.shadowRadius = 10
    layer.shadowOpacity = 0.1
    layer.cornerRadius = 4
  }
}

class ImageItemView: DefaultShadowView {
  let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 4
    $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
  }

  let titleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.font = .systemFont(ofSize: 14)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubview(imageView)
    addSubview(titleLabel)
  }

  func populate(image data: UnsplashImage) {
    imageView.backgroundColor = UIColor(hexString: data.color)
    imageView.image = nil
    if let imageUrl = data.urls.regular {
      imageView.pin_setImage(from: URL(string: imageUrl))
    }
    titleLabel.text = "Photo by \(data.user.name)"
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 14 - 40)
    titleLabel.frame = CGRect(x: 20, y: bounds.height - 20 - 14, width: bounds.width - 40, height: 14)
  }
}
