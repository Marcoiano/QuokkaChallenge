//
//  FriendViewController.swift
//  Quokka
//
//  Created by Marco Tabacchino on 28/11/15.
//  Copyright © 2015 Marco Tabacchino. All rights reserved.
//

import Foundation
import UIKit
import Haneke

class FriendViewController : UIViewController {
    
    var indexFriends : [Int]!
    var friendsNumber : Int!
    var image : UIImage!
    var arrRes = [[String:AnyObject]]()
    
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityInd.hidden = false
        activityInd.startAnimating()
    
        let initialThumbnail = UIImage(named: "thumbnail")
        self.image = initialThumbnail
       
        _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(FriendViewController.removeFromSuperView), userInfo: nil, repeats: false)
    }
    
    func removeFromSuperView() {
        activityInd.hidden = true
        background.hidden = true
        self.tableView.reloadData()
        activityInd.stopAnimating()
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return friendsNumber
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Friend Cell", forIndexPath: indexPath) as! FriendTableViewCell
        
        let index = indexFriends[indexPath.row] as Int
        var dict = arrRes[index]
        cell.firstNameLabel.text = dict["name"]![0]["first"] as? String
        cell.lastNameLabel.text = dict["name"]![0]["last"] as? String
        cell.ageLabel.text = String (dict["age"]! as! Int)
        cell.descriptionLabel.text = dict["description"]! as? String
        cell.emailLabel.text = dict["email"]! as? String
        let url = dict["picture"]! as? String
        let urlPath: String = url!
        let imageUrl: NSURL = NSURL(string: urlPath)!
        cell.profileImage.hnk_setImageFromFetcher(NetworkFetcher<UIImage>(URL: imageUrl), placeholder: UIImage(named: "thumbnail"))
        
        return cell
}
    
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? )-> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    

}

