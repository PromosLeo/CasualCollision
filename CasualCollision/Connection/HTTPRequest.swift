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
    
    var baseUrl =  "https://jsonplaceholder.typicode.com/"
    var url: URL!
    
    init() {
        fatalError("init() has not been implemented")
    }
    
    init(endpoint: String) {
        url = URL(string: baseUrl + endpoint)
    }
    
    func send() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
            }
           }.resume()
    }
    
    
}

class EmployeeRequest: HttPReuest {
    internal override var endPoint: String! {
        didSet {
            super.endPoint = endPoint
        }
    }
    
    override init() {
        super.init(endpoint: "users")
    }
}

