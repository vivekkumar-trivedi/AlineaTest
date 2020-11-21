//
//  AlineaUtility.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit
import MaterialComponents.MDCAppBar


public struct ParentViewSideException : OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    static let leading  = ParentViewSideException(rawValue: 1 << 0)
    static let trailing = ParentViewSideException(rawValue: 1 << 1)
    static let top  = ParentViewSideException(rawValue: 1 << 2)
    static let bottom  = ParentViewSideException(rawValue: 1 << 3)
}


extension UIView {
    
    public func addConstraintsToFillParentSafeAreaView(withInset inset: UIEdgeInsets, withSiedException sideException: ParentViewSideException) {
        if let superview = superview {
            if !sideException.contains(.leading) {
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: inset.left).isActive = true
            }
            if !sideException.contains(.trailing) {
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -inset.right).isActive = true
            }
            if !sideException.contains(.top) {
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: inset.top).isActive = true
            }
            if !sideException.contains(.bottom) {
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -inset.bottom).isActive = true
            }
        }
    }
}


fileprivate let associatedMDCAppBarNavigationControllerDelegateKey = "MDCAppBarNavigationControllerDelegatekey"


//since we cant extend MDCAppBarNavigationController
extension MDCAppBarNavigationController {
    
    public static func navigationController(withRootViewController rootVC: UIViewController, keepTrackingScrollViewOnRootView keepTrackingView: Bool) -> MDCAppBarNavigationController{
        let navVC = MDCAppBarNavigationController.init(rootViewController: rootVC)
        if let appbarVC = navVC.appBarViewController(for: rootVC) {
            appbarVC.setTheme()
            if !keepTrackingView {
                appbarVC.headerView.trackingScrollView = nil //this will remove tracking scrollview of root view controller's nav bar
            }
        }
        return navVC
    }
    
}

extension MDCAppBarViewController {
    
    private func navigationbarScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = CONTENT_BG_COLOR
        scheme.colorScheme.onPrimaryColor = CONTENT_COLOR
        scheme.typographyScheme.caption = UIFont.systemFont(ofSize: 17)
        
        return scheme
    }
    
    public func setTheme() {
        applyPrimaryTheme(withScheme: navigationbarScheme())
    }
    
}
