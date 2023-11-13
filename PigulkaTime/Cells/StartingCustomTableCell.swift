//
//  StartingCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 13.11.2023.
//

import UIKit
import SnapKit

final class StartingCustomTableCell: UITableViewCell {
    weak var delegate: StartingCustomTableCellDelegate?
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Starting at"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let startingLabel: UILabel = {
        let startingLabel = UILabel()
        startingLabel.text = "Choose \u{2192}"
        startingLabel.textColor = .systemGray
        startingLabel.textAlignment = .right
        startingLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return startingLabel
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
        addSubview(startingLabel)
        startingLabel.snp.makeConstraints { make in
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
        delegate?.didSelectStarting(cell: self)
    }
    // set label
    func setStartingText(_ text: String) {
        startingLabel.text = text
    }
} //end
