//
//  CatsViewController.swift
//  cats
//
//  Created by Alan Rodriguez on 30/06/24.
//

import UIKit

class CatsViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem! {
        didSet {
            navBar.title = "Cats"
        }
    }
    
    @IBOutlet weak var catsTableView: UITableView! {
        didSet {
            catsTableView.delegate = self
            catsTableView.dataSource = self
        }
    }
    
    var viewModel: CatsViewModel!
    var cats: [Cat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CatsViewModel(view: self)
        viewModel.loadCats()
    }
}

extension CatsViewController: CatsView {
    func didSucceed(with cats: [Cat]) {
        self.cats = cats
        catsTableView.reloadData()
    }
    
    func didFailed(with error: String) {
        print(error)
    }
}

extension CatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = cats[indexPath.row].tags.joined(separator: ", ")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "CatsDetailsViewController") as? CatsDetailsViewController
        else { return }
        detailsViewController.viewModel = CatsDetailsViewModel(id: cats[indexPath.row].id, tags: cats[indexPath.row].tags)
        
        show(detailsViewController, sender: nil)
    }
}

