//
//  EpisodeViewController.swift
//  Aston
//
//  Created by Максим Сулим on 13.10.2023.
//

import Foundation
import UIKit
import SnapKit


protocol EpisodeViewProtocol: AnyObject {
    func configureView(episodes: [String])
    var countEpisode: Int { get set }
}

final class EpisodeViewController: UIViewController {
    
    var presenter: EpisodePresenterProtocol!
    let configurator: EpisodeConfiguratorProtocol = EpisodeConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    var countEpisode = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Resources.Color.blackBackGround
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = Resources.Color.blackBackGround
        view.addSubview(collectionView)
        collectionView.register(EpisodeCollectionCell.self,
                                forCellWithReuseIdentifier: EpisodeCollectionCell.description())
        makeConstraint()
    }
    
    private func makeConstraint() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}

extension EpisodeViewController: EpisodeViewProtocol {
    
    func configureView(episodes: [String]) {
        configurator.configureView(with: self)
        presenter.loadEpisode(episodes: episodes)
    }
    
}

extension EpisodeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countEpisode
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionCell.description(), for: indexPath) as! EpisodeCollectionCell
        
        cell.configureCell(model: presenter.configureViewCell(indexCell: indexPath.row))
        
        return cell
    }
    
}

extension EpisodeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let width = collectionView.bounds.width - Resources.LayoutView.EpisodeView.spaceCollectionRow
        let height = Resources.LayoutView.EpisodeView.heightCollectionRow
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let insets = Resources.LayoutView.EpisodeView.collectionLayoutInsets
        let edgeInsets = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Resources.LayoutView.EpisodeView.spacingForSection
    }
    
}


