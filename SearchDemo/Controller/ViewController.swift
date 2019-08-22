//
//  ViewController.swift
//  SearchDemo
//
//  Created by netset on 12/08/19.
//  Copyright © 2019 NetSet. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewSearch: UITableView!
    var isSearchbar : Bool = false
    var userData = [Data]()
    var userFilterData = [Data]()
    var arrSelectedIDS = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSearch.tableFooterView = UIView()
        userData = getAllDetail()
        
        // Do any additional setup after loading the view.
    }
    
    func getAllDetail() -> [Data] {
        var dataList = [Data]()
        let allDetail = Common.generateDataList()
        for item in allDetail {
            dataList.append(Data(attributes: item))
        }
        return dataList
    }
    
    //MARK:- TableView Delegate & DateSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchbar ? userFilterData.count : userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableViewSearch.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? tableSearchCell)!
        isSearchbar ? checkCellValue(arrayValue: userFilterData, tableCell: cell, row: indexPath.row) :  checkCellValue(arrayValue: userData, tableCell: cell, row: indexPath.row)
        return cell
    }
    
    func checkCellValue (arrayValue : [Data], tableCell : tableSearchCell, row : Int)
    {
        tableCell.accessoryType = arrSelectedIDS.contains(where: { $0 == arrayValue[row].id }) ? .checkmark : .none
        tableCell.lblTitle.text = arrayValue[row].name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       isSearchbar ?  checkContainValue(arrayValue: userFilterData, tableView: tableViewSearch, row: indexPath.row) : checkContainValue(arrayValue: userData, tableView: tableViewSearch, row: indexPath.row)
    }
    
    func checkContainValue (arrayValue : [Data], tableView : UITableView, row:Int)
    {
        if arrSelectedIDS.contains(where: { $0 == arrayValue[row].id })
        {
            let indexOfArray = arrSelectedIDS.firstIndex(of: arrayValue[row].id)
            arrSelectedIDS.remove(at: indexOfArray!)
        }
        else{
            arrSelectedIDS.append((arrayValue[row].id)!)
        }
        tableView.reloadData()
    }
    
    
    //MARK:- SearchView Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchbar = searchText.count != 0 ? true : false
        if searchText.count != 0{
            userFilterData = userData.filter({ $0.name == searchText.lowercased()})
            print(userFilterData)
        }
        tableViewSearch.reloadData()
    }
    

}


