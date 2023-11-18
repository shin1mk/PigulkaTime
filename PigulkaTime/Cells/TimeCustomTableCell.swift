//
//  TimeCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 13.11.2023.
//

import UIKit
import SnapKit

final class TimeCustomTableCell: UITableViewCell {
    weak var delegate: TimeCustomTableCellDelegate?
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Time for drug"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "Choose \u{2192}"
        timeLabel.textColor = .systemGray
        timeLabel.textAlignment = .right
        timeLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return timeLabel
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
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
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
        delegate?.didSelectTime(cell: self)
    }
    // set label
    func setTimeLabelText(_ text: String) {
        timeLabel.text = text
    }
} //end
