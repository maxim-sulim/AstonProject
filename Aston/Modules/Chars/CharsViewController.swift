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
    var countChars: Int? { get set }
}

final class CharsViewController: UIViewController {
    
//ссылки делегатов
    let configurator: CharsConfiguratorProtocol = CharsConfigurator()
    var presenter: CharsPresenterProtocol!
    
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
        configurator.configureController(with: self)
        setupView()
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
//MARK: - приватные свойства
    
//количество отображаемых ячеек на экране  + запас для плавной загрузки новых
    lazy private var screenCountRows: Int = {
        let reserve = Resources.LayoutView.CharsView.reserveRows
        return Int(view.bounds.height / Resources.LayoutView.CharsView.heightTableRow) + reserve
    }()
    
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
    
    private func setupView() {
        countChars = screenCountRows
        navigationBarSetup()
        makeConstrain()
    }
    
    private func makeConstrain() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func navigationBarSetup() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
}

//MARK: - реализация методов протокола

extension CharsViewController: CharsViewProtocol {
    
    func configureNavigationBar(title: String) {
        self.navigationItem.title = title
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
        presenter.showEpisodeScene(indexCell: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Resources.LayoutView.CharsView.heightTableRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countChars ?? Resources.LayoutView.CharsView.countRowNoneData
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CharsTableViewCell.description(), for: indexPath)
        as! CharsTableViewCell
        
        cell.presenter = self.presenter
        cell.indexCell = indexPath.row
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let reserve = Resources.LayoutView.CharsView.reserveRows
        
        if indexPath.row == self.countChars! - reserve {
            self.countChars! += screenCountRows
        }
        
    }
    
}
