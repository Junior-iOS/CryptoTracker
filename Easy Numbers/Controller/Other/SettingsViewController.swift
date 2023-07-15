//
//  SettingsViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    private let settingsView = SettingsView()
    private let viewModel: SettingsViewModel
    
    override func loadView() {
        super.loadView()
        self.view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.navTitle
        
        settingsView.tableView.delegate = self
        settingsView.tableView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: SettingsTableViewCell.self, for: indexPath, configure: { cell in
            switch indexPath.section {
            case 0:
                cell.configure(
                    text: self.viewModel.rowTitles[indexPath.section],
                    isShowingSwitchButton: .show,
                    switchTag: indexPath.section
                )
                cell.switchButton.tag = indexPath.section
            case 1:
                cell.configure(
                    text: self.viewModel.rowTitles[indexPath.section],
                    isShowingSwitchButton: .show,
                    switchTag: indexPath.section
                )
                cell.switchButton.tag = indexPath.section
            default:
                return cell.configure(
                    text: self.viewModel.notificationRowTitles[indexPath.row],
                    isShowingSwitchButton: .hide,
                    switchTag: -1
                )
            }
        })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
}
