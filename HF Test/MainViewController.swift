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
        Device.current.retrieveDeviceDetails()
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
    var introBlankView: UIView?
    
    // MARK: - Setup and retrieve data methods
    // Setup of MainViewController
    internal func setup() {
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
            RecipeAPI.sharedInstance.downloadRecipeData(completion: {
                tempRecipes = $0
                DispatchQueue.main.async {
                    self.activityEnded()
                    if let downloadedRecipes = tempRecipes {
                        completion(downloadedRecipes)
                    }
                }
            })
        }
        DispatchQueue.global().async {
            if let recipes = tempRecipes {
                for recipe in recipes {
                    dispatchGroup.enter()
                    let imageLink = recipe.recipeImageSource?.image ?? ""
                    ImageAPI.sharedInstance.downloadImage(urlLink: imageLink, completion: {
                        recipe.imageData = $0
                        dispatchGroup.leave()
                    })
                }
                dispatchGroup.wait()
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
    func userRated(rating: Int, isRated: Bool)
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
    
    internal func userRated(rating: Int, isRated: Bool) {
        print("Sending rating of \(rating) to server.")
        var ratingPrompt_: UIAlertController?
        if !isRated {
            ratingPrompt_ = UIAlertController().simpleAlertPrompt(title: "Cancelled!", message: "Your rating has been cancelled", preferredStyle: .alert, actionTitle: nil)
        } else {
            ratingPrompt_ = UIAlertController().simpleAlertPrompt(title: "Thank you!", message: "Your rating has been submitted", preferredStyle: .alert, actionTitle: nil)
        }
        guard let ratingPrompt = ratingPrompt_ else { return }
        self.present(ratingPrompt, animated: true, completion: {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
                ratingPrompt.dismiss(animated: true, completion: nil)
            })
        })
    }
}


// MARK - Add Views and Constraints + Activity Indicator
extension MainViewController {
    
    // Layout of main recipe collection view
    private func addViews() {
        self.recipeCollectionView = RecipeCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        guard let recipeCollectionView = self.recipeCollectionView else { return }
        recipeCollectionView.userFeedbackDelegate = self
        let inset = -(DeviceViews.statusBarNavBarHeight[Device.current.deviceType] ?? 0.0)
        recipeCollectionView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: 0, right: 0)
        self.view.addSubview(recipeCollectionView)
        
        recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recipeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        recipeCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        recipeCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        recipeCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    
    // Add Login Button
    private func addLoginButton() {
        let profileButton = UIButton(type: .custom)
        profileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.tintColor = .white
        profileButton.setImage(UIImage(named: "user_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        profileButton.addTarget(self, action: #selector(self.presentLoginViewController), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    @objc private func presentLoginViewController() {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    // Activity indicator method
    private func activityInProgress() {
        // Add background view to prevent user interactions
        introBlankView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        introBlankView?.backgroundColor = UIColor.color1
        
        UIApplication.shared.keyWindow?.addSubview(introBlankView ?? UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)))
        
        self.activityIndicator.isHidden = false
        UIApplication.shared.keyWindow?.addSubview(self.activityIndicator)
        self.activityIndicator.backgroundColor = .black
        self.activityIndicator.layer.cornerRadius = 10
        self.activityIndicator.clipsToBounds = true
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.centerYAnchor).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.widthAnchor, multiplier: 0.25).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.widthAnchor, multiplier: 0.25).isActive = true
        
        self.activityIndicator.startAnimating()
        print("start")
    }
    
    private func activityEnded() {
        UIView.animate(withDuration: 0.35, animations: {
            self.introBlankView?.alpha = 0.0
        }) { (_) in
            self.introBlankView?.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.activityIndicator.removeFromSuperview()
            print("finished")
        }
    }
    
}
