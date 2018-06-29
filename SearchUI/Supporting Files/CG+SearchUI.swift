//
//  CG+SearchUI.swift
//  SearchUI
//
//  Created by Luke Zhao on 2018-06-26.
//  Copyright © 2018 Luke Zhao. All rights reserved.
//

import CoreGraphics

func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func += (left: inout CGPoint, right: CGPoint) {
  left.x += right.x
  left.y += right.y
}
func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func /(left: CGPoint, right: CGFloat) -> CGPoint {
  return CGPoint(x: left.x/right, y: left.y/right)
}
func /(left: CGPoint, right: CGSize) -> CGPoint {
  return CGPoint(x: left.x/right.width, y: left.y/right.height)
}
func *(left: CGPoint, right: CGFloat) -> CGPoint {
  return CGPoint(x: left.x*right, y: left.y*right)
}
func *(left: CGPoint, right: CGSize) -> CGPoint {
  return CGPoint(x: left.x*right.width, y: left.y*right.height)
}
func *(left: CGFloat, right: CGPoint) -> CGPoint {
  return right * left
}
func *(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x*right.x, y: left.y*right.y)
}
prefix func -(point: CGPoint) -> CGPoint {
  return CGPoint.zero - point
}
func *(left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width*right, height: left.height*right)
}
func *(left: CGFloat, right: CGSize) -> CGSize {
  return right * left
}
func /(left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width/right, height: left.height/right)
}
func /(left: CGSize, right: CGSize) -> CGSize {
  return CGSize(width: left.width/right.width, height: left.height/right.height)
}
func -(left: CGPoint, right: CGSize) -> CGPoint {
  return CGPoint(x: left.x - right.width, y: left.y - right.height)
}
func -(left: CGSize, right: CGSize) -> CGSize {
  return CGSize(width: left.width - right.width, height: left.height - right.height)
}

extension CGRect {
  var center: CGPoint {
    return CGPoint(x: midX, y: midY)
  }
  var bounds: CGRect {
    return CGRect(origin: .zero, size: size)
  }
  init(center: CGPoint, size: CGSize) {
    self.init(origin: center - size / 2, size: size)
  }
}

extension CGPoint {
  func translate(_ dx: CGFloat, dy: CGFloat) -> CGPoint {
    return CGPoint(x: self.x+dx, y: self.y+dy)
  }

  func transform(_ t: CGAffineTransform) -> CGPoint {
    return self.applying(t)
  }

  func distance(_ b: CGPoint) -> CGFloat {
    return sqrt(pow(self.x-b.x, 2)+pow(self.y-b.y, 2))
  }
}
