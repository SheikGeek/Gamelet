//
//  NibNameable.swift
//  GameCollection
//
//  Created by Chelsea Carr on 8/11/19.
//  Copyright © 2019 Chelsea Carr. All rights reserved.
//

import Foundation
import UIKit

protocol NibNameable: class {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibNameable where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
