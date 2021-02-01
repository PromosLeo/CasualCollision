//
//  ViewController.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import UIKit

class EmployeesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let result = array.collision(type: Int.self)
        print(result)
    }
}
