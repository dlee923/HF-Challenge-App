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
    }
    
    // MARK: - Mutable Properties
    var recipes: [Recipe]? {
        didSet {
            self.recipeCollectionView?.recipes = self.recipes
        }
    }
    
    // MARK: - UI Elements
    var recipeCollectionView: RecipeCollectionView?
    let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Setup and retrieve data methods
    // Setup of MainViewController
    private func setup() {
        self.view.backgroundColor = .white
        self.addViews()
        self.addLoginButton()
        self.downloadRecipeData(completion: { self.recipes = $0 })
    }
    
    // Download data from JSON file
    private func downloadRecipeData(completion: @escaping ([Recipe])->()) {
        self.activityInProgress()
        
        var tempRecipes: [Recipe]?
        // Create DispatchGroup to manage synchronous execution of webservice calls
        let dispatchGroup = DispatchGroup()
        
        DispatchQueue.global().sync {
            RecipeAPI.sharedInstance.downloadRecipeData(completion: { tempRecipes = $0 })
        }
        DispatchQueue.global().sync {
            if let recipes = tempRecipes {
//                for recipe in recipes {
//                    dispatchGroup.enter()
//                    let imageLink = recipe.recipeImageSource?.image ?? ""
//                    ImageAPI.sharedInstance.downloadImage(urlLink: imageLink, completion: {
//                        recipe.imageData = $0
//                        dispatchGroup.leave()
//                    })
//                }
//                dispatchGroup.wait()
            }
        }
        dispatchGroup.notify(queue: .global()) {
            DispatchQueue.main.async {
                self.activityEnded()
                if let downloadedRecipes = tempRecipes {
                    completion(downloadedRecipes)
                }
            }
        }
    }

}

protocol UserFeedbackDelegate: MainViewController {
    func userLiked(liked: Bool)
}

// MARK: - Webservice methods from user interaction (Sending likes to server)
extension MainViewController: UserFeedbackDelegate {
    
    internal func userLiked(liked: Bool) {
        if liked {
            // send like to server
            print("Liked!")
        } else {
            // send unlike to server
            print("Unliked!")
        }
    }
}


// MARK - Add Views and Constraints + Activity Indicator
extension MainViewController {
    
    // Layout of main recipe collection view
    private func addViews() {
        self.recipeCollectionView = RecipeCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        guard let recipeCollectionView = self.recipeCollectionView else { return }
        recipeCollectionView.userFeedbackDelegate = self
        self.view.addSubview(recipeCollectionView)
        
        recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recipeCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        recipeCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        recipeCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        recipeCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    // Add Login Button
    private func addLoginButton() {
        let profileButton = UIButton(type: .custom)
        profileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.setImage(UIImage(named: "user_hf.png"), for: .normal)
        profileButton.addTarget(self, action: #selector(self.presentLoginViewController), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    @objc private func presentLoginViewController() {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    // Activity indicator method
    private func activityInProgress() {
        self.activityIndicator.isHidden = false
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.backgroundColor = .black
        self.activityIndicator.layer.cornerRadius = 10
        self.activityIndicator.clipsToBounds = true
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        
        self.activityIndicator.startAnimating()
        print("start")
    }
    
    private func activityEnded() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.activityIndicator.removeFromSuperview()
        print("finished")
    }
    
}
