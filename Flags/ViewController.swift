//
//  ViewController.swift
//  Flags
//
//  Created by admin on 18/07/21.
//

import UIKit

class ViewController: UIViewController, StoryBoardInitiable {
    static var storyBoardName: EXStorBoardName { .default }
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Flags"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequedCell(type: UITableViewCell.self)
        cell.textLabel?.text = "Hello"
        return cell
    }
}
