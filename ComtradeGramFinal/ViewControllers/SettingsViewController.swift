//
//  ViewController.swift
//  ComtradeGramFinal
//
//  Created by Predrag Jevtic on 1/10/18.
//  Copyright © 2018 com.comtrade.Gram. All rights reserved.
//

import UIKit
import SwiftInstagram

class SettingsViewController: UIViewController {

    var instagramPost: InstagramMedia?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Instagram.shared.recentMedia(fromUser: "self", success: { (posts) in
            if posts.count > 0 {
                self.instagramPost = posts[0]
            }
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openMaps(){
        self.performSegue(withIdentifier: "openMap", sender: self)
    }

    @IBAction func openComments(){
        self.performSegue(withIdentifier: "openComments", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier) {
        case "openMap"?:
            if let mapVC = segue.destination as? MapViewController {
                mapVC.post = self.instagramPost
            }

        case "openMap"?:
            if let commentsVC = segue.destination as? CommentsViewController {
                commentsVC.post = self.instagramPost
            }
        default:
            break
        }
    }
}

