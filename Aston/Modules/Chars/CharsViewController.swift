//
//  CharsViewController.swift
//  Aston
//
//  Created by Максим Сулим on 10.10.2023.
//

import UIKit

protocol CharsViewProtocol: AnyObject {
    func configureNavigationBar(title: String)
    func reloadTable()
    func reloadTableRow(indexPath: IndexPath)
    var countChars: Int? { get set }
    var cellView: CharsViewCellProtocol? { get set }
}

final class CharsViewController: UIViewController {
    
//ссылки делегатов
    let configurator: CharsConfiguratorProtocol = CharsConfigurator()
    var presentor: CharsPresentorProtocol!
    var cellView: CharsViewCellProtocol?
    
// свойство протокола
    var countChars: Int? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurator.configureController(with: self)
        presentor.configureView()
    }
    
//MARK: - приватные свойства
    
   lazy private var tableView: UITableView = {
       
       let table = UITableView()
       table.backgroundColor = Resources.Color.blackBackGround
       table.delegate = self
       table.dataSource = self
       table.register(CharsTableViewCell.self,
                      forCellReuseIdentifier: CharsTableViewCell.description())
       
        return table
    }()
    
//MARK: - приватные методы
    
   private func configure() {
       makeConstrain()
    }
    
    
    private func makeConstrain() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

//MARK: - реализация методов протокола

extension CharsViewController: CharsViewProtocol {
    
    func reloadTableRow(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func configureNavigationBar(title: String) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - методы делегата таблицы

extension CharsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Resources.LayoutView.CharsView.heightTableRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countChars ?? Resources.LayoutView.CharsView.countRowNoneData
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharsTableViewCell.description(), for: indexPath) as! CharsTableViewCell
        cellView = cell.self
        let model = presentor.configureViewCell(indexPath: indexPath)
        cellView?.configureCell(with: model)
        return cell
    }
    
}
