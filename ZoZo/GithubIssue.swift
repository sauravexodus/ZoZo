//
//  GithubIssue.swift
//  ZoZo
//
//  Created by Saurav Chandra on 25/05/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import Mapper

struct GithubIssue: Mappable {
    
    let body: String?
    let title: String
    let state: String?
    let user: GithubUser
    let issueNumber : Int
    let assignee : GithubUser?
    
    
    init(map: Mapper) throws {
        state = map.optionalFrom("state")
        try title = map.from("title")
        body = map.optionalFrom("body")
        try user = map.from("user")
        try issueNumber = map.from("number")
        assignee = map.optionalFrom("assignee")
    }
}
