//
//  Github.swift
//  ZoZo
//
//  Created by Saurav Chandra on 25/05/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum Github {
    case issues(repositoryFullName: String)
    case postComment(repositoryFullName: String, issueId : Int)
}

extension Github: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var apiKey : String { return "1e743ba8db886c0a357c96650351cffd25e11ef3" }
    var path: String {
        switch self {
        case .issues(let repositoryName):
            return "/repos/\(repositoryName)/issues"
            
        case .postComment(let repositoryName, let issueId):
            return "/repos/\(repositoryName)/issues/\(issueId)/comments"
            
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .issues(_):
            return .get
        default:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .issues(_):
            return "[{\"title\": \"Cancel concurrency issue\", \"user\": { \"login\": \"davidgyavol\", \"id\": 28946670, \"avatar_url\": \"s2.githubusercontent.com\" }, \"state\": \"open\", \"body\": \"We found an issue in the way `cancel()` is called on the `Call` after `onResponse()` is called on the callback:\\r\\n\\r\\nEven after `onResponse` was called on our callback on a different thread,` cancel()` is still called from the main thread due to its concurrency nature - therefore `cancel()` calls `cancel()` on the `RetryAndFollowUpInterceptor` which calls `cancel()` on the `StreamAllocation` which we believe gets us in a state where we have a successful response with no body - `response.body().string()` returns null.\\r\\n\\r\\nWe believe that a fix for this might be to do a `return` in the `cancel()` method on the `RealCall` class if the `AsyncCall` delivered response to the callback.\"}]".data(using: .utf8)!
        default:
            return "\"url\": \"https://api.github.com/repos/sauravexodus/ZoZo/issues/comments/306031551\",\r\n  \"html_url\": \"https://github.com/sauravexodus/ZoZo/issues/1#issuecomment-306031551\",\r\n  \"issue_url\": \"https://api.github.com/repos/sauravexodus/ZoZo/issues/1\",\r\n  \"id\": 306031551,\r\n  \"user\": {\r\n    \"login\": \"sauravexodus\",\r\n    \"id\": 7869346,\r\n    \"avatar_url\": \"https://avatars1.githubusercontent.com/u/7869346?v=3\",\r\n    \"gravatar_id\": \"\",\r\n    \"url\": \"https://api.github.com/users/sauravexodus\",\r\n    \"html_url\": \"https://github.com/sauravexodus\",\r\n    \"followers_url\": \"https://api.github.com/users/sauravexodus/followers\",\r\n    \"following_url\": \"https://api.github.com/users/sauravexodus/following{/other_user}\",\r\n    \"gists_url\": \"https://api.github.com/users/sauravexodus/gists{/gist_id}\",\r\n    \"starred_url\": \"https://api.github.com/users/sauravexodus/starred{/owner}{/repo}\",\r\n    \"subscriptions_url\": \"https://api.github.com/users/sauravexodus/subscriptions\",\r\n    \"organizations_url\": \"https://api.github.com/users/sauravexodus/orgs\",\r\n    \"repos_url\": \"https://api.github.com/users/sauravexodus/repos\",\r\n    \"events_url\": \"https://api.github.com/users/sauravexodus/events{/privacy}\",\r\n    \"received_events_url\": \"https://api.github.com/users/sauravexodus/received_events\",\r\n    \"type\": \"User\",\r\n    \"site_admin\": false\r\n  },\r\n  \"created_at\": \"2017-06-04T10:25:23Z\",\r\n  \"updated_at\": \"2017-06-04T10:25:23Z\",\r\n  \"body\": \"Comment 3\"".data(using: .utf8)!
            
        }
    }
    var task: Task {
        return .request
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

