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
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
  static func instantiate() -> Self {
      guard let vc = storyboard.instantiateViewController(withIdentifier: defaultFileName) as? Self else {
                      fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(defaultFileName)")
      }
    return vc
  }
}
