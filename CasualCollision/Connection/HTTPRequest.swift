//
//  HTTPRequest.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 01.02.21.
//

import Foundation

class HttPReuest {
    
    var endPoint: String! {
        didSet {
            url = URL(string: baseUrl + endPoint)
        }
    } // override in Subclass
    
    fileprivate (set) var json: String?
    fileprivate (set) var error: Error?
    fileprivate (set) var data: Data?
    
    fileprivate (set) var baseUrl = "https://jsonplaceholder.typicode.com/"
    var url: URL!
    
    init() {
        fatalError("init() has not been implemented")
    }
    
    init(endpoint: String) {
        url = URL(string: baseUrl + endpoint)
    }
    
    func send() {
        let urlSession = URLSession(configuration: .default).dataTask(with: self.url) { (data, response, error) in
            
            guard let _ = data else {
                NotificationCenter.default.post(name: Notification.requestDidFinish, object: self)
                return
            }
            self.data = data
            self.error = error
            
            NotificationCenter.default.post(name: Notification.requestDidFinish, object: self)
        }.resume()
    }
}

class EmployeesRequest: HttPReuest {
    internal override var endPoint: String! {
        didSet {
            super.endPoint = endPoint
        }
    }
    
    override init() {
        super.init(endpoint: "users")
    }
}

