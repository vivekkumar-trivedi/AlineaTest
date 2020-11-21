//
//  AlineaExploreTrendingViewController.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit


fileprivate enum AlineaExploreTrendingTypes: UInt, CaseIterable {
    case TopGainers
    case TopSellers
    
    fileprivate func title() -> String {
        switch self {
        case .TopGainers:
            return "Top Gainers"
        case .TopSellers:
            return "Top Sellers"
        }
    }
}


class AlineaExploreTrendingEntry {
    public var companyName: String
    public var companyDomain: String
    public var companyicon: UIImage?
    public var companyChangePercent: CGFloat
    
    init(withName name:String, andDomain domain:String, andChange changePercent: CGFloat, andPicture icon: UIImage?) {
        companyName = name
        companyDomain = domain
        companyicon = icon
        companyChangePercent = changePercent
    }
    
    fileprivate func changeDirectionColor() -> UIColor {
        if companyChangePercent > 0 {
            return UIColor(red: 0, green: (219/255), blue: (181/255), alpha: 1.0) //positive
        }
        else {
            return UIColor(red: 1, green: (105/255), blue: (111/255), alpha: 1.0) //red
        }
    }
}


fileprivate class AlineaExploreTrendingEntriesModel {
    
    fileprivate var entries: [AlineaExploreTrendingEntry] = []
    fileprivate var modelType: AlineaExploreTrendingTypes
    
    init (withType type: AlineaExploreTrendingTypes) {
        modelType = type
    }
    
}


class AlineaExploreTrendingCell: UITableViewCell {
    
    fileprivate static let cellId = "AlineaExploreTrendingCellId"
    
    private var imView = UIImageView()
    private var companyTitle = UILabel()
    private var companyDomain = UILabel()
    private var changeValue = UILabel()
    
    fileprivate var entry: AlineaExploreTrendingEntry? {
        didSet {
            setUIForEntry()
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
        imView.translatesAutoresizingMaskIntoConstraints = false
        companyTitle.translatesAutoresizingMaskIntoConstraints = false
        companyDomain.translatesAutoresizingMaskIntoConstraints = false
        changeValue.translatesAutoresizingMaskIntoConstraints = false
        
        let contentContainer = UIView()
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        contentContainer.addConstraintsToFillParentSafeAreaView(withInset: .init(top: 10, left: 20, bottom: 10, right: 20), withSiedException: [])
        
        contentContainer.addSubview(imView)
        contentContainer.addSubview(companyTitle)
        contentContainer.addSubview(companyDomain)
        contentContainer.addSubview(changeValue)
        
        imView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        imView.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor).isActive = true
        
        companyTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        companyDomain.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        companyDomain.textColor = UIColor.gray
        
        companyTitle.leadingAnchor.constraint(equalTo: imView.trailingAnchor, constant: 10).isActive = true
        companyTitle.topAnchor.constraint(equalTo: contentContainer.topAnchor).isActive = true
        companyDomain.leadingAnchor.constraint(equalTo: imView.trailingAnchor, constant: 10).isActive = true
        companyDomain.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor).isActive = true
        companyDomain.topAnchor.constraint(equalTo: companyTitle.bottomAnchor, constant: 5).isActive = true
        
        changeValue.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        changeValue.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor).isActive = true
        
        changeValue.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        changeValue.layer.cornerRadius = 5.0
        changeValue.clipsToBounds = true
        changeValue.textColor = UIColor.white
        
        setUIForEntry()
    }
    
    private func setUIForEntry() {
        imView.image = nil
        companyTitle.text = nil
        companyDomain.text = nil
        changeValue.text = nil
        changeValue.backgroundColor = UIColor.clear
        if let entry = entry {
            imView.image = entry.companyicon
            companyTitle.text = entry.companyName
            companyDomain.text = entry.companyDomain
            changeValue.text = "\(entry.companyChangePercent)%"
            changeValue.backgroundColor = entry.changeDirectionColor()
        }
    }
    
}


public class AlineaExploreTrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var topGainerModel: AlineaExploreTrendingEntriesModel?
    private var topSellerModel: AlineaExploreTrendingEntriesModel?
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestData()
    }
    
    private func requestData() {
        //in reality this will go and start the services which will make request to fetch data
        let gainerModel = AlineaExploreTrendingEntriesModel(withType: .TopGainers)
        let sellerModel = AlineaExploreTrendingEntriesModel(withType: .TopSellers)
        
        gainerModel.entries.append(AlineaExploreTrendingEntry(withName: "Medifast", andDomain: "MEDI", andChange: 50.78, andPicture: UIImage(systemName: "waveform.path.ecg")))
        gainerModel.entries.append(AlineaExploreTrendingEntry(withName: "Pinterest", andDomain: "PINS", andChange: -4.77, andPicture: UIImage(systemName: "pin")))
        gainerModel.entries.append(AlineaExploreTrendingEntry(withName: "Slack Technologies", andDomain: "WORK", andChange: -5.99, andPicture: UIImage(systemName: "pencil.circle")))
        gainerModel.entries.append(AlineaExploreTrendingEntry(withName: "Evoqua Water", andDomain: "AQUA", andChange: 5.99, andPicture: UIImage(systemName: "staroflife")))
        
        sellerModel.entries.append(AlineaExploreTrendingEntry(withName: "Slack Technologies", andDomain: "WORK", andChange: -5.99, andPicture: UIImage(systemName: "pencil.circle")))
        sellerModel.entries.append(AlineaExploreTrendingEntry(withName: "Evoqua Water", andDomain: "AQUA", andChange: 5.99, andPicture: UIImage(systemName: "staroflife")))
        
        topGainerModel = gainerModel
        topSellerModel = sellerModel
        
        tableView.reloadData()
    }
    
    private func initUI() {
        tableView.backgroundColor = CONTENT_BG_COLOR
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.addConstraintsToFillParentSafeAreaView(withInset: .zero, withSiedException: [])
        
        tableView.register(AlineaExploreTrendingCell.self, forCellReuseIdentifier: AlineaExploreTrendingCell.cellId)
        tableView.separatorInset = .zero
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: tableview methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return AlineaExploreTrendingTypes.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sec = AlineaExploreTrendingTypes(rawValue: UInt(section)) {
            switch sec {
            case .TopGainers:
                return topGainerModel?.entries.count ?? 0
            case .TopSellers:
                return topSellerModel?.entries.count ?? 0
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sec = AlineaExploreTrendingTypes(rawValue: UInt(section)) {
            return sec.title()
        }
        return ""
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sec = AlineaExploreTrendingTypes(rawValue: UInt(indexPath.section)) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: AlineaExploreTrendingCell.cellId) as? AlineaExploreTrendingCell {
                
                var entry: AlineaExploreTrendingEntry?
                
                switch sec {
                case .TopGainers:
                    if let topGainerModel = topGainerModel, topGainerModel.entries.count > indexPath.row {
                        entry = topGainerModel.entries[indexPath.row]
                    }
                case .TopSellers:
                    if let topSellerModel = topSellerModel, topSellerModel.entries.count > indexPath.row {
                        entry = topSellerModel.entries[indexPath.row]
                    }
                }
                
                cell.entry = entry
                
                return cell
                
            }
        }
        return UITableViewCell()
    }
}
