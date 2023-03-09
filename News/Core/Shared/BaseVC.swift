//
//  BaseVC.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit
import SnapKit
import RxSwift

class BaseVC: UIViewController {
    
    lazy var bag = DisposeBag()
    private lazy var loadingIndicator:LoadingIndicator = {
       let loading = LoadingIndicator()
        loading.isHidden = true
        return loading
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        initObserve()
        initSubview()
        setData()
        modalPresentationStyle = .fullScreen
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
//        adjustColorWithTrait()
    }
    
    public func initSubview() {
//        adjustColorWithTrait()
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.loadingIndicator)
        }
    }
    
    public func initBinding() {}
    
    public func initObserve() {}
    
    public func setData() {}
    
    public func constraintToSuperview(view: UIView, superview: UIView) {
        view.snp.makeConstraints{
            $0.top.equalTo(superview.safeAreaLayoutGuide.snp.top).inset(10)
            $0.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.equalTo(superview.safeAreaLayoutGuide.snp.left).inset(10)
            $0.right.equalTo(superview.safeAreaLayoutGuide.snp.right).inset(10)
        }
    }
    
    public func constraintCenterSuperview(view: UIView, superview: UIView) {
        view.snp.makeConstraints{
            $0.center.equalTo(superview.snp.center)
        }
    }
    
//    public func adjustColorWithTrait() {
//        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
//    }
    
    public func createAlert(style: UIAlertController.Style = .alert, title: String? = nil, message: String? = nil, useTextfield: Bool = false, action: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) -> UIAlertController {
        hideLoading()
        let alert = UIAlertController(title: title == nil ? nil : "Error [\(title!)]", message: message, preferredStyle: style)
        if useTextfield {
            alert.addTextField { textfield in
                textfield.keyboardType = .numberPad
                textfield.placeholder = "Type here"
            }
        }
        
        action.forEach{
            alert.addAction($0)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        return alert
    }
    
    public func addRightBarButton(title: String, selector: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
    }
    
    @objc public func backButtonClick(){
        let viewController = self.navigationController?.popViewController(animated: true)
        if nil == viewController {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    public func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.showLoading()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    public func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.hideLoading()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc public func endEditing() {
        view.endEditing(true)
    }
}

