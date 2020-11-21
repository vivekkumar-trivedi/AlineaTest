//
//  AlineaExploreCategoryViewController.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit


fileprivate enum ExploreCategories: UInt, CaseIterable {
    case Stocks
    case ETFs
    case Crypto
    
    fileprivate func title() -> String {
        switch self {
        case .Stocks:
            return "Stocks"
        case .ETFs:
            return "ETFs"
        case .Crypto:
            return "Crypto"
        }
    }
    
    fileprivate func icon() -> UIImage? {
        let regularFont = UIFont.systemFont(ofSize: 24, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: regularFont)
        
        switch self {
        case .Stocks:
            return UIImage(systemName: "bolt.circle", withConfiguration: configuration)
        case .ETFs:
            return UIImage(systemName: "flag.circle", withConfiguration: configuration)
        case .Crypto:
            return UIImage(systemName: "star.circle", withConfiguration: configuration)
        }
    }
    
    fileprivate func color() -> UIColor {
        switch self {
        case .Stocks:
            return UIColor { (traitcollection) -> UIColor in
                let lightColor = UIColor(red: 163/255, green: 165/255, blue: 249/255, alpha: 1.0)
                let darkColor = lightColor //TODO: supply correct dark theme color
                return traitcollection.userInterfaceStyle == .dark ? darkColor : lightColor
            }
        case .ETFs:
            return UIColor { (traitcollection) -> UIColor in
                let lightColor = UIColor(red: 72/255, green: 81/255, blue: 203/255, alpha: 1.0)
                let darkColor = lightColor //TODO: supply correct dark theme color
                return traitcollection.userInterfaceStyle == .dark ? darkColor : lightColor
            }
        case .Crypto:
            return UIColor { (traitcollection) -> UIColor in
                let lightColor = UIColor(red: 255/255, green: 214/255, blue: 82/255, alpha: 1.0)
                let darkColor = lightColor //TODO: supply correct dark theme color
                return traitcollection.userInterfaceStyle == .dark ? darkColor : lightColor
            }
        }
    }
}


private class AlineaExploreCategoryCell: UITableViewCell {
    
    public static let cellId = "ExploreCategioryCellId"
    
    private var mainContentContainer: UIView?
    private var categoryImageView: UIImageView?
    private var titleLabel: UILabel?
    
    var exploreCategory: ExploreCategories? {
        didSet {
            handleCategoryUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        selectionStyle = .none
        
        let contentContainer = UIView()
        mainContentContainer = contentContainer
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        contentContainer.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 15, left: 20, bottom: 15, right: 20), withSiedException: [])
        let htConstraint = contentContainer.heightAnchor.constraint(equalToConstant: 80.0)
        htConstraint.priority = UILayoutPriority(999)
        htConstraint.isActive = true
        contentContainer.layer.cornerRadius = CGFloat(40)
        
        let imView = UIImageView()
        categoryImageView = imView
        imView.contentMode = .scaleAspectFit
        imView.tintColor = UIColor.white //in both themes
        imView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(imView)
        imView.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 0, left: 20, bottom: 0, right: 0), withSiedException: [.trailing, .top, .bottom])
        imView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        imView.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor).isActive = true
        
        let titleLbl = UILabel()
        titleLabel = titleLbl
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentContainer.addSubview(titleLbl)
        titleLbl.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: imView.trailingAnchor, constant: 10).isActive = true
        
        handleCategoryUI()
    }
    
    private func handleCategoryUI() {
        if let exploreCategory = exploreCategory {
            if let mainContentContainer = mainContentContainer {
                mainContentContainer.backgroundColor = exploreCategory.color()
            }
            
            if let categoryImageView = categoryImageView {
                categoryImageView.image = exploreCategory.icon()
            }
            
            if let titleLabel = titleLabel {
                titleLabel.text = exploreCategory.title()
            }
        }
    }
}


public class AlineaExploreCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlineaExploreCategoryCell.self, forCellReuseIdentifier: AlineaExploreCategoryCell.cellId)
    }
    
    // MARK: Tableview methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExploreCategories.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AlineaExploreCategoryCell.cellId) as? AlineaExploreCategoryCell {
            cell.exploreCategory = ExploreCategories(rawValue: UInt(indexPath.row))
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "UNKNOWN")
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (ExploreCategories.allCases.count - 1) {
            cell.separatorInset = .init(top: 0, left: tableView.frame.size.width, bottom: 0, right: 0)
        }
    }
}
