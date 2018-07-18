//
//  UserViewModelController.swift
//  TableViewTest
//
//  Created by Chitaranjan sahu on 17/07/18.
//  Copyright © 2018 Chitaranjan sahu. All rights reserved.
//

import Foundation
typealias RetrieveUsersCompletionBlock = (_ success:Bool,_ error:NSError?)->Void
class UserViewModelController {
    private static let pageSize = 25
    
    
    private var userViewModel : [UserViewModel?] = []
    private var currentPage = -1
    private var lastPage = -1
    private var retrieveUsersCompletionBlock : RetrieveUsersCompletionBlock?
    
    func retrieveUsers(_ complitationBlock: @escaping RetrieveUsersCompletionBlock) {
        retrieveUsersCompletionBlock = complitationBlock
        loadNextPageIfNeeded(for: 0)
    }
    
    var viewModelCount:Int{
        return userViewModel.count
    }
    
    func viewModel(at index:Int) -> UserViewModel? {
        guard index >= 0 && index < viewModelCount else {
            return nil
        }
        loadNextPageIfNeeded(for: index)
        return userViewModel[index]
    }
    
}
private extension UserViewModelController{
    static func parse(_ jsonData: Data)->[User?]?
    {
        print(jsonData)
        do {
            return try JSONDecoder().decode([User].self, from: jsonData)
        } catch {
            print("error")
            return nil
        }
    }
    static func initViewModels(_ users: [User?]) -> [UserViewModel?] {
        return users.map({ user in
            if let user = user {
                return UserViewModel(user: user)
            } else {
                return nil
            }
            
        })
    }
    func loadNextPageIfNeeded(for index:Int) {
        let targetCount = currentPage < 0 ? 0 : (currentPage + 1) * UserViewModelController.pageSize - 1
        guard index == targetCount else {
            return
        }
        currentPage += 1
        let id = currentPage * UserViewModelController.pageSize + 1
        let urlString = String(format: "https://aqueous-temple-22443.herokuapp.com/users?id=\(id)&count=\(UserViewModelController.pageSize)")
        guard let url = URL(string: urlString) else {
            retrieveUsersCompletionBlock?(false, nil)
            return
        }
        
         URLSession.shared.dataTask(with: url) { [weak self]  (data, responce, error) in
            guard let strongSelf = self else { return }
            guard let jsonData = data, error == nil else {
                DispatchQueue.main.async {
                    strongSelf.retrieveUsersCompletionBlock?(false, error as NSError?)
                }
                return
            }
            strongSelf.lastPage += 1
            if let users = UserViewModelController.parse(jsonData) {
                let newUsersPage = UserViewModelController.initViewModels(users)
                strongSelf.userViewModel.append(contentsOf: newUsersPage)
                DispatchQueue.main.async {
                    strongSelf.retrieveUsersCompletionBlock?(true, nil)
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.retrieveUsersCompletionBlock?(false, NSError(domain: "JSON parsing error", code: 0, userInfo: nil))
                }
            }
        }.resume()
        
        
    }
}
