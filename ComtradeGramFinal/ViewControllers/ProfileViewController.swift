//
//  ProfileViewController.swift
//  HomePage
//
//  Created by Vladimir Gutic on 1/28/18.
//  Copyright © 2018 Vladimir Gutic. All rights reserved.
//

import UIKit
import SwiftInstagram

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postLbl: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addButtonProfile: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var profileDetailsView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imageTableView: UITableView!
    
    var instagramPosts: [InstagramMedia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Setup view
        
        // View
        self.profileDetailsView.layer.cornerRadius = 5
        self.imageView.layer.cornerRadius = 5
        
        //Button
        
        self.editProfileBtn.layer.cornerRadius = 5
        self.editProfileBtn.layer.borderWidth = 1
        self.editProfileBtn.layer.borderColor = UIColor.black.cgColor
        self.addButtonProfile.layer.cornerRadius = addButtonProfile.layer.frame.width / 2
        
        //Image
        
        self.profileImage.layer.cornerRadius = profileImage.layer.frame.width / 2
        self.profileImage.layer.masksToBounds = true
        
        //Label
        
        self.postLbl.layer.cornerRadius = self.postLbl.layer.frame.size.width / 2
        self.postLbl.layer.borderWidth = 1
        self.postLbl.layer.borderColor = UIColor.black.cgColor
        
        self.followersLbl.layer.cornerRadius = self.postLbl.layer.frame.size.width / 2
        self.followersLbl.layer.borderWidth = 1
        self.followersLbl.layer.borderColor = UIColor.black.cgColor
        
        self.followingLbl.layer.cornerRadius = self.postLbl.layer.frame.size.width / 2
        self.followingLbl.layer.borderWidth = 1
        self.followingLbl.layer.borderColor = UIColor.black.cgColor
        
        // Setup collection view
        
        let imageSize = UIScreen.main.bounds.width/3 - 5
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize (width: imageSize, height: imageSize)
        
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        imageCollectionView.collectionViewLayout = layout
        
        self.imageTableView.rowHeight = 340
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadPosts()
        self.userDetales()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Collection VIew Image
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instagramPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CollectionPhotoCell else {
            fatalError("The dequeued cell is not an instance of HomePageTableViewCell.")
        }
        
        let post = instagramPosts[indexPath.row]
        cell.imageCell.downloadedFrom(url: post.images.standardResolution.url, contentMode: .scaleAspectFill)
        return cell
    }
    
    //MARK: Table view image
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instagramPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoTableCell", for: indexPath) as? PhotoTableViewCell else {
            fatalError("The dequeued cell is not an instance of HomePageTableViewCell.")
        }
        
        let post = instagramPosts[indexPath.row]
        cell.imageTableCell.downloadedFrom(url: post.images.standardResolution.url, contentMode: .scaleAspectFill)
        cell.clipsToBounds = true
        
        /* Odvajanje slika u tabeli */
         cell.layer.borderWidth = 2
         cell.layer.borderColor = UIColor.white.cgColor
        
        return cell
    }
    
    // MARK: - Loading posts from Instagram
    
    func loadPosts(){
        
        Instagram.shared.recentMedia(fromUser: "self", count: 20, success: { mediaList in
            self.instagramPosts = mediaList
            self.imageTableView.reloadData()
            self.imageCollectionView.reloadData()
            
            return
            
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    //MARK: Setup user details
    
    func userDetales () {
        
        Instagram.shared.user("self", success: { user in
            DispatchQueue.main.async {
                self.profileImage.downloadedFrom(url: user.profilePicture, contentMode: .scaleAspectFill)
            }
            self.userName.text = user.username
            self.profileNameLbl.text = user.fullName
            self.followingLbl.text = "\(user.counts!.follows)"
            self.followersLbl.text = "\(user.counts!.followedBy)"
            self.postLbl.text = "\(user.counts!.media)"
        },
                              failure: { error in
                                print(error.localizedDescription)
        })
    }
    
    //MARK: Actions
    
    @IBAction func showCollection(_ sender: UIButton) {
        
        imageTableView.isHidden = true
        imageCollectionView.isHidden = false
    }
    
    @IBAction func showTable(_ sender: UIButton) {
        
        imageTableView.isHidden = false
        imageCollectionView.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
    
}
