//
//  UserTableViewCell.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 21/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userSourceLabelView: UserSourceLabelView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension UserTableViewCell: ConfigurableCell {
    typealias ViewModel = UsersListItemViewModel
    
    func configureCell(viewModel: UsersListItemViewModel) {
        nameLabel.text = viewModel.name
        userSourceLabelView.name = viewModel.sourceName
        userSourceLabelView.backgroundColor = UserSourceColor(rawValue: viewModel.sourceColorId)?.color() ?? .clear
     //   sourceLabelParentView.backgroundColor = UserSourceColor(rawValue: viewModel.sourceColorId)?.color() ?? .clear
     //   sourceLabel.text = viewModel.sourceName
        guard let imageURL = URL(string: viewModel.avatarPath) else {avatarImageView.imageView.image = UIImage()
            return
        }
        avatarImageView.imageView.kf.setImage(with: imageURL)
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
