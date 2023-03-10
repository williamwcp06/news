//
//  LoadingIndicator.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation
import UIKit
import SnapKit

public class LoadingIndicator: BaseView {
    static let instance = LoadingIndicator()
    private lazy var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        adjustWithTraitColor()
    }
    
    public override func initSubview() {
        super.initSubview()
        adjustWithTraitColor()
        layer.cornerRadius = 10
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints{
            $0.left.right.bottom.top.equalToSuperview().inset(20)
        }
    }
    
    public override func adjustWithTraitColor() {
        super.adjustWithTraitColor()
        loadingIndicator.color = traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
    
    public func showLoading(onView: UIView? = nil) {
        guard let view: UIView = onView ?? UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        
        DispatchQueue.main.async {
            view.addSubview(self)
            self.snp.makeConstraints{
                $0.center.equalToSuperview()
            }
            self.loadingIndicator.startAnimating()
            self.isHidden = false
        }
    }
    
    public func hideLoading() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
            self.loadingIndicator.stopAnimating()
            self.isHidden = true
        }
    }
}

