//
//  CasualEmployeeCollison.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 05.02.21.
//

import Foundation

class CollisionEmployees {
    private var employess = Employees()
    private (set) var result: [Int: [(Employee, Employee)]]? {
        didSet {
            NotificationCenter.default.post(name: Notification.collisionDidCompleted, object: self)
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(excecute(notification:)), name: Notification.employeesDidCompleted, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func excecute(notification: Notification) {
        if employess === notification.object as? Employees {
            result = employess.list.uniquePairs(type: Employee.self)
        }
    }
}
