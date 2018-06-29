import UIKit
import CollectionKit

// base view class that provide viewDidLoad callback so that subclass don't need to implement two init functions
class View: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    viewDidLoad()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    viewDidLoad()
  }

  func viewDidLoad() {

  }

  public var hitTestSlop: UIEdgeInsets?

  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    if let hitTestSlop = hitTestSlop {
      return UIEdgeInsetsInsetRect(bounds, hitTestSlop).contains(point)
    }
    return super.point(inside: point, with: event)
  }
}
