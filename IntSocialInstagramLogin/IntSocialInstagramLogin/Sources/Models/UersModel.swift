//
//  UersModel.swift
//  IntSocialInstagramLogin
//
//  Created by Vinod Tiwari on 24/05/19.
//  Copyright © 2019 Intellarc. All rights reserved.
//

import Foundation
struct InstagramUserModel {
    var data: UserData?
}
struct UserData {
    var bio: String?
    var full_name: String?
    var profile_picture: String?
    var username: String?
    var website: String?
    var id: String?
    var is_business: Bool?
    var counts: Counts?
}
struct Counts {
    var followed_by: Int?
    var follows: Int?
    var media: Int?
}

/*["data": {
 bio = "";
 counts =     {
 "followed_by" = 88;
 follows = 49;
 media = 0;
 };
 "full_name" = "Vinod Tiwari";
 id = 6186861480;
 "is_business" = 0;
 "profile_picture" = "https://scontent.cdninstagram.com/vp/12d6e4dabda5180d3bf4ca69cd8685c6/5D822417/t51.2885-19/s150x150/22277689_509053879460398_2006692579927654400_n.jpg?_nc_ht=scontent.cdninstagram.com";
 username = "vinod.tiwari.98434";
 website = "";
 },
 
 "meta": {
 code = 200;
 }]
 */
