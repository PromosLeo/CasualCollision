//
//  Employee.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 01.02.21.
//

import Foundation

protocol EmployeeProtocol: Comparable {
    var id: Int { get }
}

struct Company: Decodable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Geo: Decodable  {
    let lat: String?
    let lng: String?
}

struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct test: Decodable {
    let id: Int!
}

struct Employee: Decodable, EmployeeProtocol {
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        lhs.id < rhs.id
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String?
    let username: String?
    let email: String
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}

//struct Employee: ElementProtocl {
//    var id: Int
//    let name: String
//    let username: String
//    let email: String
//}

class Element {
    var jsonDecode: JSONDecode!
    fileprivate (set) var request: HttPReuest? = nil {
        didSet {
            request?.send()
        }
    }
    internal init<T: Decodable>(type: T.Type) {
        NotificationCenter.default.addObserver(self, selector: #selector(load(notification:)), name: Notification.requestDidFinish, object: nil)
        jsonDecode = JSONDecode()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func load(notification: Notification) {
        guard let request = notification.object as? HttPReuest, self.request === request else {
            return
        }
        if let data = request.data {
            jsonDecode.data = data
        }
    }
}

class Employees: Element, JsonDecodeDelegate {
    func decoded<T>(data: [T]?) where T : Decodable {
        if let data = data as? [Employee] {
            list.append(contentsOf: data)
            lastAppendData = data
            NotificationCenter.default.post(name: Notification.employeesDidUpdate, object: self)
            // here we send the completed notification, because there are no more EmployeeRequests
            NotificationCenter.default.post(name: Notification.employeesDidCompleted, object: self)
        }
    }
    
    private (set) var lastAppendData: [Employee]?
    
    func startDecode() {
        jsonDecode.decode(type: Employee.self)
    }
    
    var list: [Employee] = [Employee]()
    
    init() {
        super.init(type: Employee.self)
        jsonDecode?.delegate = self
        self.request = EmployeesRequest()
    }
}

