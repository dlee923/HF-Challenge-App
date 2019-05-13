//
//  IngredientsPillCell.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPillCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - UI Elements
    let ingredient = UILabel()
    
    // MARK: - Setup method
    internal func setup() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .gray
        
        self.addLabel() 
    }
    
    internal func addLabel() {
        self.addSubview(self.ingredient)
        ingredient.translatesAutoresizingMaskIntoConstraints = false
        ingredient.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        ingredient.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 2).isActive = true
        ingredient.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2).isActive = true
        ingredient.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
