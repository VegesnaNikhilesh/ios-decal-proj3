//
//  photoViewController.swift
//  Photos
//
//  Created by Nikhilesh Vegesna on 11/19/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class photoViewController: UIViewController {

    @IBOutlet var isLiked: UILabel!
    
    @IBOutlet var myLikeButton: UIButton!
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel: UILabel!
    var myLabelText: String!
    @IBOutlet var likesLabel: UILabel!
    var myPhoto: Photo!
    var emptyHeart = "♡"
    var likedHeart = "❤️" 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = myLabelText
        loadImageForCell(myPhoto, imageView: myImageView)
        likesLabel.text = String(myPhoto.likes)
        isLiked.text = "Un-Liked"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func like(sender: UIButton) {
        if isLiked.text == "Un-Liked" {
            isLiked.text = "Liked"
        }
        else {
            isLiked.text = "Un-Liked"
        }
    }
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let myURL  = NSURL(string: photo.url)
        //print(myURL)
        let task = NSURLSession.sharedSession().dataTaskWithURL(myURL!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            }
            if error == nil {
                do {
                    print("am i called now?")
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            let img = UIImage(data: data!)
                            imageView.image = img
                        }
                    }
                }
            }
        }
        task.resume()
        
    }
    
    func update(myText: String,thePhoto: Photo) {
        myLabelText = myText
        myPhoto = thePhoto
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
