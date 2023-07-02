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
    
    let viewModel: GameViewModel
    private let homeViewModel = HomeViewModel()
    
    weak var coordinator: MainCoordinator?

    var gameTitle: String?
    var savedGames = [String]()

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
        savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames") ?? []
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
        navigationItem.title = gameTitle
        view.backgroundColor = .systemBackground

        gameView.delegate = self
        gameView.collectionView.delegate = self
        gameView.collectionView.dataSource = self
        
        viewModel.delegate = self
        viewModel.isSavedButtonHidden()

        setRightBarButton()
        setSaveGameButtonColor()
    }

    private func generateGame(_ type: GameType) {
        self.viewModel.game = homeViewModel.generate(type)
    }

    private func setRightBarButton() {
        let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveGame))
        navigationItem.rightBarButtonItems = [saveButton]
    }

    @objc private func saveGame() {
        guard let results = viewModel.game else { return }
        
        var number = ""
        results.forEach({ number += $0 < 10 ? "0\($0) " : "\($0) " })
        
        self.savedGames.append(number)
        self.savedGames.removeDuplicates()

        UserDefaults.standard.set(savedGames, forKey: "SavedGames")
        viewModel.isSavedButtonHidden()

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
}

// MARK: - CollectionView Delegate and DataSource
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didPressCopyGame()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
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
    }

    func didPressSavedGames(_ savedGames: [String]) {
        coordinator?.routeToSavedGames(with: savedGames)
    }
}

// MARK: - GameViewModel Delegate
extension GameViewController: GameViewModelDelegate {
    func hideSavedGamesButton(_ game: [String]) {
        gameView.savedGamesButton.isHidden = game == [] ? true : false
    }
    
    func didPressCopyGame() {
        guard let result = viewModel.game, let title = gameTitle else { return }

        let pasteboard = UIPasteboard.general
        pasteboard.string = "🍀 \(String(describing: title)) 🤞🏻\n\(result)".removeBrackets()

        haptic(.medium)
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.gameView.collectionView.reloadData()
        }
    }
}
