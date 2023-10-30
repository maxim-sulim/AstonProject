//
//  EpisodeCollectionCell.swift
//  Aston
//
//  Created by Максим Сулим on 14.10.2023.
//

import UIKit
import SnapKit

protocol EpisodeCollectionCellProtocol {
    func configureCell(model: EpisodeCellModel)
}

final class EpisodeCollectionCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        setupView()
    }
    
//MARK: - приватные свойства вию
    
    lazy private var mainContainer = UIView()
    
    private var nameEpisode: UILabel = {
        let label = UILabel()
        label.text = Resources.TitleView.EpisodesView.titleLabelName.rawValue
        label.textColor = Resources.Color.infoWhite
        return label
    }()
    
    private var numberEpisode: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13)
        label.font = font
        label.text = Resources.TitleView.EpisodesView.titleLabelNumber.rawValue
        label.textColor = Resources.Color.poisonousGreen
        return label
    }()
    
    private var dateEpisode: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13)
        label.font = font
        label.text = Resources.TitleView.EpisodesView.titleLabelDate.rawValue
        label.textAlignment = .right
        label.textColor = Resources.Color.infoLightGray
        return label
    }()
    
// MARK: - приватные установка вию
    
    private func setupView() {
        
        self.backgroundColor = Resources.Color.blackBackGround
        self.contentView.backgroundColor = Resources.Color.blackGrayBackGround
        self.contentView.layer.cornerRadius = 16
        self.contentView.addSubview(mainContainer)
        makeConstraint()
    }
    
    private func makeConstraint() {
        
        mainContainer.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.addArrangedSubview(numberEpisode)
        xStack.addArrangedSubview(dateEpisode)
        xStack.clipsToBounds = true
        xStack.distribution = .fillEqually
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.addArrangedSubview(nameEpisode)
        yStack.addArrangedSubview(xStack)
        yStack.alignment = .leading
        yStack.spacing = 16
        
        mainContainer.addSubview(yStack)
        
        yStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        xStack.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(0)
        }
    }
    
}


extension EpisodeCollectionCell: EpisodeCollectionCellProtocol {
    
    func configureCell(model: EpisodeCellModel) {
        nameEpisode.text = model.name
        numberEpisode.text = model.number
        dateEpisode.text = model.date
    }
    
}
