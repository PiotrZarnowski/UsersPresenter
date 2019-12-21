//
//  CellRegister.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 21/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

extension UITableView {

    func register(cellType: UITableViewCell.Type, reuseIdentifier: String) {
        guard let nib = Bundle.nib(for: cellType) else { return }
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension Bundle {

    public static func nib<V: UIView>(for viewType: V.Type, owner: Any? = nil) -> UINib? {
        let bundle = Bundle(for: viewType)
        return UINib(nibName: String(describing: viewType), bundle: bundle)
    }
}
