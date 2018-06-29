import UIKit

@objc protocol RootView: class {
  @objc optional var preferredStatusBarStyle: UIStatusBarStyle { get }
  @objc optional func willAppear()
  @objc optional func willDisappear()
  @objc optional func didAppear()
  @objc optional func didDisappear()
  @objc optional func wantsOverFullscreen() -> Bool
}

class ViewController<RootViewType: UIView>: UIViewController where RootViewType: RootView {
  var rootView: RootViewType {
    return self.view as! RootViewType
  }

  init(_ view: RootViewType? = nil) {
    super.init(nibName: nil, bundle: nil)
    self.view = view ?? RootViewType(frame: UIScreen.main.bounds)
    if rootView.wantsOverFullscreen?() == true {
      modalPresentationStyle = .overFullScreen
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("deinit \(type(of: self))")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    rootView.willAppear?()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    rootView.didAppear?()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    rootView.willDisappear?()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    rootView.didDisappear?()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return rootView.preferredStatusBarStyle ?? .default
  }
}

