//
//  UserDetailsViewController.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 23/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailsViewController: UIViewController {
    
    var viewModel: UserDetailsViewModel!
    
    final class func create(with viewModel: UserDetailsViewModel) -> UserDetailsViewController {
           let view = UserDetailsViewController()
           view.viewModel = viewModel
           return view
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        setupView()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
        func bind(to viewModel: UserDetailsViewModel) {
        viewModel.name.observe(on: self) { [weak self] in self?.nameLabel.text = $0 }
            viewModel.avatarPath.observe(on: self) { [weak self] in self?.setupAvatar(with: $0) }
            viewModel.userSourceName.observe(on: self) { [weak self] in self?.sourceNameLabelView.name = $0}
            viewModel.userSourceColorId.observe(on: self) { [weak self] in self?.sourceNameLabelView.backgroundColor = UserSourceColor(rawValue: $0)?.color() ?? .clear}
       }
    
    let avatarImageView: AvatarImageView = {
        let avatar = AvatarImageView()
        avatar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return avatar
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let sourceNameLabelView: UserSourceLabelView = {
        let label = UserSourceLabelView()
        label.cornerRadius = 10
        return label
    }()
    
    let baseScrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()

    let internalView: UIView = {
        let view = UIView()
        return view
    }()

    let baseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .equalCentering
        stack.alignment = .center
        return stack
    }()


    func addViewsToScroll(views: UIView...) {
        for view in views {
            baseStack.addArrangedSubview(view)
        }
    }

    private func setupView() {
        title = "User"
        self.view.fillWith(view: baseScrollView)
        baseScrollView.fillWith(view: internalView)
        internalView.fillWith(view: baseStack, padding: 20)
        setupInternalViewConstraints()
        addViewsToScroll(views: avatarImageView, nameLabel, sourceNameLabelView)
    }

    private func setupInternalViewConstraints() {
        internalView.translatesAutoresizingMaskIntoConstraints = false
        let internalViewHeightConstraint = NSLayoutConstraint(item: internalView,attribute: NSLayoutConstraint.Attribute.height, relatedBy:NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:NSLayoutConstraint.Attribute.height, multiplier: 0, constant: 1)
        internalViewHeightConstraint.priority = UILayoutPriority(250)
        self.view.addConstraint(NSLayoutConstraint(item: internalView, attribute:NSLayoutConstraint.Attribute.width, relatedBy:NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0))
        self.view.addConstraint(internalViewHeightConstraint)
    }
    
    private func setupAvatar(with imagePath: String) {
        guard let url = URL(string: imagePath) else {return}
        avatarImageView.imageView.kf.setImage(with: url)
    }

}

