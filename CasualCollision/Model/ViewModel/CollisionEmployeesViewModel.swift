//
//  CollisionEmployeesViewModel.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 05.02.21.
//

import Foundation

protocol CollisionEmployeesViewModelDelegate: class {
    func willUpdate()
}

typealias CollisonPairs = (frontEmployee: Employee, backEmployee: Employee)

class CollisionEmployeesViewModel {
    let collision = CollisionEmployees()
    var startDate: Date
    
    weak var delegate: CollisionEmployeesViewModelDelegate? = nil
    
    private (set) var listContent: [CollisionViewModel]?
    
    init(startDate: Date? = nil) {
        self.startDate = Date()
        if let date = startDate {
            self.startDate = date
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdate(notification:)), name: Notification.collisionDidCompleted, object: nil)
    }
    
    @objc
    private func didUpdate(notification: Notification) {
        if collision === notification.object as? CollisionEmployees {
            listContent = [CollisionViewModel]()
            if let result = collision.result {
                for (key, collisions) in result {
                    for collision in collisions {
                        let pair = CollisionViewModel(collision, dayId: key, date: startDate)
                        listContent?.append(pair)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.delegate?.willUpdate()
        }
    }
}

struct CollisionViewModel {
    private (set) var pair: CollisonPairs
    private (set) var dayId: Int
    private (set) var date: Date
    init(_ pair: CollisonPairs, dayId: Int, date: Date) {
        self.pair = pair
        self.dayId = dayId
        self.date = date
    }
}
