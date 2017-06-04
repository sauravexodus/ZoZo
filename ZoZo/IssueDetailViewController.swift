//
//  IssueDetailViewController.swift
//  ZoZo
//
//  Created by Saurav Chandra on 04/06/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class IssueDetailViewController: UIViewController {
    
    var githubIssue : GithubIssue!

    @IBOutlet var issueTitle: UILabel!
    @IBOutlet var navbarTitle: UILabel!
    @IBOutlet var issueDescription: UILabel!
    @IBOutlet var tfTextField: UITextField!
    
    var provider : RxMoyaProvider<Github>!
    var repoName : String!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let endpointClosure = { (target: Github) -> Endpoint<Github> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": "token 1e743ba8db886c0a357c96650351cffd25e11ef3"])
        }

        self.provider = RxMoyaProvider<Github>(endpointClosure: endpointClosure)
        
        self.setupViews()
    }

    @IBAction func bActionClose(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews(){
        self.issueTitle.text = self.githubIssue.title
        self.navbarTitle.text = self.githubIssue.title
        self.issueDescription.text = self.githubIssue.body
    }
    
    
    @IBAction func bActionSendComment(_ sender: Any) {
        
        let parameters :[String: Any] = ["body" : self.tfTextField.text!]
        let endpointClosure = { (target: Github) -> Endpoint<Github> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": "token 1e743ba8db886c0a357c96650351cffd25e11ef3"]).adding(newParameters: parameters)
        }
        
        self.provider = RxMoyaProvider<Github>(endpointClosure: endpointClosure)
        
        
        let request = Github.postComment(repositoryFullName: repoName, issueId: self.githubIssue.issueNumber)
        self.provider.request(request).do(onNext: { (reponse) in
            
        }, onError: { (error) in
            
        }, onCompleted: { 
            self.tfTextField.text = nil
        }, onSubscribe: { 
            
        }, onSubscribed: { 
            
        }, onDispose: {
            
        }).subscribe().addDisposableTo(self.disposeBag)
    }
    

}
