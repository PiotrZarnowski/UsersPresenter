//
//  UserSourceColor.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 23/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

enum UserSourceColor: Int {
    case blue = 1
    case green
    
    func color() -> UIColor {
        switch self {
        case .blue:
            return .systemBlue
        case .green:
            return .systemGreen
        }
    }
}
