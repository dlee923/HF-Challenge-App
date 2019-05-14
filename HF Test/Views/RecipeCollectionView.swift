//
//  RecipeCollectionView.swift
//  HF Test
//
//  Created by Daniel Lee on 5/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Initializer
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }
    
    // MARK: - Cell Colors
    let colors = [UIColor.color1,
                  UIColor.color3,
                  UIColor.color4,
                  UIColor.color5,
                  UIColor.color6,
                  UIColor.color7,
                  UIColor.color8,
                  UIColor.color3,
                  UIColor.color4]
    
    // MARK: - Mutable Properties
    var recipes: [Recipe]? {
        didSet { self.reloadData() }
    }
    
    // MARK: - Delegate Properties
    weak var userFeedbackDelegate: UserFeedbackDelegate?
    
    // MARK: - Setup
    internal func setup() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
        self.registerCells()
        self.collectionViewBehavior()
    }
    
    private func registerCells() {
        self.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCellId.recipe.rawValue)
    }
    
    private func collectionViewBehavior() {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        self.isPagingEnabled = true
    }
    
    // Cell Reuse Identifiers
    enum RecipeCellId: String {
        case recipe = "recipe"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


// MARK: UICollectionViewDataSource
extension RecipeCollectionView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recipes?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCellId.recipe.rawValue, for: indexPath) as? RecipeCell {
            cell.splashColor = self.colors[indexPath.item]
            cell.modifyColors()
            cell.recipe = self.recipes?[indexPath.item]
            cell.userFeedbackDelegate = self.userFeedbackDelegate
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // Removes spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}


// MARK: UICollectionViewDelegate
extension RecipeCollectionView {
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
