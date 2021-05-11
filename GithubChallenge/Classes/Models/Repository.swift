//
//  Repository.swift
//  GithubChallenge
//
//  Created by devcocup on 12/29/20.
//

import UIKit

class Repository: NSObject {

    public var id: Int = 0
    public var name: String? = nil
    public var desc: String? = nil
    public var stars: Int = 0
    public var owner: RepoOwner? = nil
    
    override init() {
        super.init()
    }
    
    init(json: [String : Any]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as? String
        self.desc = json["description"] as? String
        self.stars = json["stargazers_count"] as! Int
        if let owner = json["owner"] as? [String : Any] {
            self.owner = RepoOwner(json: owner)
        }
    }
}
