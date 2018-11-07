//
//  GoogleMapObjectRequest.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//


class GeocodingRequest {
    
    var address: String
    
    init(address: String) {
        self.address = address
    }
    
    func toParameters() -> Parameters {
        
        let parameters: Parameters = [
            "address": self.address,
            "key": "AIzaSyAKz-i3MzQZLJf3_Vabn_24XCj4352Q4pE"
        ]
        
        return parameters
    }
    
}
