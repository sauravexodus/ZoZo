//
//  IssueFetcher.swift
//  ZoZo
//
//  Created by Saurav Chandra on 25/05/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import Foundation
import Moya
import Mapper
import RxSwift
import Moya_ModelMapper
import RxOptional
import SwiftString3

struct IssueFetcher {
    let provider: RxMoyaProvider<Github>
    let pathName: Observable<String>
    
    func fetchIssues() -> Observable<[GithubIssue]>{
        return pathName.observeOn(MainScheduler.instance).flatMapLatest { path -> Observable<[GithubIssue]> in
            if(path.length > 3 && path.contains("/")){
                return self.provider.request(Github.issues(repositoryFullName: path)).filterSuccessfulStatusCodes().debug().mapArray(type: GithubIssue.self).catchError({ (error) -> Observable<[GithubIssue]> in
                    return Observable.just([])
                })
            }else{
                return Observable.just([])
            }
        }
    }
    
    
}
