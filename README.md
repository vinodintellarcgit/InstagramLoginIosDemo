# InstagramLoginIosDemo

# Follow below mentioned process to integrate instagram in your iOS swift project.

Login to your instagram account on: https://www.instagram.com/developer/register/

and Register your application on instagram.

Then get your Client ID, Client Secret and add your Redirect urls on Manage Clients Section.

After that open your project and paste Client ID, Client Secret and Redirect url in constant.swift file.

```
struct API{
    static let INSTAGRAM_BASEURL = "https://api.instagram.com/"
    static let API_VERSION = "v1/"
    static let INSTAGRAM_AUTHURL = INSTAGRAM_BASEURL + "oauth/authorize/"
    static let INSTAGRAM_CLIENT_ID = "Paste Your Client Id Here"
    static let INSTAGRAM_CLIENTSERCRET = "Paste Your Client Secret Id Here"
    static let INSTAGRAM_REDIRECT_URI = "Paste Your Redirect url Here"
    static let INSTAGRAM_ACCESS_TOKEN = "access_token"
    static let INSTAGRAM_SCOPE = "basic"
    static var INSTAGRAM_ACCESS_TOKEN_AUTH = ""
    
}
```

And get response of user basic details of instagram account in this section.

```
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
   
```

and Run Project.



Thanks have a nice day.
