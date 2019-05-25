//
//  APIManager.swift
//  IntSocialInstagramLogin
//
//  Created by Vinod Tiwari on 25/05/19.
//  Copyright © 2019 Intellarc. All rights reserved.
//

import Foundation

class APIManager{
   
    static func apiRequestWith(accessToken:String , parameters:[String: AnyObject]?, endpoint: String, status: Bool = false,completion: @escaping ((_ data: Bool, _ response: [String: AnyObject]?) -> Void)){
        
        var url = API.INSTAGRAM_BASEURL + API.API_VERSION + endpoint + "?\(API.INSTAGRAM_ACCESS_TOKEN)=" + API.INSTAGRAM_ACCESS_TOKEN_AUTH
        if status {
            url = API.INSTAGRAM_BASEURL + API.API_VERSION + endpoint + "?\(API.INSTAGRAM_ACCESS_TOKEN)=" + API.INSTAGRAM_ACCESS_TOKEN_AUTH + "&count=20"
        }

        var request = URLRequest(url: URL(string: url)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard error == nil else {
                completion(false, nil)
                //failure
                return
            }
            // make sure we got data
            guard let responseData = data else {
                completion(false, nil)
                //Error: did not receive data
                return
            }
            do {
                guard let dataResponse = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: AnyObject] else {
                        completion(false, nil)
                        //Error: did not receive data
                        return
                }
                print(dataResponse)
                DispatchQueue.main.async {
                    completion(true, dataResponse)
                }
                // success (dataResponse) dataResponse: contains the Instagram data
            } catch let error {
                print(error)
                completion(false, nil)
                //failure
            }
        })
        task.resume()
    }
}

