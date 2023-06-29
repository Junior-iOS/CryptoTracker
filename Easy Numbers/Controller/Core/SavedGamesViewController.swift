//
//  SavedGamesViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 22/05/23.
//

import UIKit

class SavedGamesViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: SavedGamesViewModel
    private let savedGamesView = SavedGamesView()
    var savedGames: [String] = []

    override func loadView() {
        super.loadView()
        self.view = savedGamesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavButtons()
        tableViewSetup()
    }

    init(viewModel: SavedGamesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func tableViewSetup() {
        savedGamesView.tableView.delegate = self
        savedGamesView.tableView.dataSource = self
    }

    private func setupNavButtons() {
        title = Bundle.main.savedGamestitle

        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(deleteGames))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(share))

        navigationItem.rightBarButtonItems = [deleteButton, shareButton]
    }

    @objc private func deleteGames() {
        let alert = UIAlertController(title: "Atenção", message: "Deseja apagar todos seus jogos salvos?", preferredStyle: .alert)
        let no = UIAlertAction(title: "Não", style: .default)
        let yes = UIAlertAction(title: "Sim", style: .destructive) { [weak self] _ in
            self?.delete()
            self?.navigationController?.popToRootViewController(animated: true)
        }

        alert.addAction(no)
        alert.addAction(yes)
        present(alert, animated: true)
    }

    private func delete() {
        savedGames.removeAll()
        UserDefaults.standard.set(savedGames, forKey: "SavedGames")

        savedGamesView.tableView.reloadData()
    }

    @objc func share() {
        var text = ""

        for i in 0...savedGames.count - 1 {
            viewModel.setGameName(savedGames[i]) { [weak self] gameName in
                guard let self else { return }
                text += "🍀 \(gameName) 🤞🏻\n\(savedGames[i])\n\n"
            }
        }

        let ac = UIActivityViewController(activityItems: [text.removeBrackets()], applicationActivities: nil)

        if UIDevice.current.userInterfaceIdiom == .pad {
            let scenes = UIApplication.shared.connectedScenes
            
            guard let windowScene = scenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            ac.popoverPresentationController?.sourceView = window
            ac.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 350)
            window.rootViewController?.present(ac, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                self.present(ac, animated: true)
            }
        }

        NJAnalytics.shared.trackEvent(name: .didShare)
    }
}

// MARK: - UITableView Delegate and Datasource
extension SavedGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedGames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(of: SavedGamesTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self else { return }
            let savedGame = savedGames[indexPath.row]
            cell.configure(savedGame)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let erase = UIContextualAction(style: .normal, title: "🚮") { [weak self] _, _, _ in
            guard let self else { return }

            savedGames.remove(at: indexPath.row)
            UserDefaults.standard.set(savedGames, forKey: "SavedGames")

            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()

            if savedGames.count == 0 {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }

        let share = UIContextualAction(style: .normal, title: "↗️") { [weak self] _, _, _ in
            guard let self else { return }
            var text = ""
            let selectedGame = savedGames[indexPath.row]

            viewModel.setGameName(selectedGame) { gameName in
                text += "🍀 \(gameName) 🤞🏻\n\(selectedGame)\n\n"
            }

            let ac = UIActivityViewController(activityItems: [text.removeBrackets()], applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                let scenes = UIApplication.shared.connectedScenes
                
                guard let windowScene = scenes.first as? UIWindowScene,
                      let window = windowScene.windows.first else { return }
                
                ac.popoverPresentationController?.sourceView = window
                ac.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 350)
                window.rootViewController?.present(ac, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.present(ac, animated: true)
                }
            }

            NJAnalytics.shared.trackEvent(name: .didShare)
        }

        erase.backgroundColor = .njErase
        share.backgroundColor = .njShare

        return UISwipeActionsConfiguration(actions: [erase, share])
    }
}
