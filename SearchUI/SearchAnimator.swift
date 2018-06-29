import Foundation
import CollectionKit

class SearchAnimator: WobbleAnimator {
  let entryTransform: CATransform3D = {
    var trans = CATransform3DIdentity
    trans.m34 = -1 / 500
    return CATransform3DScale(CATransform3DRotate(CATransform3DTranslate(trans, 0, 0, -100), 0.5, 1, 0, 0), 0.8, 0.8, 1)
  }()

  override func delete(collectionView: CollectionView, view: UIView) {
    if collectionView.isReloading, collectionView.bounds.intersects(view.frame) {
      UIView.animate(withDuration: 0.5, animations: {
        view.layer.transform = self.entryTransform
        view.alpha = 0
      }, completion: { _ in
        if !collectionView.visibleCells.contains(view) {
          view.recycleForCollectionKitReuse()
          view.transform = CGAffineTransform.identity
          view.alpha = 1
        }
      })
    } else {
      view.recycleForCollectionKitReuse()
    }
  }

  override func insert(collectionView: CollectionView, view: UIView, at: Int, frame: CGRect) {
    super.insert(collectionView: collectionView, view: view, at: at, frame: frame)

    if collectionView.isReloading, collectionView.hasReloaded, collectionView.bounds.intersects(frame) {
      let offsetTime: TimeInterval = TimeInterval(frame.origin.distance(collectionView.contentOffset) / 1000)
      view.layer.transform = entryTransform
      view.alpha = 0
      UIView.animate(withDuration: 1.0, delay: offsetTime, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
        view.transform = .identity
        view.alpha = 1
      })
    }
  }

  override func update(collectionView: CollectionView, view: UIView, at: Int, frame: CGRect) {
    if view.bounds.size != frame.bounds.size {
      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.layoutSubviews, .allowUserInteraction], animations: {
        view.bounds.size = frame.bounds.size
      }, completion: nil)
    }
    super.update(collectionView: collectionView, view: view, at: at, frame: frame)
    if view.alpha != 1 || view.transform != .identity {
      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
        view.transform = .identity
        view.alpha = 1
      }, completion: nil)
    }
  }
}
