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
        titleLabel.text = "Frequency"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let frequencyLabel: UILabel = {
        let dosageLabel = UILabel()
        dosageLabel.text = "Daily"
        dosageLabel.textColor = .systemGray3
        dosageLabel.textAlignment = .right
        dosageLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return dosageLabel
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
