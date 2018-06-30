//
//  ImageItemView.swift
//  SearchUI
//
//  Created by Luke Zhao on 2018-06-28.
//  Copyright © 2018 Luke Zhao. All rights reserved.
//

import UIKit
import PINRemoteImage

class DefaultShadowView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 14)
    layer.shadowRadius = 10
    layer.shadowOpacity = 0.1
    layer.cornerRadius = 4
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class ImageItemView: DefaultShadowView {
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 4
    imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    return imageView
  }()

  let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 1
    titleLabel.font = .systemFont(ofSize: 14)
    return titleLabel
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
    addSubview(titleLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
