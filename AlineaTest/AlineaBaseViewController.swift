//
//  AlineaBaseViewController.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit


public class AlineaBaseViewController: UIViewController {
    
    var tabItem: AlineaTab
    
    init(withTabItem tab: AlineaTab) {
        tabItem = tab
        super.init(nibName: nil, bundle: nil)
        
        title = tabItem.title()
        setBarButtonItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CONTENT_BG_COLOR
    }
    
    private func setBarButtonItems() {
        let regularFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: regularFont)
        
        let leftImg = UIImage(systemName: "line.horizontal.3", withConfiguration: configuration)?.withTintColor(CONTENT_COLOR)
        let leftItem = UIBarButtonItem(image: leftImg, style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftItem
        
        let rightImg = UIImage(systemName: "bell", withConfiguration: configuration)?.withTintColor(CONTENT_COLOR)
        let rightItem = UIBarButtonItem(image: rightImg, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightItem
    }
    
}
