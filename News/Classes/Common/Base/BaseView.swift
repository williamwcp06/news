//
//  BaseVM.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit

public class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBinding()
        initObserve()
        initSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        adjustWithTraitColor()
    }
    
    public func initSubview() {}
    
    public func initBinding() {}
    
    public func initObserve() {}
    
    public func adjustWithTraitColor() {
        backgroundColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
    }
}


