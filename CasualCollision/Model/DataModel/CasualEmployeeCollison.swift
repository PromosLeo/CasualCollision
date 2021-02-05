//
//  CasualEmployeeCollison.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 05.02.21.
//

import Foundation

class CasualEmployeeCollison {
    private var employess = Employees()
    private (set) var result: [Int: [(Employee, Employee)]]?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(excecute(notification:)), name: Notification.employeesDidCompleted, object: nil)
    }
    
    @objc
    private func excecute(notification: Notification) {
        if employess === notification.object as? Employees {
            result = employess.list?.uniquePairs(type: Employee.self)
        }
    }
}
