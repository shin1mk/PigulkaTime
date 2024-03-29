//
//  FrequencyCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 12.11.2023.
//

import UIKit
import SnapKit

final class FrequencyCustomTableCell: UITableViewCell {
    weak var delegate: FrequencyCustomTableCellDelegate?
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "frequency".localized()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextMedium(ofSize: 20)
        return titleLabel
    }()
    private let frequencyLabel: UILabel = {
        let frequencyLabel = UILabel()
        frequencyLabel.text = "choose".localized() + " \u{2192}"
        frequencyLabel.textColor = .systemGray
        frequencyLabel.textAlignment = .right
        frequencyLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return frequencyLabel
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
        setupTarget()
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupConstraints() {
        backgroundColor = .clear
        // title Label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
        // textField
        addSubview(frequencyLabel)
        frequencyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
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
    // target
    private func setupTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }
    // cell action
    @objc private func cellTapped() {
        delegate?.didSelectFrequency(cell: self)
    }
    // set label
    func setFrequencyText(_ text: String) {
        frequencyLabel.text = text
    }
} //end
