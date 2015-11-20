//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    
    //var datePoster: NSDate!

    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        //print(data)
        likes = (data.valueForKey("likes") as! NSDictionary).valueForKey("count") as! Int;
        url = ((data.valueForKey("images") as! NSDictionary).valueForKey("standard_resolution") as! NSDictionary).valueForKey("url") as! String
//        var theIndex = url.endIndex
//        print(theIndex)
//        for var counter = 11; counter > 0; counter -= 1 {
//            theIndex = theIndex.predecessor()
//        }
//        
//        print(theIndex)
//        url = url.substringToIndex(theIndex);
        username = (data.valueForKey("user") as! NSDictionary).valueForKey("username") as! String
        
    }

}