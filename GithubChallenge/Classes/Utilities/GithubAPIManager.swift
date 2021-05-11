//
//  GithubAPIManager.swift
//  GithubChallenge
//
//  Created by devcocup on 12/29/20.
//

import UIKit
import Alamofire

class GithubAPIManager: NSObject {
    
    static let shared = GithubAPIManager()
    
    public func loadRepositories(_ page: Int, completion: @escaping (_ repositories: [Repository]?, _ totalCount: Int, _ error: Error?) -> Void) {
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let dateStr = formatter.string(from: startDate)
        let url = "https://api.github.com/search/repositories?q=created:>\(dateStr)&sort=stars&order=desc&page=\(page)"
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                if let json = json as? [String : Any], let items = json["items"] as? [[String : Any]] {
                    var repositories = [Repository]()
                    let count = json["total_count"] as! Int
                    for item in items {
                        let item = Repository(json: item)
                        repositories.append(item)
                    }
                    completion(repositories, count, nil)
                } else {
                    completion(nil, 0, nil)
                }
            case .failure(let error):
                completion(nil, 0, error)
            }
        }
    }
}
