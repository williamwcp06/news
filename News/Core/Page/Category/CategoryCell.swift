//
//  CategoryCell.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    private lazy var thumbnailImage: UIImageView = {
        let iv = UIImageView()
//        iv.layer.cornerRadius = 10
//        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white.withAlphaComponent(0.5)
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = true
    }
    
    private func initSubview() {
        contentView.addSubview(thumbnailImage)
        thumbnailImage.addSubview(titleLabel)
        
        thumbnailImage.snp.makeConstraints{
            $0.left.top.bottom.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.left.top.bottom.right.equalToSuperview()
        }
    }
    
    func setCell(title: String) {
        DispatchQueue.main.async {
            self.thumbnailImage.image = UIImage(named: title)
            self.titleLabel.text = title.uppercased()
            
        }
        
    }
}
