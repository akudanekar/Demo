//
//  RecordsListViewController.swift
//  DemoApp
//
//  Created by Abhas on 22/06/21.
//  Copyright © 2021 Abhas. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordsListViewController: UIViewController {
    
    @IBOutlet var tblRecords: UITableView!
    var arrRecords = [JSON]()
    var arrSectionsToOpen = [Int]()
    
    //MARK: ViewLoadMethods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Loading NIB file before using
        tblRecords.register(UINib(nibName: RecordSubtitleTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RecordSubtitleTableViewCell.identifier)
        tblRecords.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
        setNavigationBarTitle(title: "Catlog")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Utility.sharedInstance.getDataFromFile(resource: "AllMenu", fileType: "json") { data in
            if let data = data {
                arrRecords = data
            }
        }
    }
    
    //MARK: SelectorMethods
    @objc func btnSectionDropDownAction(_ sender: UIButton) {
        
        let tag = sender.tag
        if sender.isSectionCollapsed == false {  // when section is closed
            sender.isSectionCollapsed = true
            arrSectionsToOpen.append(tag)
            
        } else {    // when section is open
            sender.isSectionCollapsed = false
            if let index = arrSectionsToOpen.firstIndex(of: tag) {
                arrSectionsToOpen.remove(at: index)
            }
            tblRecords.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            
        }
        
        tblRecords.reloadSections(IndexSet(integer: tag), with: .none)
    }
}

//MARK: Delegate Implementation
extension RecordsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrRecords.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .groupTableViewBackground
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5

        let lblName = UILabel.init(frame: CGRect.init(x: 5, y: 10, width: view.frame.size.width - 50, height: 30))
        lblName.text = arrRecords[section]["name"].stringValue.capitalized
        
        let btnDropDown = UIButton.init(frame: CGRect.init(x: view.frame.size.width - 40, y: 10, width: 30, height: 30))
        if !arrSectionsToOpen.contains(section) {
            btnDropDown.isSectionCollapsed = false
            btnDropDown.setImage( UIImage.init(named: "imgDown"), for: [])
        } else {
            btnDropDown.setImage( UIImage.init(named: "imgUp"), for: [])
        }
        btnDropDown.tag = section
        btnDropDown.addTarget(self, action: #selector(btnSectionDropDownAction(_:)), for: .touchUpInside)

        view.addSubview(lblName)
        view.addSubview(btnDropDown)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSectionsToOpen.contains(section) ? arrRecords[section]["sub_category"].arrayValue.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordSubtitleTableViewCell", for: indexPath) as? RecordSubtitleTableViewCell
        if let cell = cell {
            cell.cellObj = arrRecords[indexPath.section]["sub_category"][indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}
