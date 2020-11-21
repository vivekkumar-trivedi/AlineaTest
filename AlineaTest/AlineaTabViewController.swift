//
//  AlineaTabViewController.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit
import MaterialComponents.MDCAppBar


public class AlineaTabViewController: UIViewController {
    
    public var tabBar: AlineaTabbar?
    private var childVCContainer: UIView?
    private var selectedTabBarItem: UITabBarItem?
    @objc private(set) var selectedViewController: UIViewController?
    @objc public var currentNavController:MDCAppBarNavigationController? {
        get {
            if let nav = self.selectedViewController as? MDCAppBarNavigationController {
                return nav
            }
            NSLog("[AlineaTabViewController]: Current selectedController is not a navigation controller")
            return nil
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CONTENT_BG_COLOR
        
        let childContainer = UIView()
        childVCContainer = childContainer
        childContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childContainer)
        childContainer.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [ParentViewSideException.bottom])
        
        let tabs = AlineaTabbar(withTabs: _tabs())
        tabBar = tabs
        tabs.tabSelectedCallback = { [weak self] (tab) in
            if let self = self {
                self._tabSelected(tab)
            }
        }
        view.addSubview(tabs)
        tabs.translatesAutoresizingMaskIntoConstraints = false
        tabs.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [.top])
        tabs.topAnchor.constraint(equalTo: childContainer.bottomAnchor).isActive = true
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedTabBarItem == nil {
            _tabSelected(AlineaTab.Home.tabItem())
        }
    }
    
    //MARK - private methods
    
    private func _tabs() -> [UITabBarItem] {
        return [
            AlineaTab.Home.tabItem(),
            AlineaTab.Explore.tabItem(),
            AlineaTab.Trend.tabItem(),
            AlineaTab.People.tabItem(),
            AlineaTab.Idea.tabItem(),
            ]
    }
    
    private func _tabSelected(_ tab:UITabBarItem) {
        if let selectedTabBarItem = selectedTabBarItem, tab.tag == selectedTabBarItem.tag {
            if let selectedViewController = selectedViewController as? MDCAppBarNavigationController {
                //pop to root view controller when we have more than 1 VC in stack
                selectedViewController.popToRootViewController(animated: true)
                return
            }
        }
        selectedTabBarItem = tab
        
        if let currentChild = selectedViewController {
            currentChild.willMove(toParent: nil)
            currentChild.removeFromParent()
            currentChild.view.removeFromSuperview()
        }
        
        selectedViewController = nil
        
        if let tabType  = AlineaTab(rawValue: tab.tag), let childContainer = childVCContainer {
            
            let newVC: UIViewController?
            switch tabType {
            case .Home, .Trend, .Idea, .People:
                newVC = AlineaBaseViewController(withTabItem: tabType)
            case .Explore:
                newVC = AlineaExploreViewController(withTabItem: tabType)
            }

            if let vc = newVC {
                let childVC = MDCAppBarNavigationController.navigationController(withRootViewController: vc, keepTrackingScrollViewOnRootView: false)
                childVC.view.translatesAutoresizingMaskIntoConstraints = false
                selectedViewController = childVC

                childVC.willMove(toParent: self)
                childContainer.addSubview(childVC.view)
                childVC.view.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [])
                childVC.didMove(toParent: self)
            }
            else {
                NSLog("[AlineaTabViewController]: unable to handle Tab Item action with tag: \(String(describing: tab.title))")
            }
        }
    }
    
}
