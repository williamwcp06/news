//
//  CategoryViewController.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit
import SnapKit

class CategoryViewController: UIViewController {
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
    
    var presenter: CategoryPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension CategoryViewController: CategoryViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func initUI() {
        title = "Category"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()//.inset(12)
        }
    }
}

// MARK: - Collection View
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCategoryList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nameOfClass, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.setCell(title: presenter.getCategoryList()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}
