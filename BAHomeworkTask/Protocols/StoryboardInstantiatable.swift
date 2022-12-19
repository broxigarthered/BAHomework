//
//  StoryboardInstantiatable.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 15.12.22.
//

import Foundation
import UIKit

public protocol StoryboardInstantiatable: AnyObject {
  static var storyboard: UIStoryboard { get }
}

public extension StoryboardInstantiatable {
  static var storyboard: UIStoryboard {
    return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
  }
}

public extension StoryboardInstantiatable where Self: UIViewController {
  static func instantiate() -> Self {
    guard let vc = storyboard.instantiateInitialViewController() as? Self else {
      fatalError("The VC is not of a class \(self)")
    }
    return vc
  }
}
