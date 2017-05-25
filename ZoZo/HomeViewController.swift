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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tvTableView: UITableView!
    @IBOutlet var tfSearchTextField: UITextField!
    
    let disposeBag = DisposeBag()
    var issueProvider : RxMoyaProvider<Github>!
    var searchQuery : Observable<String> {
        return tfSearchTextField.rx.text.orEmpty.debounce(0.5, scheduler: MainScheduler.instance).distinctUntilChanged()
    }

    //MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK:- Instance methods
    
    func setupRx(){
        self.issueProvider = RxMoyaProvider<Github>()
        
        self.tvTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            if(self.tfSearchTextField.isFirstResponder){
                self.view.endEditing(true)
            }
        }).addDisposableTo(self.disposeBag)
    }
    
    //MARK:- Table view data sources and delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GithubIssueTableViewCell", for: indexPath) as! GithubIssueTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //MARK:- UITextfield actions
    
    @IBAction func tfActionSearchChanged(_ sender: Any) {
        
    }

}
