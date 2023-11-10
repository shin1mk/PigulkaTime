//
//  PillsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 08.11.2023.
//

import SnapKit
import UIKit

protocol PillsViewControllerDelegate: AnyObject {
    func pillsViewController(_ controller: PillsViewController, didAddPill pill: Pill)
}

final class PillsViewController: UIViewController {
    weak var delegate: PillsViewControllerDelegate?

    private let drugView = DrugView()
    private let typeView = TypeView()
    private let dosageView = DosageView()
    
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Add pill"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 30)
        return titleLabel
    }()
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.SFUITextHeavy(ofSize: 20)
        saveButton.setTitleColor(.white, for: .normal)
        return saveButton
    }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTarget()
        setupDelegates()
    }
    //MARK: Methods
    private func setupConstraints() {
        view.backgroundColor = .black
        // save button
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-15)
        }
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        // save button
//        view.addSubview(saveButton)
//        saveButton.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
//            make.centerX.equalToSuperview()
//        }
        // drug view
        view.addSubview(drugView)
        drugView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60) // Или другой подходящий размер
        }
        // type view
        view.addSubview(typeView)
        typeView.snp.makeConstraints { make in
            make.top.equalTo(drugView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(300)
        }
//        // dosage view
//        view.addSubview(dosageView)
//        dosageView.snp.makeConstraints { make in
//            make.top.equalTo(drugView.snp.bottom).offset(90)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(300)
//            
//        }
    }
    // targets
    private func setupTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    // delegates
    private func setupDelegates() {
    }
    // save button
    @objc private func saveButtonTapped() {
        guard let enteredText = drugView.textField.text, !enteredText.isEmpty else {
            return // Не добавлять пустой текст
        }

        let newPill = Pill(name: enteredText, dosage: "", type: "", isEditable: true)
        delegate?.pillsViewController(self, didAddPill: newPill)
        // Закрыть текущий PillsViewController
        dismiss(animated: true, completion: nil)
    }
} // end
