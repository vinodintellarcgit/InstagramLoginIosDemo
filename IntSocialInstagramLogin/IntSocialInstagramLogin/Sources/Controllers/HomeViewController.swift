//
//  HomeViewController.swift
//  IntSocialInstagramLogin
//
//  Created by Vinod Tiwari on 22/05/19.
//  Copyright © 2019 Intellarc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var bioLable:UILabel!
    @IBOutlet weak var firstNameLable:UILabel!
    @IBOutlet weak var imageProfile:UIImageView!
    @IBOutlet weak var followerCountsLable:UILabel!
    @IBOutlet weak var followingCountsLable:UILabel!
    @IBOutlet weak var userNameLable:UILabel!
    
     private var accesToken = ""
    func setAccesToken(token: String) {
        self.accesToken = token
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageProfile.setCornerRadius(radius: self.imageProfile.frame.size.height/2, borderwidth: 2, borderColor: UIColor.black)
        self.fetchUserData()
    }
}

extension HomeViewController{
    
    private func fetchUserData() {
        
        APIManager.apiRequestWith(accessToken: API.INSTAGRAM_ACCESS_TOKEN_AUTH, parameters: nil, endpoint: "users/self") { [weak self](status, response) in
            if status{
                if let response = response?["data"] as? [String: AnyObject] {
                    var data = UserData()
                    data.bio = response["bio"] as? String
                    data.full_name = response["full_name"] as? String
                    data.profile_picture = response["profile_picture"] as? String
                    data.username = response["username"] as? String
                    data.website = response["website"] as? String
                    data.id = response["id"] as? String
                    data.is_business = response["website"] as? Bool
                    
                    if let countResponse = response["counts"] as? [String: AnyObject]{
                        var count = Counts()
                        count.followed_by = countResponse["followed_by"] as? Int
                        count.follows = countResponse["follows"] as? Int
                        count.media = countResponse["media"] as? Int
                        data.counts = count
                    }
                    var userModel = InstagramUserModel()
                    userModel.data = data
                    self?.updateUI(userModel: userModel)
                }
            }else{
            }
        }
    }
    func updateUI(userModel:InstagramUserModel) {
        
        self.firstNameLable.text = userModel.data?.full_name
        let strBio = userModel.data?.bio
        if strBio == "" {
            self.bioLable.text = "No bio Added"
        }else{
            self.bioLable.text = userModel.data?.bio
        }
        
        self.userNameLable.text = userModel.data?.username
        if let count = userModel.data?.counts, let followedBy = count.followed_by, let follows = count.follows{
            self.followerCountsLable.text = String(followedBy)
            self.followingCountsLable.text = String(follows)
        }
        let url = URL(string: userModel.data?.profile_picture ?? "")
        let data = try! Data(contentsOf: url!)
        self.imageProfile.image = UIImage(data: data)
    }
    
    private func fetchUserMedia (){

        let params = ["ACCESS_TOKEN":API.INSTAGRAM_ACCESS_TOKEN_AUTH,
                      "MAX_ID":"",
                      "MIN_ID":"",
                      "COUNT":"10"] as [String: AnyObject]
        
        APIManager.apiRequestWith(accessToken: API.INSTAGRAM_ACCESS_TOKEN_AUTH, parameters: params, endpoint: "users/self/media/recent/", status: true) { [weak self](status, response) in
            
        }
    }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out",style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
            let cookieJar : HTTPCookieStorage = HTTPCookieStorage.shared
            for cookie in cookieJar.cookies! as [HTTPCookie]{
                if cookie.domain == "www.instagram.com" ||
                    cookie.domain == "api.instagram.com"{
                    cookieJar.deleteCookie(cookie)
                }
            }
            self.navigationController?.popToRootViewController(animated: false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func getMedia (_ sender:UIButton){
        
        self.fetchUserMedia ()
    }
    @IBAction func btnLogout (_ sender:UIButton){
        self.showSimpleAlert()
    }
}
