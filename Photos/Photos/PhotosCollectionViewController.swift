//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var photos: [Photo]!
    var currentPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let myPicCell:picCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! picCell
        let thePhoto = photos[indexPath.row] as Photo!
        myPicCell.myUsername.text = thePhoto.username
        loadImageForCell(thePhoto, imageView: myPicCell.myImage)
        print(myPicCell.myUsername.text)
        return myPicCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(photos == nil){
            return 0
        }
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentPhoto = photos[indexPath.row]
        performSegueWithIdentifier("doMe", sender: self)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    
    
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doMe" {
            if currentPhoto != nil {
//                let destinationVC = segue.destinationViewController as! UINavigationController
//                let contrlr = destinationVC.viewControllers[0] as! photoViewController
                let contrlr = segue.destinationViewController as! photoViewController
                
                contrlr.update(currentPhoto!.username, thePhoto: currentPhoto!)
                
                //loadImageForCell(currentPhoto!,imageView: contrlr.myImageView)
            }
        }
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

