//
//  EmployeesViewModel.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 05.02.21.
//

import Foundation

class EmployeesViewModel {
    let employees: Employees = Employees()
    
    private (set) var listContent: [EmployeeViewModel] = [EmployeeViewModel]()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdate(notification:)), name: Notification.employeesDidUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func didUpdate(notification: Notification) {
        if employees === notification.object as? Employees {
            if let list = employees.lastAppendData {
                for employee in list {
                    listContent.append(EmployeeViewModel(employee))
                }
            }
        }
    }
}

struct EmployeeViewModel {
    private var employee: Employee!
    
    init(_ employee: Employee) {
        self.employee = employee
    }
    
    var id: Int {
        return employee.id
    }
    
    var email: String! {
        return employee.email
    }
    
    var name: String! {
        guard let name = employee.name else {
            return email
        }
        return name
    }
    
    var firstName: String {
        let array = name.split{$0 == " "}.map(String.init)
        return array.first!
    }
    
    var lastName: String {
        let array = name.split{$0 == " "}.map(String.init)
        return array.last!
        
    }
}
