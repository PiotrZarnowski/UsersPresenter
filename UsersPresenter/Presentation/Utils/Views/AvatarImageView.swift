//
//  AvatarImageView.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 22/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarImageView: UIView {
    
     let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .lightGray
        return imageview
    }()

    override func awakeFromNib() {
          super.awakeFromNib()
          setupView()
      }

      override func prepareForInterfaceBuilder() {
          super.prepareForInterfaceBuilder()
          setupView()
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        fillWith(view: imageView)
        imageView.clipsToBounds = true
        setupCornerRadius()
        setupShadow()
    }
    
     private func setupCornerRadius() {
        imageView.layer.cornerRadius = frame.width / 2
        layer.cornerRadius = frame.width / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
    }

    private func setupShadow() {
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.3
                layer.shadowOffset = .zero
                layer.shadowRadius = 3
    }
}
