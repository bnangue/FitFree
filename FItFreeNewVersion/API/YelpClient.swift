//
//  YelpClient.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//
import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl! as URL, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, parameters: Dictionary<String, String>? = nil, offset: Int = 0, limit: Int = 20, success: @escaping (AFHTTPRequestOperation?, AnyObject?) -> Void, failure: (AFHTTPRequestOperation?, NSError!) -> Void) -> AFHTTPRequestOperation! {
        var params: NSMutableDictionary = [
            "term": term,
            "offset": offset,
            "limit": limit
        ]
        for (key, value) in parameters! {
            params.setValue(value, forKey: key)
        }
        return self.GET("search", parameters: params, success: success, failure: failure)
    }
    
}
