//
//  Model.swift
//  SearchUI
//
//  Created by Luke Zhao on 2018-06-29.
//  Copyright © 2018 Luke Zhao. All rights reserved.
//

import UIKit

struct UnsplashResponse<Data: Codable>: Codable {
  let total: Int
  let results: [Data]
}

struct User: Codable {
  let name: String
}

struct UnsplashImage: Codable {
  let id: String
  let width: CGFloat
  let height: CGFloat
  let color: String
  let description: String?
  let urls: URLList
  let user: User

  struct URLList: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let thumb: String?
  }
}
