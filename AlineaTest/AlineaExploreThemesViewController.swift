//
//  AlineaExploreThemesViewController.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit


fileprivate enum ThemesType: UInt, CaseIterable {
    case DiversityAndInclusion
    case BoldBiotech
    case CryptoCentral
    case SheRunsIt
    case CleanAndGreen
    case Cannabisness
    case PowerIt
    case FoodieFun
    case ArtAndFashion
    case HomeIsLove
    
    fileprivate func title() -> String {
        switch self {
        case .DiversityAndInclusion:
            return "Diversity & Inclusion"
        case .BoldBiotech:
            return "Bold Biotech"
        case .CryptoCentral:
            return "Crypto Central"
        case .SheRunsIt:
            return "She Runs It"
        case .CleanAndGreen:
            return "Clean & Green"
        case .Cannabisness:
            return "Cannabis-ness"
        case .PowerIt:
            return "Power It"
        case .FoodieFun:
            return "Foodie Fun"
        case .ArtAndFashion:
            return "Art & Fashion"
        case .HomeIsLove:
            return "Home is where the heart is"
        }
    }
    
    fileprivate func icon() -> UIImage? {
        let regularFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: regularFont)
        
        switch self {
        case .DiversityAndInclusion:
            return UIImage(systemName: "book.circle", withConfiguration: configuration)
        case .BoldBiotech:
            return UIImage(systemName: "heart.circle", withConfiguration: configuration)
        case .CryptoCentral:
            return UIImage(systemName: "bahtsign.circle", withConfiguration: configuration)
        case .SheRunsIt:
            return UIImage(systemName: "person.crop.square", withConfiguration: configuration)
        case .CleanAndGreen:
            return UIImage(systemName: "cloud.drizzle.fill", withConfiguration: configuration)
        case .Cannabisness:
            return UIImage(systemName: "leaf.arrow.circlepath", withConfiguration: configuration)
        case .PowerIt:
            return UIImage(systemName: "battery.25", withConfiguration: configuration)
        case .FoodieFun:
            return UIImage(systemName: "dollarsign.circle", withConfiguration: configuration)
        case .ArtAndFashion:
            return UIImage(systemName: "flame", withConfiguration: configuration)
        case .HomeIsLove:
            return UIImage(systemName: "house.fill", withConfiguration: configuration)
        }
    }
}

fileprivate class AlineaExploreThemesCell: UICollectionViewCell {
    
    fileprivate static let cellId = "AlineaExploreThemesCellId"
    
    private var titleLabel: UILabel?
    private var typeImageView: UIImageView?
    
    var themeType: ThemesType? {
        didSet {
            setThemeUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        
        let contentContainer = UIView()
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        contentContainer.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 10, left: 10, bottom: 10, right: 10), withSiedException: [])
        contentContainer.backgroundColor = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
            let lightColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 0.1)
            let darkColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 0.5)
            return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
        })
        contentContainer.layer.cornerRadius = CGFloat(10.0)
        contentContainer.layer.borderWidth = CGFloat(1.0)
        contentContainer.layer.borderColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 0.5).cgColor
        
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel = lbl
        lbl.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(lbl)
        lbl.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 0, left: 5, bottom: 5, right: 5), withSiedException: [.top])
        
        let imViewContainer = UIView()
        imViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(imViewContainer)
        imViewContainer.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 15, left: 15, bottom: 0, right: 15), withSiedException: [.bottom])
        
        let imView = UIImageView()
        typeImageView = imView
        imView.tintColor = UIColor { (traitcollection) -> UIColor in
            let lightColor = UIColor(red: 163/255, green: 165/255, blue: 249/255, alpha: 1.0)
            let darkColor = lightColor //TODO: supply correct dark theme color
            return traitcollection.userInterfaceStyle == .dark ? darkColor : lightColor
        } //TODO: remove this when actual images are available
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.contentMode = .scaleAspectFill
        imViewContainer.addSubview(imView)
        //imView.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 15, left: 15, bottom: 0, right: 15), withSiedException: [.bottom])
        imView.centerXAnchor.constraint(equalTo: imViewContainer.centerXAnchor).isActive = true
        imView.centerYAnchor.constraint(equalTo: imViewContainer.centerYAnchor).isActive = true
        imView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        lbl.topAnchor.constraint(equalTo: imViewContainer.bottomAnchor, constant: 10).isActive = true
        imViewContainer.setContentHuggingPriority(.defaultLow, for: .vertical)
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        lbl.setContentHuggingPriority(.required, for: .vertical)
        
        setThemeUI()
    }
    
    private func setThemeUI() {
        if let typeImageView = typeImageView, let titleLabel = titleLabel {
            typeImageView.image = nil
            titleLabel.text = nil
            
            if let themeType = themeType {
                typeImageView.image = themeType.icon()
                titleLabel.text = themeType.title()
            }
        }
    }
}

public class AlineaExploreThemesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectioView)
        collectioView.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [])
        collectioView.backgroundColor = UIColor.clear
        
        collectioView.register(AlineaExploreThemesCell.self, forCellWithReuseIdentifier: AlineaExploreThemesCell.cellId)
        
        collectioView.delegate = self
        collectioView.dataSource = self
    }
    
    // MARK: Collection view methods
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ThemesType.allCases.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlineaExploreThemesCell.cellId, for: indexPath) as? AlineaExploreThemesCell {
            cell.themeType = ThemesType(rawValue: UInt(indexPath.row))
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
}
