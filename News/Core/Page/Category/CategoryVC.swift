//
//  CategoryVC.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit
import SnapKit

class CategoryVC: BaseVC {
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let t: CGFloat = 5
        let w = (ScreenSize.width) / 2
        flow.itemSize = CGSize(width: w, height: w*1.5)
        return flow
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.nameOfClass)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.nameOfClass)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var viewModel: CategoryVM!
    
    override func initSubview() {
        super.initSubview()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()//.inset(12)
        }
    }
    
    override func setData() {
        super.setData()
        title = "Category"
    }
}

// MARK: - Collection View
extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nameOfClass, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.setCell(title: viewModel.categoryList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewsSourceVC()
        vc.viewModel = NewsSourceVM(category: viewModel.categoryList[indexPath.row])
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
