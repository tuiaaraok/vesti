//
//  ViewController.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit
import BonsaiController

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var errorLabel: UILabel!
    
    private var myRefreshControl = UIRefreshControl()
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(configureErrorLabel(notification:)), name: NSNotification.Name(rawValue: "configureErrorLabel"), object: nil)
        
        viewModel = ViewModel()
        errorLabel.isHidden = true
        tableView.rowHeight = 107
        
        myRefreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        DataFetcherService.shared.fetchData(completion: fetch)
    }
    
    @objc func loadList(notification: NSNotification){
        self.tableView.reloadData()
    }
    
    @objc func configureErrorLabel(notification: NSNotification){
        errorLabel.isHidden = false
        errorLabel.text = "В этой категории пока нет новостей"
    }
    
    func fetch() {
         OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        
        if let rssItems = DataFetcherService.shared.rssItems {
            DataFetcherService.shared.fetchData(completion: fetch)
            guard let viewModel = viewModel else { return }
            if let category = viewModel.category {
                ViewModel.filteredItems = rssItems.filter{$0.category == category.rawValue}
                tableView.reloadData()
            }
            sender.endRefreshing()
        }
    }
    
    // MARK: - Table view data sourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tableViewNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell
        guard let cell = tableViewCell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.tableViewCellViewModel(forIndexPath: indexPath)

        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.tableViewSelectRow(atIndexPath: indexPath)
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let viewModel = viewModel else { return }
        if let detailVC = segue.destination as? DetailVC {
            guard segue.identifier == "detail" else { return }
            detailVC.viewModel = viewModel.tableViewViewModelForSelectedRow()
        }
        
        if segue.destination is CategoryViewController {
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
    }
}

extension NewsVC: BonsaiControllerDelegate {

    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
    
        return CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: containerViewFrame.width / 2, height: containerViewFrame.height))
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BonsaiController(fromDirection: .left, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
    }
}
