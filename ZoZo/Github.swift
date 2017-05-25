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
}

extension Github: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .issues(let repositoryName):
            return "/repos/\(repositoryName)/issues"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .issues(_):
            return "[{\"title\": \"Cancel concurrency issue\", \"user\": { \"login\": \"davidgyavol\", \"id\": 28946670, \"avatar_url\": \"s2.githubusercontent.com\" }, \"state\": \"open\", \"body\": \"We found an issue in the way `cancel()` is called on the `Call` after `onResponse()` is called on the callback:\\r\\n\\r\\nEven after `onResponse` was called on our callback on a different thread,` cancel()` is still called from the main thread due to its concurrency nature - therefore `cancel()` calls `cancel()` on the `RetryAndFollowUpInterceptor` which calls `cancel()` on the `StreamAllocation` which we believe gets us in a state where we have a successful response with no body - `response.body().string()` returns null.\\r\\n\\r\\nWe believe that a fix for this might be to do a `return` in the `cancel()` method on the `RealCall` class if the `AsyncCall` delivered response to the callback.\"}]".data(using: .utf8)!
        }
    }
    var task: Task {
        return .request
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

