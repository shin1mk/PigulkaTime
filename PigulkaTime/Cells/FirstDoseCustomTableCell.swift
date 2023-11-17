//
//  FirstDoseCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 13.11.2023.
//

import UIKit
import SnapKit

final class FirstDoseCustomTableCell: UITableViewCell {
    weak var delegate: FirstDoseCustomTableCellDelegate?
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "First dose at"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let firstDoseLabel: UILabel = {
        let firstDoseLabel = UILabel()
        firstDoseLabel.text = "Choose \u{2192}"
        firstDoseLabel.textColor = .systemGray
        firstDoseLabel.textAlignment = .right
        firstDoseLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return firstDoseLabel
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
        addSubview(firstDoseLabel)
        firstDoseLabel.snp.makeConstraints { make in
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
        delegate?.didSelectFirst(cell: self)
    }
    // set label
    func setFirstDoseLabelText(_ text: String) {
        firstDoseLabel.text = text
    }
} //end
