//
//  ViewController.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import UIKit
import Foundation

class CollisionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel: CollisionEmployeesViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CollisionEmployeesViewModel()
        // Do any additional setup after loading the view.
//        let array = [0, 1, 2, 3, 4, 5]
//        let c = array.collision(type: Int.self)
////        print(c)
//        array.uniquePairs(type: Int.self)
        
//        let result  = array.uniquePairs(type: Int.self)
//        print(result)
//        print(result?.count ?? 0)
//        NotificationCenter.default.addObserver(self, selector: #selector(test(notification:)), name: Notification.requestDidFinish, object: nil)
    }
}

extension CollisionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.listContent?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColiisionCell") as! CollisionTableViewCell
        cell.model = viewModel?.listContent?[indexPath.row]
        return cell
    }
}

extension CollisionViewController: CollisionEmployeesViewModelDelegate {
    func willUpdate() {
        tableView.reloadData()
    }
}
