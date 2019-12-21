//
//  UserTableViewCell.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 21/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceLabelParentView: UIView!
    
//    @IBInspectable var avatarImageCornerRadius: CGFloat = 0 {
//       didSet {
//        avatarImageView.layer.cornerRadius = avatarImageCornerRadius
//        avatarImageView.layer.masksToBounds = avatarImageCornerRadius > 0
//       }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        sourceLabelParentView.layer.cornerRadius = 10
        avatarImageView.layer.cornerRadius = 25
        setupShadow(for: sourceLabelParentView, avatarImageView)
    }
    
    private func setupShadow(for views: UIView...) {
        for view in views {
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.3
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 3
        }
    }
}

extension UserTableViewCell: ConfigurableCell {
    typealias ViewModel = UsersListItemViewModel
    
    func configureCell(viewModel: UsersListItemViewModel) {
        nameLabel.text = viewModel.name
        sourceLabelParentView.backgroundColor = UserSourceColor(rawValue: viewModel.sourceColorId)?.color() ?? .clear
        sourceLabel.text = viewModel.sourceName
        
    }
}

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
