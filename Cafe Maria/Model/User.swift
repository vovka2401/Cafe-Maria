import UIKit

protocol UserProtocol{
    var name: String? { get set }
    var email: String? { get set }
    var password: String? { get set }
    func login()->Bool
    func register()->Bool
}

class User: UserProtocol{
    internal var name: String?
    internal var email: String?
    internal var password: String?
    private var userStorage: UserStorageProtocol = UserStorage()
    
    init(email: String?, password: String?){
        self.email = email
        self.password = password
    }
    
    init(name: String?, email: String?, password: String?){
        self.name = name
        self.email = email
        self.password = password
    }
    
    func login()->Bool {
        let users = userStorage.load()
        for user in users {
            if user.email == self.email && user.password == self.password {
                return true
            }
        }
        return false
    }
    
    func register()->Bool {
        if name?.replacingOccurrences(of: " ", with: "") != "" && email != "" {
            var users = userStorage.load()
            for user in users {
                if user.email == self.email {
                    return false
                }
            }
            users.append(self as UserProtocol)
            userStorage.save(users: users)
            return true
        }
        return false
    }
    
    
}
