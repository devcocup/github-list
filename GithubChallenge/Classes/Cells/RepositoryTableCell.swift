//
//  RepositoryTableCell.swift
//  GithubChallenge
//
//  Created by devcocup on 12/29/20.
//

import UIKit
import AlamofireImage

class RepositoryTableCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    public var repository: Repository? {
        didSet {
            if let repository = repository {
                nameLabel.text = repository.name
                if let owner = repository.owner {
                    avatarImageView.af.setImage(withURL: URL(string: owner.avatar!)!)
                    usernameLabel.text = owner.username
                } else {
                    avatarImageView.image = UIImage(systemName: "photo")
                    usernameLabel.text = ""
                }
                descriptionLabel.text = repository.desc
                starsLabel.text = "\(repository.stars.formatUsingAbbrevation())"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
