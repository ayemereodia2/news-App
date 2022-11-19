//
//  ViewController+Extension.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import UIKit

extension UIViewController {
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }
}
