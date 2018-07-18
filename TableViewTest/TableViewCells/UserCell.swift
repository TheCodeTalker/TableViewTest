//
//  UserCell.swift
//  TableViewTest
//
//  Created by Chitaranjan sahu on 17/07/18.
//  Copyright © 2018 Chitaranjan sahu. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    static let defaultAvatar =  UIImage(named: "avatar")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setOpaqueBackground()
        avatar.setRoundImage(UserCell.defaultAvatar)
    }
    func configure(_ viewModel:UserViewModel)  {
        username.text = viewModel.userName
        role.text  = viewModel.roleText
        isUserInteractionEnabled = false
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.setRoundImage(UserCell.defaultAvatar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
private extension UserCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground
    func setOpaqueBackground()
    {
        alpha = 1.0
        backgroundColor = UserCell.defaultBackgroundColor
        avatar.alpha = 1.0
        avatar.backgroundColor = UserCell.defaultBackgroundColor
    }
}
