//
//  TimesPerCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 12.11.2023.
//

import UIKit
import SnapKit

final class TimesCustomTableCell: UITableViewCell {
    weak var delegate: TimesCustomTableCellDelegate?
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "how_many_times".localized()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let timesLabel: UILabel = {
        let timesLabel = UILabel()
        timesLabel.text = "choose".localized() + " \u{2192}"
        timesLabel.textColor = .systemGray
        timesLabel.textAlignment = .right
        timesLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return timesLabel
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
        addSubview(timesLabel)
        timesLabel.snp.makeConstraints { make in
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
        delegate?.didSelectTimes(cell: self)
    }
    // set label
    func setTimesText(_ text: String) {
        timesLabel.text = text
    }
} //end
