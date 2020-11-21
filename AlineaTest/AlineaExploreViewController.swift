//
//  AlineaExploreViewController.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming


fileprivate enum ExploreType: UInt, CaseIterable {
    case None
    case Category
    case Themes
    case Trending
    
    fileprivate func title() -> String {
        switch self {
        case .None:
            return ""
        case .Category:
            return "Category"
        case .Themes:
            return "Themes"
        case .Trending:
            return "Trending"
        }
    }
}


private class AlineaExploreButton: UIView {

    fileprivate var exploreButonType: ExploreType
    private var button = MDCButton()
    private var bottomBorder = UIView()
    
    public var isSelected: Bool = false {
        didSet {
            handleSelectionState()
        }
    }
    
    public var tapCallBack:((AlineaExploreButton)->())?
    
    init(withType type:ExploreType) {
        exploreButonType = type
        super.init(frame: .zero)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [])
        button.isUppercaseTitle = false
        button.setTitle(exploreButonType.title(), for: .normal)
        button.setElevation(ShadowElevation.init(0), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        bottomBorder.backgroundColor = SELECTED_TINT_COLOR
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        bottomBorder.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [.top])
        bottomBorder.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        
        handleSelectionState()
    }
    
    private func handleSelectionState() {
        if isSelected {
            button.applyTextTheme(withScheme: textButtonSelectedScheme())
            bottomBorder.alpha = 1.0
        }
        else {
            button.applyTextTheme(withScheme: textButtonScheme())
            bottomBorder.alpha = 0.0
        }
    }
    
    private func textButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = CONTENT_COLOR
        scheme.typographyScheme.button = UIFont.systemFont(ofSize: 15)
        
        return scheme
    }
    
    private func textButtonSelectedScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = SELECTED_TINT_COLOR
        scheme.typographyScheme.button = UIFont.systemFont(ofSize: 15)
        
        return scheme
    }
    
    @objc public func buttonTapped() {
        if let tapCallBack = tapCallBack {
            tapCallBack(self)
        }
    }
    
}


public class AlineaExploreViewController: AlineaBaseViewController {
    
    private var currentExploreType = ExploreType.None {
        didSet{
            handleCurrentExploreType()
        }
    }
    
    private var selectedViewController: UIViewController?
    
    private var categoryButton = AlineaExploreButton(withType: .Category)
    private var themesButton = AlineaExploreButton(withType: .Themes)
    private var trendingButton = AlineaExploreButton(withType: .Trending)
    
    private var childContainer = UIView()
    
    struct ViewDimensions {
        static let TopButtonContainerHeight = CGFloat(60)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    // MARK: private methods
    
    private func initUI() {
        let topButtonContainer = UIStackView()
        topButtonContainer.axis = .horizontal
        topButtonContainer.spacing = 0
        topButtonContainer.alignment = .center
        topButtonContainer.distribution = .fill
        topButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topButtonContainer)
        topButtonContainer.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [ParentViewSideException.bottom])
        topButtonContainer.heightAnchor.constraint(equalToConstant: ViewDimensions.TopButtonContainerHeight).isActive = true
        
        let allButtons = [categoryButton, themesButton, trendingButton]
        var cnt = 0;
        for btn in allButtons {
            btn.translatesAutoresizingMaskIntoConstraints = false
            topButtonContainer.addArrangedSubview(btn)
            if cnt < (allButtons.count - 1) {
                let sepView = createSepView()
                topButtonContainer.addArrangedSubview(sepView)
                let topBottomGap = ViewDimensions.TopButtonContainerHeight/3
                let insets = UIEdgeInsets(top: topBottomGap, left: 0, bottom: topBottomGap, right: 0)
                sepView.addConstraintsToFillParentSafeAreaView(withInset: insets, withSiedException: [.leading, .trailing])
            }
            cnt = cnt + 1
            
            btn.tapCallBack = { [weak self] (tappedButton) in
                if let self = self {
                    let allButtons = [self.categoryButton, self.themesButton, self.trendingButton]
                    for btn in allButtons {
                        btn.isSelected = false
                    }
                    tappedButton.isSelected = true
                    self.currentExploreType = btn.exploreButonType
                }
            }
        }
        themesButton.widthAnchor.constraint(equalTo: categoryButton.widthAnchor).isActive = true
        trendingButton.widthAnchor.constraint(equalTo: categoryButton.widthAnchor).isActive = true
        
        childContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childContainer)
        childContainer.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [.top])
        childContainer.topAnchor.constraint(equalTo: topButtonContainer.bottomAnchor).isActive = true
        
        //initial selection
        categoryButton.isSelected = true
        currentExploreType = .Category
    }
    
    private func createSepView() -> UIView {
        let sepView = UIView()
        sepView.translatesAutoresizingMaskIntoConstraints = false
        sepView.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        sepView.backgroundColor = SEP_COLOR
        return sepView
    }
    
    private func handleCurrentExploreType() {
        if let currentChild = selectedViewController {
            currentChild.willMove(toParent: nil)
            currentChild.removeFromParent()
            currentChild.view.removeFromSuperview()
        }
        
        selectedViewController = nil
        
        var newVC: UIViewController?
        switch currentExploreType {
        case .Category:
            newVC = AlineaExploreCategoryViewController()
        case .Themes:
            newVC = AlineaExploreThemesViewController()
        case .Trending:
            newVC = AlineaExploreTrendingViewController()
        case .None:
            break
        }

        if let vc = newVC {
            selectedViewController = vc

            vc.willMove(toParent: self)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            childContainer.addSubview(vc.view)
            vc.view.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [])
            vc.didMove(toParent: self)
        }
        else {
            NSLog("[AlineaExploreViewController]: unable to handle handleCurrentExploreType")
        }
    }
}
