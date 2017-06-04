//
//  HomeViewController.swift
//  ZoZo
//
//  Created by Saurav Chandra on 25/05/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tvTableView: UITableView!
    @IBOutlet var tfSearchTextField: UITextField!
    @IBOutlet var vErrorView: UIView!
    
    let disposeBag = DisposeBag()
    var issueProvider : RxMoyaProvider<Github>!
    var searchQuery : Observable<String> {
        return tfSearchTextField.rx.text.orEmpty.debounce(0.5, scheduler: MainScheduler.instance).distinctUntilChanged()
    }
    var githubIssuesFetcher : IssueFetcher!
    var issues = Array<GithubIssue>()

    //MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvTableView.estimatedRowHeight = 100
        self.tvTableView.rowHeight = UITableViewAutomaticDimension
        self.setupRx()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDetails"){
            let issueDetailsViewController = segue.destination as! IssueDetailViewController
            issueDetailsViewController.githubIssue = sender as! GithubIssue
            issueDetailsViewController.repoName = self.tfSearchTextField.text
        }
    }
    
    //MARK:- Instance methods
    
    func setupRx(){
        self.issueProvider = RxMoyaProvider<Github>()
        
        self.githubIssuesFetcher = IssueFetcher(provider: self.issueProvider, pathName: self.searchQuery)
        
        self.githubIssuesFetcher.fetchIssues().do(onNext: { (issues) in
            if(issues.count == 0){
                self.vErrorView.isHidden = false
            }else{
                self.vErrorView.isHidden = true
            }
            self.issues = issues
        }, onError: { (error) in
            self.vErrorView.isHidden = false
        }, onCompleted: {

        }, onSubscribe: {
            
        }, onSubscribed: { 

        }, onDispose: {
            
        }).bind(to: self.tvTableView.rx.items){ tableView, row, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "GithubIssueTableViewCell") as! GithubIssueTableViewCell
            cell.configure(with: item)
            return cell
        }.addDisposableTo(self.disposeBag)
        
        self.tvTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            if(self.tfSearchTextField.isFirstResponder){
                self.view.endEditing(true)
            }
        }).addDisposableTo(self.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = self.issues[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: issue)
    }

}
