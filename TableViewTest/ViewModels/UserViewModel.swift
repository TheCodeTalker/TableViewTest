//
//  UserViewModel.swift
//  TableViewTest
//
//  Created by Chitaranjan sahu on 17/07/18.
//  Copyright © 2018 Chitaranjan sahu. All rights reserved.
//

import Foundation
class UserViewModel {
    let avatarUrl : String
    let userName : String
    let role : Role
    let roleText : String
    
    init(user:User) {
        avatarUrl = user.avatarUrl
        userName = user.username
        role = user.role
        roleText = user.role.rawValue
    }
    
}
