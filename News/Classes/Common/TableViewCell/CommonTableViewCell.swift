//
//  CommonTableViewCell.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol CommonTableViewCellProtocol {
    func didSelectCell(index: Int)
}

class CommonTableViewCell: UITableViewCell {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thumbnailImage, stackViewLabel])
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var thumbnailImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var stackViewLabel: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
//        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    var delegate: CommonTableViewCellProtocol?
    
    private var index: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initSubviews()
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectedCell)))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    private func initSubviews() {
       contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.left.right.bottom.top.equalToSuperview().inset(10)
            $0.height.equalTo(70)
        }
        
        thumbnailImage.snp.makeConstraints{
            $0.width.equalTo(70)
        }
    }
    
    @objc private func selectedCell() {
        guard let index else { return }
        delegate?.didSelectCell(index: index)
    }
    
    func setData(_ img: String?, title: String?, desc: String?, index: Int) {
        self.index = index
        if let img {
            thumbnailImage.isHidden = false
            thumbnailImage.kf.setImage(with: URL(string: img))
        } else {
            thumbnailImage.isHidden = true
        }
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.descriptionLabel.text = desc
            self.layoutIfNeeded()
        }
    }
}
