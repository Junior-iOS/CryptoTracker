//
//  GameViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 16/05/23.
//

import UIKit

class GameViewController: BaseViewController {
    // MARK: - Properties
    private lazy var gameView = GameView(frame: .zero, game: game ?? [])
    private let viewModel = GameViewModel()
    private let homeViewModel = HomeViewModel()

    var game: [Int]?
    var gameTitle: String?
    var savedGames = [String]()

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view = gameView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames") ?? []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private methods
    private func setup() {
        navigationItem.title = gameTitle
        view.backgroundColor = .systemBackground

        gameView.delegate = self
        viewModel.delegate = self
        viewModel.isSavedButtonHidden()

        setRightBarButton()
    }

    private func generateGame(_ type: GameType) {
        self.game = homeViewModel.generate(game: type)
        guard let game else { return }
        self.gameView.setGame(game)
    }

    private func setRightBarButton() {
        let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveGame))
        navigationItem.rightBarButtonItems = [saveButton]
    }

    @objc private func saveGame() {
        guard let result = game else { return }
        self.savedGames.append("\(result)")
        self.savedGames.removeDuplicates()

        UserDefaults.standard.set(savedGames, forKey: "SavedGames")
        viewModel.isSavedButtonHidden()

//        btnCheckSavedGames.isHidden = false
//
//        if loadedGames == nil && loadedIcons == nil {
//            if let result = result {
//                savedGames.append("\(result)")
//                savedIcons.append(gameType.rawValue)
//
//                userDefaults.set(savedGames, forKey: "SavedGames")
//                userDefaults.set(savedIcons, forKey: "SavedIcons")
//            }
//        } else {
//            if let result = result {
//                loadedGames?.append("\(result)")
//                loadedIcons?.append(gameType.rawValue)
//
//                guard let loadedGames = loadedGames, let loadedIcons = loadedIcons else { return }
//                userDefaults.set(loadedGames, forKey: "SavedGames")
//                userDefaults.set(loadedIcons, forKey: "SavedIcons")
//            }
//        }
//
//        GameSnackBar.show(contextView: self, message: .save)
    }
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

// MARK: - GameView Delegate
extension GameViewController: GameViewDelegate {
    func didPressGenerateGameAgain() {
        guard let game else { return }
        switch game.count {
        case 5: generateGame(.quina)
        case 6: generateGame(.megasena)
        case 15: generateGame(.lotofacil)
        case 50: generateGame(.lotomania)
        default: break
        }
    }

    func didPressCopyGame() {
        guard let result = game, let title = gameTitle else { return }

        let pasteboard = UIPasteboard.general
        pasteboard.string = "\(String(describing: title)) 🤞🏻\n\(result)"
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: ",", with: " ")
    }
}

// MARK: - GameViewModel Delegate
extension GameViewController: GameViewModelDelegate {
    func hideSavedGamesButton(_ game: [String]) {
        gameView.savedGamesButton.isHidden = game == [] ? true : false
    }
}
