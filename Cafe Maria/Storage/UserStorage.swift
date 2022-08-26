//
//  UserStorage.swift
//  Cafe Maria
//
//  Created by Volodymyr Khvaliuk on 18.07.2022.
//

import UIKit

protocol UserStorageProtocol{
    func load() -> [UserProtocol]
    func save(users: [UserProtocol])
}


class UserStorage: UserStorageProtocol {
    // Ссылка на хранилище
    private var storage = UserDefaults.standard
    // Ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "users"
    // Перечисление с ключами для записи в User Defaults
    private enum UserKey: String {
        case name
        case email
        case password
    }
    
    func load() -> [UserProtocol] {
        var resultUsers: [UserProtocol] = []
        let usersFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for user in usersFromStorage {
            guard let name = user[UserKey.name.rawValue],
                  let email = user[UserKey.email.rawValue],
                  let password = user[UserKey.password.rawValue] else {
                      continue
                  }
            resultUsers.append(User(name: name, email: email, password: password))
        }
        return resultUsers
    }
    
    func save(users: [UserProtocol]) {
        var arrayForStorage: [[String:String]] = []
        users.forEach { user in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[UserKey.name.rawValue] = user.name
            newElementForStorage[UserKey.email.rawValue] = user.email
            newElementForStorage[UserKey.password.rawValue] = user.password
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
