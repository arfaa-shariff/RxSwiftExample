//
//  SearchViewController.swift
//  Rx
//
//  Created by Arfaa Nisar Shariff on 12/10/17.
//  Copyright © 2017 Arfaa Nisar Shariff. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewConroller: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Prague"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setupRx()
    }
    
    func setupRx(){
        tableView.dataSource = self
        searchBar
        .rx.text
        .orEmpty
        .debounce(0.5, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
            .filter{ !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                self.tableView.reloadData() // And reload table view data.
            })
            .addDisposableTo(disposeBag) //
    }
}
extension SearchViewConroller: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }
}
