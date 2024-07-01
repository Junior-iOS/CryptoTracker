//
//  GameViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 16/05/23.
//

import UIKit

class GameViewController: BaseViewController {
    // MARK: - Properties
    private lazy var gameView = GameView(frame: .zero)

    var viewModel: GameViewModel
    private let homeViewModel = HomeViewModel()
    weak var coordinator: MainCoordinator?

    private let device = UIDevice.current.userInterfaceIdiom

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.savedGames = GameManager.shared.retrieveGames()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "Jogos Lotérica"
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
    }

    // MARK: - Init
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Private methods
    private func setup() {
        navigationItem.title = viewModel.gameTitle
        view.backgroundColor = .systemBackground

        gameView.delegate = self
        gameView.collectionView.delegate = self
        gameView.collectionView.dataSource = self

        viewModel.delegate = self
        viewModel.isSavedButtonHidden()

        setRightBarButton()
        setSaveGameButtonColor()
        checkAlignment(viewModel.gameTitle)
    }

    private func generateGame(_ type: GameType) {
        self.viewModel.game = homeViewModel.generate(type)
    }

    private func setRightBarButton() {
        let saveButton = UIBarButtonItem(title: viewModel.saveGameTitle, style: .plain, target: self, action: #selector(saveGame))
        navigationItem.rightBarButtonItems = [saveButton]
    }

    @objc private func saveGame() {
        guard let results = viewModel.game else { return }

        var number = ""
        results.forEach({ number += $0 < 10 ? "0\($0) " : "\($0) " })

        self.viewModel.savedGames?.append(number)
        self.viewModel.savedGames?.removeDuplicates()
        self.viewModel.savedGames = viewModel.savedGames?.sorted(by: { $0 < $1 }).map({ $0 })

        GameManager.shared.saveGames(viewModel.savedGames ?? [])
        viewModel.isSavedButtonHidden()

        SnackBar.showHUD(in: self.view, type: .save)
        haptic(.heavy)
    }

    private func setSaveGameButtonColor() {
        switch viewModel.game?.count {
        case 5: gameView.savedGamesButton.backgroundColor = NJColor.quina
        case 6: gameView.savedGamesButton.backgroundColor = NJColor.megasena
        case 10: gameView.savedGamesButton.backgroundColor = NJColor.timemania
                 gameView.savedGamesButton.setTitleColor(NJColor.megasena, for: .normal)
        case 15: gameView.savedGamesButton.backgroundColor = NJColor.lotofacil
        default: gameView.savedGamesButton.backgroundColor = NJColor.lotomania
        }
    }

    private func checkAlignment(_ title: String) {
        if (title == "Quina" || title == "Megasena") && device == .pad {
            guard let game = viewModel.game else { return }

            var number = ""
            game.forEach({ number += $0 < 10 ? "0\($0)   " : "\($0)   " })

            gameView.gameLabel.text = number
            gameView.collectionView.isHidden = true
        } else {
            gameView.gameLabel.isHidden = true
        }
    }
}

// MARK: - CollectionView Delegate and DataSource
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didPressCopyGame()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: GameViewCell.identifier,
                                                             for: indexPath) as? GameViewCell else { return UICollectionViewCell() }
        let numbers = viewModel.game
        cell.configure(number: numbers?[indexPath.row] ?? 0)
        return cell
    }
}

// MARK: - GameView Delegate
extension GameViewController: GameViewDelegate {
    func didPressGenerateGameAgain() {
        let game = viewModel.game
        guard let game else { return }

        switch game.count {
        case 5: generateGame(.quina)
        case 6: generateGame(.megasena)
        case 10: generateGame(.timemania)
        case 15: generateGame(.lotofacil)
        case 50: generateGame(.lotomania)
        default: break
        }

        checkAlignment(viewModel.gameTitle)
        haptic(.soft)
    }

    func didPressGoToSavedGames(_ savedGames: [String]) {
        guard let coordinator else { return }
        coordinator.routeToSavedGames(with: savedGames)
    }

    // MARK: - For iPad
    func didTapCopyGame() {
        viewModel.didPressCopyGame()
    }
}

// MARK: - GameViewModel Delegate
extension GameViewController: GameViewModelDelegate {
    func hideSavedGamesButton(_ game: [String]) {
        gameView.savedGamesButton.isHidden = game == [] ? true : false
    }

    func didPressCopyGame() {
        guard let result = viewModel.game else { return }

        var number = ""
        result.forEach({ number += $0 < 10 ? "0\($0) " : "\($0) " })

        let pasteboard = UIPasteboard.general
        pasteboard.string = "🍀 \(String(describing: viewModel.gameTitle)) 🤞🏻\n\(number)".removeBrackets()

        SnackBar.showHUD(in: self.view, type: .copy)
        haptic(.medium)
    }

    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.gameView.collectionView.reloadData()
        }
    }
}
