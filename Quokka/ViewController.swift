//
//  ViewController.swift
//  Quokka
//
//  Created by Marco Tabacchino on 28/11/15.
//  Copyright © 2015 Marco Tabacchino. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Haneke
import AlamofireImage


class ViewController: UIViewController {
    
    
    
    var imageUrlToPass : NSURL!
    var arrRes = [[String:AnyObject]]()
    var contentMode : UIViewContentMode!
    var firstNames = [String]()
    var lastNames = [String]()
    var emails = [String]()
    var ages = [Int]()
    var images = [UIImage]()
    var desc  = [String]()
    var usersNumber : Int!
    var datas: [JSON] = []
    var json: JSON = JSON.null
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var background: UIImageView!
    
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityInd.hidden = false
        activityInd.startAnimating()
        //scarico il file JSON e lo inserisco in un array
        Alamofire.request(.GET, "http://www.quokka-app.com/users/").responseJSON { (responseData) -> Void in
            let swiftyJsonVar = JSON(responseData.result.value!)
            
            if let resData = swiftyJsonVar[].arrayObject {
                self.arrRes = resData as! [[String : AnyObject]]
            }
            if self.arrRes.count > 0 {
                self.tableView.reloadData()
            }
            
            _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.removeFromSuperView), userInfo: nil, repeats: false)
            
        }
        
        
        
        
        //imposto la barra di navigazione con il logo "Quokka" e la dicitura challenge
        let image = UIImage(named: "navbar1")! as UIImage
        self.navigationController!.navigationBar.setBackgroundImage(image,
            forBarMetrics: .Default)
        
        
    
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
        return arrRes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JSONCell", forIndexPath: indexPath) as! UserTableViewCell
        var dict = arrRes[indexPath.row]
        cell.firstNameLabel.text = dict["name"]![0]["first"] as? String
        cell.lastNameLabel.text = dict["name"]![0]["last"] as? String
        cell.ageLabel.text = String (dict["age"]! as! Int)
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
    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showUserDetail"){
            let detailController = segue.destinationViewController as? UserDetailViewController
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            detailController?.arrRes = arrRes
            
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let row = Int(indexPath.row)
                detailController?.index = row
                var dict = arrRes[indexPath.row]
                let url = dict["picture"]! as? String
                let urlPath: String = url!
                let imageUrl: NSURL = NSURL(string: urlPath)!
                imageUrlToPass = imageUrl
                detailController?.imageUrl = imageUrlToPass
                
                
            }
            
        }
        
    }
    
    
    
}




