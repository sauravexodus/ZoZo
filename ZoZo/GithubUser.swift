//
//  GithubUser.swift
//  ZoZo
//
//  Created by Saurav Chandra on 25/05/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import Mapper

struct GithubUser : Mappable {
    
    let avatar : String?
    let username : String
    
    init(map: Mapper) throws {
        
        avatar = map.optionalFrom("avatar_url")
        try username = map.from("login")
        
    }
}
