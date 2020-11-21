//
//  AlinewTabbar.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import MaterialComponents.MaterialBottomNavigation


enum AlineaTab: Int {
    case Home
    case Explore
    case Trend
    case People
    case Idea
    
    public func tabItem() -> UITabBarItem {
        let item = UITabBarItem( title: "", image: tabIcon(), tag: self.rawValue)
        return item
    }
    
    private func tabIcon() -> UIImage? {
        let regularFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: regularFont)
        
        switch self {
        case .Home:
            return UIImage(systemName: "house", withConfiguration: configuration)
        case .Explore:
            return UIImage(systemName: "magnifyingglass", withConfiguration: configuration)
        case .Trend:
            return UIImage(systemName: "arrow.up.right.circle.fill", withConfiguration: configuration)
        case .People:
            return UIImage(systemName: "person.2", withConfiguration: configuration)
        case .Idea:
            return UIImage(systemName: "lightbulb", withConfiguration: configuration)
        }
    }
    
    public func title() -> String {
        switch self {
        case .Home:
            return "Home"
        case .Explore:
            return "Explore"
        case .Trend:
            return "Trend"
        case .People:
            return "Community"
        case .Idea:
            return "Help"
        }
    }
}


public class AlineaTabbar: MDCBottomNavigationBar, MDCBottomNavigationBarDelegate {
    
    public var tabSelectedCallback: ((UITabBarItem) -> Void)?
    
    init(withTabs tabs: [UITabBarItem]) {
        super.init(frame: .zero)
        applyPrimaryTheme(withScheme: tabbarScheme())
        titleVisibility = MDCBottomNavigationBarTitleVisibility.never
        alignment = MDCBottomNavigationBarAlignment.justifiedAdjacentTitles
        elevation = ShadowElevation(rawValue: 0)
        selectedItemTitleColor = SELECTED_TINT_COLOR
        selectedItemTintColor = SELECTED_TINT_COLOR
        delegate = self
        items = tabs
        selectedItem = tabs.first
        layer.shadowOpacity = 0.1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tabbarScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = CONTENT_BG_COLOR
        scheme.colorScheme.onPrimaryColor = UNSELECTED_TINT_COLOR
        scheme.typographyScheme.caption = UIFont.systemFont(ofSize: 11)
        
        return scheme
    }
    
    //MARK - delegate
    
    public func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        
        if let cb = tabSelectedCallback {
            cb(item)
        }
    }
}
