//
//  ViewController.swift
//  BAHomeworkTask
//
//  Created by Nikolay N. Dutskinov on 15.12.22.
//

import UIKit

class PostsListViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: PostsListViewModel!
    let refreshControl = UIRefreshControl()
    var networker: Networker?
    var decoder: JSONDecoder?
    var dispatchGroup: DispatchGroup?
    
    static func create(with viewModel: PostsListViewModel) -> PostsListViewController {
        let view = PostsListViewController.instantiate()
        view.viewModel = viewModel
        
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
        LoadingView.show()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.didRefresh()
        LoadingView.show()
        
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 1.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: PostTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func bind(to viewModel: PostsListViewModel) {
        viewModel.error.observe(on: self) { [weak self] message in
            if !message.isEmpty {
                self?.showAlert(wtih: message)
            }
        }
        viewModel.posts.observe(on: self) { [weak self] posts in
            self?.updateItems()
        }
    }
    
    private func updateItems() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        LoadingView.hide()
    }
    
    private func showAlert(wtih messsage: String) {
        let alert = UIAlertController(title: "Oops there was a problem :(",
                                      message: messsage,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Refresh",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.viewModel.didRefresh()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PostsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PostTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(PostTableViewCell.self) with reuseIdentifier: \(PostTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        let viewModel = viewModel.posts.value[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.value.count
    }
    
}
