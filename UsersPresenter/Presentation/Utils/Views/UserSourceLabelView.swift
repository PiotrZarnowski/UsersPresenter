//
//  UserSourceLabelView.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 22/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import UIKit

@IBDesignable
class UserSourceLabelView: UIView {

     private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
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
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
          get {
            return nameLabel.font.pointSize
          }
          set(fontSize) {
            nameLabel.font = .systemFont(ofSize: fontSize)
          }
      }
    
    
    
   @IBInspectable var name: String {
        get {
            return nameLabel.text ?? ""
        }
        set(name){
            nameLabel.text = name
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
            addLabel()
            setupShadow()
    }
    
    private func addLabel() {
        addSubview(nameLabel)
             nameLabel.translatesAutoresizingMaskIntoConstraints = false
             addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -5))
             addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 5))
             addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 5))
             addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -5))
    }
    
    private func setupShadow() {
        layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.3
                layer.shadowOffset = .zero
                layer.shadowRadius = 3
    }
}
