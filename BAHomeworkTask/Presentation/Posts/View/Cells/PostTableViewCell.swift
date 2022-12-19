//
//  PostTableViewCell.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 19.12.22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = String(describing: PostTableViewCell.self)
    
    func update(with viewModel: PostViewModel) {
        nameLabel.text = viewModel.name
        titleLabel.text = viewModel.postTitle
    }
    
}
