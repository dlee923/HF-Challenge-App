//
//  IngredientsListCollectionView.swift
//  HF Test
//
//  Created by Daniel Lee on 5/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsListCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }
    
    var ingredients: [String]?
    
    private func setup() {
        self.backgroundColor = .gray
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 44
        let ingredient = ingredients?[indexPath.item] ?? ""
        var title = ""
        title = ingredient
//        let width = title.size(attributes: [NSFontAttributeName: BreadcrumbCell.itemFont]).width + cellPadding
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}


