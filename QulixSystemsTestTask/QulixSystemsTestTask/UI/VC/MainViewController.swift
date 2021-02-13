//
//  MainViewController.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/13/21.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var photos = [Photo]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PhotoInfoTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PhotoInfoTableViewCell.cellId)
        
    }


}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoInfoTableViewCell.cellId, for: indexPath) as? PhotoInfoTableViewCell
        else {
            fatalError("Can not find cell with id: \(PhotoInfoTableViewCell.cellId) at indexPath: \(indexPath)")
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
}

