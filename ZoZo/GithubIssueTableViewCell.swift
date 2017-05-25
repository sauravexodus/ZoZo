//
//  GithubIssueTableViewCell.swift
//  ZoZo
//
//  Created by Saurav Chandra on 25/05/17.
//  Copyright © 2017 Dogether. All rights reserved.
//

import UIKit
import Kingfisher

class GithubIssueTableViewCell: UITableViewCell {
    
    @IBOutlet var ivProfileImageView: UIImageView!
    @IBOutlet var lUsernameLabel: UILabel!
    @IBOutlet var lTitleLabel: UILabel!
    @IBOutlet var lDescriptionLabel: UILabel!
    @IBOutlet var lIssueTagLabel: UILabel!
    
    //MARK:- Instance methods
    
    func configure(with issue: GithubIssue){
        self.lTitleLabel.text = issue.title
        self.lUsernameLabel.text = issue.user.username
        self.lDescriptionLabel.text = issue.body
        self.lIssueTagLabel.text = issue.state?.uppercased()
        if(issue.user.avatar != nil){
            self.ivProfileImageView.kf.setImage(with: URL(string: issue.user.avatar!))
        }
    }
    

}
