//
//  UserDetailViewController.swift
//  Quokka
//
//  Created by Marco Tabacchino on 28/11/15.
//  Copyright © 2015 Marco Tabacchino. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Haneke
import AlamofireImage

class UserDetailViewController : UITableViewController {
    
    var index : Int!
    var imageUrl: NSURL!
    var idFriends : [Int] = []
    var arrRes = [[String:AnyObject]]()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    @IBOutlet weak var ageLabel: UILabel!
    
    
    @IBOutlet weak var emailLabel: UILabel!
    

    @IBOutlet weak var descriptionLabel: UILabel!
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict = arrRes[index]

        let array = dict["friends"]?.count
        
        //creo l'array degli id degli amici
        for (var i=0; i < array; i += 1) {
            let obj = dict["friends"]![i]["id"] as? Int
            idFriends.append(obj!)
       
            
            
        }
 
        
        firstNameLabel.text = dict["name"]![0]["first"] as? String
        lastNameLabel.text = dict["name"]![0]["last"] as? String
        ageLabel.text = String (dict["age"]! as! Int)
        emailLabel.text = dict["email"]as? String
        descriptionLabel.text = dict["description"]as? String
        profileImage.hnk_setImageFromFetcher(NetworkFetcher<UIImage>(URL: imageUrl), placeholder: UIImage(named: "thumbnail"))
       
    
        }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showFriends") {
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let friendController = segue.destinationViewController as? FriendViewController
            friendController?.friendsNumber = idFriends.count
            friendController?.indexFriends = idFriends
            friendController?.arrRes = arrRes
            
        }
    }
    
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    
        
    
}



