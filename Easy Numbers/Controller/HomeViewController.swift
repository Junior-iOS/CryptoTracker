//
//  HomeViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var btnMyGames: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Meus jogos", for: .normal)
        button.addTarget(self, action: #selector(myGamesPressed), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let homeView = HomeView()
    private var viewModel = HomeViewModel()
    
    private let device = UIDevice.current.userInterfaceIdiom
    private let screenWidth = UIScreen.main.bounds.width
    
    private var myGames: [Int] = []
    
    // MARK: - Init & Life Cycle
    init(viewModel: HomeViewModel = HomeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        btnMyGames.isHidden = UserDefaults.standard.bool(forKey: "hasSavedGames") ? false : true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setup()
        NJAnalytics.shared.trackEvent(name: .didLoad)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientColor()
    }

    // MARK: - Methods
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .done, target: self, action: #selector(didPressInfo))
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = Bundle.main.appName
        homeView.delegate = self
        
        addComponents()
    }
    
    private func addComponents() {
        view.addSubviews(homeView, btnMyGames)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        let homeWidth = device == .phone ? screenWidth - 40 : screenWidth / 2
        
        NSLayoutConstraint.activate([
            homeView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            homeView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            homeView.widthAnchor.constraint(equalToConstant: homeWidth),
            
            btnMyGames.centerXAnchor.constraint(equalTo: homeView.centerXAnchor),
            btnMyGames.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            btnMyGames.widthAnchor.constraint(equalTo: homeView.widthAnchor),
            btnMyGames.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func myGamesPressed(_ sender: UIButton) {
//        let vc = SavedGamesViewController()
//
//        if loadedGames != nil && loadedIcons != nil {
//            guard let loadedGames = loadedGames, let loadedIcons = loadedIcons else { return }
//            vc.game = Game(icons: loadedIcons, loadedGames: loadedGames)
//        }
        viewModel.didPressMySavedGames()
        NJAnalytics.shared.trackEvent(name: .didSave)
    }
    
    @objc func didPressInfo() {
        viewModel.didPressInfo()
        NJAnalytics.shared.trackEvent(name: .info)
    }
}

// MARK: - HomeView Delegate
extension HomeViewController: HomeViewDelegate {
    func didPressGenerateButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            myGames = viewModel.generate(game: .megasena)
            NJAnalytics.shared.trackEvent(name: .megasena)
        case 1:
            myGames = viewModel.generate(game: .lotofacil)
            NJAnalytics.shared.trackEvent(name: .lotofacil)
        case 2:
            myGames = viewModel.generate(game: .quina)
            NJAnalytics.shared.trackEvent(name: .quina)
        case 3:
            myGames = viewModel.generate(game: .lotomania)
            NJAnalytics.shared.trackEvent(name: .lotomania)
        default: break
        }
        
        print(myGames)
    }
}
