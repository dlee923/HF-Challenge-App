//
//  ViewController.swift
//  HF Test
//
//  Created by Daniel Lee on 5/9/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
    
    var recipes: [Recipe]?
    
    private func setup() {
        self.view.backgroundColor = .red
        RecipeAPI.sharedInstance.downloadRecipeData(completion: {[unowned self] in self.recipes = $0 })
    }


}

