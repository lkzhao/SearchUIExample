//
//  SearchHomeViewController.swift
//  SearchUI
//
//  Created by Luke Zhao on 2018-06-26.
//  Copyright © 2018 Luke Zhao. All rights reserved.
//

import UIKit
import Alamofire
import CollectionKit
import SwiftIcons

let clientId = "472a470e3fb05a2079d13f77cd9557354d0f0901bce20089a1ad59569558b1dd"

class SearchHomeViewController: UIViewController {

  let collectionView = CollectionView()

  let searchField: UITextField = {
    let textField = UITextField()
    textField.setLeftViewIcon(icon: .ionicons(.iosSearch))
    textField.tintColor = .darkGray
    textField.font = .systemFont(ofSize: 18)
    return textField
  }()

  let searchBackground = DefaultShadowView()

  let dataSource = ArrayDataSource<UnsplashImage>(data: []) { (index, data) -> String in
    return data.id
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(hexString: "EEEEEE")
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.contentInset = UIEdgeInsets(top: 240, left: 20, bottom: 40, right: 20)
    collectionView.delegate = self
    collectionView.tapGestureRecognizer.addTarget(self, action: #selector(dismissKeyboard))

    searchField.delegate = self

    view.addSubview(collectionView)
    view.addSubview(searchBackground)
    view.addSubview(searchField)

    let provider = BasicProvider(
      dataSource: dataSource,
      viewSource: ClosureViewSource(viewUpdater: {
        (view: ImageItemView, data: UnsplashImage, at: Int) in
        view.populate(image: data)
      }),
      sizeSource: { (_, view, size) -> CGSize in
        return CGSize(width: size.width, height: 240)
      },
      layout: FlowLayout(lineSpacing: 30),
      animator: SearchAnimator()
    )

    collectionView.provider = provider

    searchField.text = "Office"
    search(text: "office")
  }

  func tween(offset: CGFloat, start: CGFloat, end: CGFloat) -> CGFloat {
    return (offset - start) / (end - start)
  }

  func mix(progress: CGFloat, start: CGRect, end: CGRect) -> CGRect {
    return CGRect(x: start.minX + progress * (end.minX - start.minX),
                  y: start.minY + progress * (end.minY - start.minY),
                  width: start.width + progress * (end.width - start.width),
                  height: start.height + progress * (end.height - start.height))
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
    layoutSearchbar()
  }

  func layoutSearchbar() {
    let bounds = view.bounds
    let progress = tween(offset: -collectionView.contentOffset.y, start: 240, end: 0)
    let clamped = min(1, max(0, progress))
    let fieldRect = mix(progress: clamped,
                        start: CGRect(x: 30, y: 100, width: bounds.width - 40, height: 40),
                        end: CGRect(x: 20, y: 30, width: bounds.width - 40, height: 40))
    let backgroundRect = mix(progress: clamped,
                             start: CGRect(x: 20, y: 90, width: bounds.width - 40, height: 60),
                             end: CGRect(x: 0, y: 0, width: bounds.width, height: 80))
    if progress < 0 {
      searchBackground.frame = CGRect(x: backgroundRect.minX,
                                      y: backgroundRect.minY + -progress * 10,
                                      width: backgroundRect.width,
                                      height: backgroundRect.height + -progress * 40)
      searchField.frame = CGRect(x: fieldRect.minX,
                                 y: fieldRect.minY + -progress * 20,
                                 width: fieldRect.width,
                                 height: fieldRect.height)
    } else {
      searchBackground.frame = backgroundRect
      searchField.frame = fieldRect
    }
  }

  @objc func dismissKeyboard() {
    _ = searchField.resignFirstResponder()
  }

  func search(text: String) {
    Alamofire.request("https://api.unsplash.com/search/photos?client_id=\(clientId)&query=\(text)")
      .responseJSONDecodable { [weak self] (response: DataResponse<UnsplashResponse<UnsplashImage>>) in
      if let json = response.result.value {
        self?.dataSource.data = json.results
      }
    }
  }
}

extension SearchHomeViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    search(text: textField.text ?? "")
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    _ = textField.resignFirstResponder()
    return true
  }
}

extension SearchHomeViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    layoutSearchbar()
  }
}
