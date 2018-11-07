//
//  CDYelpFusionKitManager.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 27.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CDYelpFusionKit

class CDYelpFusionKitManager: NSObject {

    static let shared = CDYelpFusionKitManager()
    
    var apiClient: CDYelpAPIClient!
    
    func configure(){
        self.apiClient = CDYelpAPIClient(apiKey: "V2XsH0SdeoWOLrK-XhrBAlnTVeRdLlCmz8G2dG2XKkvlNNWFnbpkuT2xxMp7biftSBpeuXzZQlqJhxCd9iCcNaH59i3mGiNXAFEHtsBqi9eghbkSTj0DNj9T0KejW3Yx")
    }
}
