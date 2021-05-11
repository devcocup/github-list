//
//  RepoOwner.swift
//  GithubChallenge
//
//  Created by devcocup on 12/29/20.
//

import UIKit

class RepoOwner: NSObject {
    
    public var username: String? = nil
    public var avatar: String? = nil
    
    override init() {
        super.init()
    }
    
    init(json: [String : Any]) {
        self.username = json["login"] as? String
        self.avatar = json["avatar_url"] as? String
    }
}
