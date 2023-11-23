//
//  FirstCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit

// передаем из пикер вью сюда
protocol FirstCustomTableCellDelegate: AnyObject {
    func didSelectTime(cell: FirstCustomTableCell)
}

final class FirstCustomTableCell: UITableViewCell {
    weak var delegate: FirstCustomTableCellDelegate?
    //MARK: Properties
    private let firstTitleLabel: UILabel = {
        let firstTitleLabel = UILabel()
        firstTitleLabel.text = "Notification time"
        firstTitleLabel.textColor = .white
        firstTitleLabel.textAlignment = .left
        firstTitleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return firstTitleLabel
    }()
    private let firstNotificationLabel: UILabel = {
        let firstNotificationLabel = UILabel()
        firstNotificationLabel.text = "Choose \u{2192}"
        firstNotificationLabel.textColor = .systemGray
        firstNotificationLabel.textAlignment = .right
        firstNotificationLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return firstNotificationLabel
    }()
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6 // Цвет бордера
        return view
    }()
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupGesture()
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupConstraints() {
        backgroundColor = .clear
        // firstTitleLabel
        addSubview(firstTitleLabel)
        firstTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
        // firstNotificationLabel
        addSubview(firstNotificationLabel)
        firstNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNotificationLabel.snp.top)
            make.trailing.equalToSuperview().offset(-10)
        }
        // bottomBorderView
        addSubview(bottomBorderView)
        bottomBorderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1) // Высота
        }
    }
    // тап по ячейке
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    // ячейка нажата вызываем протокол
    @objc private func cellTapped() {
        delegate?.didSelectTime(cell: self)
    }
    // установить текст в ячейку
    func setFirstTimeText(_ text: String) {
        firstNotificationLabel.text = text
    }
} //end
