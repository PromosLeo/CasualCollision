//
//  Notification+Name.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 03.02.21.
//

import Foundation

public extension Notification {
    static let requestDidFinish: Name = Notification.Name("requestDidFinish")
    static let requestDidError: Name = Notification.Name("requestDidError")
    
    static let employeesDidUpdate: Name = Notification.Name("employeesDidUpdate")
    // the completed notification should be send, if we got all data of emploees (Common Notice: Request with paging are normally.)
    static let employeesDidCompleted: Name = Notification.Name("employeesDidCompleted")
}
