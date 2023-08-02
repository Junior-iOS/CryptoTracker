//
//  CheckFaceIDViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 01/08/23.
//

import UIKit

class CheckFaceIDViewController: UIViewController {
    private let faceIdView = CheckFaceIDView()
    private weak var coordinator: MainCoordinator?
    
    override func loadView() {
        super.loadView()
        self.view = faceIdView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(_ coordinator: MainCoordinator? = MainCoordinator()) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        hideNavigationBar(true)
        faceIdView.delegate = self
    }
}

extension CheckFaceIDViewController: CheckFaceIDViewDelegate {
    func didTapFaceID() {
        guard let coordinator = coordinator else { return }
        checkforFaceID(coordinator)
    }
}
