//
//  CharsTableViewCell.swift
//  Aston
//
//  Created by Максим Сулим on 10.10.2023.
//

import UIKit
import SnapKit

class CharsTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

//Public properties
    
    var presenter: CharsPresenterProtocol?
    var indexCell: Int?
   
//MARK: - экземпляры вию
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private var imageChar: UIImageView = {
        
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = Resources.LayoutView.CharsView.corRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Resources.LayoutView.CharsView.corRadius
        view.backgroundColor = Resources.Color.blackGrayBackGround
        return view
    }()
    
    private var nameChar: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = Resources.Color.infoLightGray
        return label
    }()
    
    private var statusChar: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = Resources.Color.poisonousGreen
        return label
    }()
    
    private var genderChar: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Color.infoLightGray
        return label
    }()
    
//MARK: - методы установки данных для вию
    
    private func setNameChar(text: String) {
        self.nameChar.text = text
    }
    
    private func setStatusChar(text: String) {
        self.statusChar.text = text
    }
    
    private func setGenderChar(text: String) {
        self.genderChar.text = text
    }
    
    private func setImageChar(imageData: Data?) {
        
        guard let data = imageData else { return }
        configureActivityInd()
        
        let image = UIImage(data: data)
        self.imageChar.image = image
        
        if Resources.TitleView.CharsView.nonDataImage == data {
            
            imageChar.addSubview(activityIndicator)
            activityIndicator.frame = imageChar.bounds
            activityIndicator.startAnimating()
            
        } else {
            
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
    }
    
//MARK: - метод конфигурации вию
    
    private func setupView() {
        
        self.backgroundColor = Resources.Color.blackBackGround
        makeConstraint()
        
        if let index = indexCell {
            guard let model = presenter?.getModelViewCell(indexCell: index) else { return }
            configureCell(with: model)
        }
    }
    
    private func configureActivityInd() {
        self.activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0)
        self.activityIndicator.color = Resources.Color.poisonousGreen
        self.activityIndicator.style = .medium
    }
    
   private func configureCell(with model: ModelChar) {
        setNameChar(text: model.name)
        setStatusChar(text: model.status)
        setImageChar(imageData: model.image)
        setGenderChar(text: model.gender)
    }
    
    private func makeConstraint() {
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .trailing
        yStack.distribution = .fillEqually
        yStack.spacing = 8
        
        yStack.addArrangedSubview(nameChar)
        yStack.addArrangedSubview(genderChar)
        yStack.addArrangedSubview(statusChar)
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.distribution = .equalSpacing
        xStack.spacing = 10
        xStack.layer.cornerRadius = Resources.LayoutView.CharsView.corRadius
        
        xStack.addArrangedSubview(imageChar)
        xStack.addArrangedSubview(yStack)
        
        contentView.addSubview(mainView)
        mainView.addSubview(xStack)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        imageChar.snp.makeConstraints { make in
            make.height.width.equalTo(Resources.LayoutView.CharsView.boundsImageChar.height)
        }
        
    }

}



