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
    

    var myArray : [[String:String]] = [["name": "surender",
                                         "age": "29",
                                         "id": "1",], ["name": "sunny",
                                                       "age": "25",
                                                       "id": "2",], ["name": "sohan",
                                                                     "age": "23",
                                                                     "id": "3",]]
    var myFilterArray : [[String:String]] = []
    var arrSelectedIDS : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- TableView Delegate & DateSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchbar ? myFilterArray.count : myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableViewSearch.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? tableSearchCell)!
        isSearchbar ? checkCellValue(arrayValue: myFilterArray, tableCell: cell, row: indexPath.row) :  checkCellValue(arrayValue: myArray, tableCell: cell, row: indexPath.row)
        return cell
    }
    
    func checkCellValue (arrayValue : [[String:String]], tableCell : tableSearchCell, row : Int)
    {
        tableCell.accessoryType = arrSelectedIDS.contains(where: { $0 == arrayValue[row]["id"] }) ? .checkmark : .none
        tableCell.lblTitle.text = arrayValue[row]["name"]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       isSearchbar ?  checkContainValue(arrayValue: myFilterArray, tableView: tableViewSearch, row: indexPath.row) : checkContainValue(arrayValue: myArray, tableView: tableViewSearch, row: indexPath.row)
    }
    
    func checkContainValue (arrayValue : [[String:String]], tableView : UITableView, row:Int)
    {
        if arrSelectedIDS.contains(where: { $0 == arrayValue[row]["id"] })
        {
            let indexOfArray = arrSelectedIDS.firstIndex(of: arrayValue[row]["id"]!)
            arrSelectedIDS.remove(at: indexOfArray!)
        }
        else{
            arrSelectedIDS.append((arrayValue[row]["id"])!)
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
            myFilterArray = myArray.filter({ $0["name"] == searchText.lowercased()})
            print(myFilterArray)
        }
        tableViewSearch.reloadData()
    }
    

}

