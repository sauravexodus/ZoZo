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

class HomeViewController: UIViewController {
    
    @IBOutlet var tvTableView: UITableView!
    @IBOutlet var tfSearchTextField: UITextField!
    
    let disposeBag = DisposeBag()
    var issueProvider : RxMoyaProvider<Github>!
    var searchQuery : Observable<String> {
        return tfSearchTextField.rx.text.orEmpty.debounce(0.5, scheduler: MainScheduler.instance).distinctUntilChanged()
    }
    var githubIssuesFetcher : IssueFetcher!

    //MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupRx()
    }
    
    //MARK:- Instance methods
    
    func setupRx(){
        self.issueProvider = RxMoyaProvider<Github>()
        
        self.githubIssuesFetcher = IssueFetcher(provider: self.issueProvider, pathName: self.searchQuery)
        
        self.githubIssuesFetcher.fetchIssues().bind(to: self.tvTableView.rx.items){ tableView, row, item in
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

}
