//
//  TypeCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 11.11.2023.
//

import UIKit
import SnapKit

final class TypeCustomTableCell: UITableViewCell {
    weak var delegate: TypeCustomTableCellDelegate?
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Type"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "Choose type"
        typeLabel.textColor = .systemGray3
        typeLabel.textAlignment = .right
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 17)
        return typeLabel
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
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
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
        delegate?.didSelectType(cell: self)
    }
    // set label
    func setLabelText(_ text: String) {
        typeLabel.text = text
    }
} //end
