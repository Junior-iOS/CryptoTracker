//
//  SettingsViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
//

import UIKit
import MessageUI

class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
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
        self.viewModel.viewDelegate = self
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

// MARK: - SettingsViewModel Delegate
extension SettingsViewController: SettingsViewModelDelegate {
    func couldNotSentEmail(_ viewController: UIViewController) {
        navigationController?.present(viewController, animated: true)
    }
    
    func shareApp(_ viewController: UIViewController) {
        navigationController?.present(viewController, animated: true)
    }
}

// MARK: - UITableView Delegate and DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                viewModel.sendEmail(delegate: self) { [weak self] mailComposeVC in
                    self?.navigationController?.present(mailComposeVC, animated: true)
                }
            default:
                viewModel.shareApp()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
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
            case 2:
                return cell.configure(
                    text: self.viewModel.notificationRowTitles[indexPath.row],
                    isShowingSwitchButton: .hide,
                    switchTag: -1
                )
            default:
                return cell.configure(
                    text: self.viewModel.appVersion(),
                    isShowingSwitchButton: .none,
                    switchTag: -1
                )
            }
        })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
}

// MARK: - UINavigationController Delegate
extension SettingsViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
