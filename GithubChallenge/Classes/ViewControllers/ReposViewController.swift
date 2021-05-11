//
//  ReposViewController.swift
//  GithubChallenge
//
//  Created by devcocup on 12/29/20.
//

import UIKit
import Refreshable

class ReposViewController: UIViewController {

    @IBOutlet weak var reposTableView: UITableView!
    
    fileprivate var page = 0
    fileprivate var repositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Trending Repos"
        
        loadRepository(page)
        
        reposTableView.addPullToRefresh {
            self.page = 0
            self.loadRepository(self.page)
        }
        
        reposTableView.addLoadMore {
            self.page += 1
            self.loadRepository(self.page)
        }
    }

    fileprivate func loadRepository(_ page: Int) {
        GithubAPIManager.shared.loadRepositories(page) { (repositories, totalCount, error) in
            DispatchQueue.main.async {
                self.reposTableView.stopPullToRefresh()
                self.reposTableView.stopLoadMore()
                if page == 0 {
                    self.repositories.removeAll()
                }
                if let repos = repositories {
                    self.repositories.append(contentsOf: repos)
                    self.reposTableView.reloadData()
                } else  {
                    self.showErrorMessage(error)
                }
            }
        }
    }
    
    fileprivate func showErrorMessage(_ error: Error?) {
        var message = "There are some errors. Please try again!"
        if let error = error {
            message = error.localizedDescription
        }
        
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            
        }
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
    }
}

extension ReposViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableCell", for: indexPath) as! RepositoryTableCell
        cell.repository = repositories[indexPath.row]
        return cell
    }
}
