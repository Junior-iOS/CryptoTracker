//
//  SavedGamesViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 22/05/23.
//

import UIKit

class SavedGamesViewController: BaseViewController {

    // MARK: - Properties
    private let savedGamesView = SavedGamesView()
    var savedGames: [String] = []
    
    override func loadView() {
        super.loadView()
        self.view = savedGamesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }
    
    private func tableViewSetup() {
        savedGamesView.tableView.delegate = self
        savedGamesView.tableView.dataSource = self
    }
}

// MARK: - UITableView Delegate and Datasource
extension SavedGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: SavedGamesTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self else { return }
            let savedGame = savedGames[indexPath.row]
            cell.configure(savedGame)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
