//
//  CharsTableViewCell.swift
//  Aston
//
//  Created by Максим Сулим on 10.10.2023.
//

import UIKit
import SnapKit

protocol CharsViewCellProtocol: AnyObject {
    func configureCell(with model: ModelChar)
}

// Модуель данных для вию

struct ModelChar {
    var name: String
    var status: String
    var imageUrl: String
    var image: Data?
}

class CharsTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureDefCell()
    }

   
//MARK: - экземпляры вию
    
    private var imageChar: UIImageView = {
        
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        return view
    }()
    
    private var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
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
    
//MARK: - методы установки данных для вию
    
    private func setNameChar(text: String) {
        self.nameChar.text = text
    }
    
    private func setStatusChar(text: String) {
        self.statusChar.text = text
    }
    
    private func setImageChar(imageData: Data?) {
        
        guard let imageData = imageData else {
            return
        }
        
        let image = UIImage(data: imageData)
        self.imageChar.image = image
        
    }
    
    
//MARK: - метод конфигурации вию
    
    private func configureDefCell() {
        self.backgroundColor = Resources.Color.blackBackGround
        makeConstraint()
    }
    
    private func makeConstraint() {
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.alignment = .trailing
        yStack.distribution = .fillEqually
        yStack.spacing = 8
        
        yStack.addArrangedSubview(nameChar)
        yStack.addArrangedSubview(statusChar)
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.distribution = .equalSpacing
        xStack.spacing = 10
        xStack.layer.cornerRadius = 10
        
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
            make.height.width.equalTo(Resources.LayoutView.CharsView.heightWidhtImageChar)
        }
        
    }

}

//MARK - методы протокола

extension CharsTableViewCell: CharsViewCellProtocol {
    
    func configureCell(with model: ModelChar) {
        setNameChar(text: model.name)
        setStatusChar(text: model.status)
        setImageChar(imageData: model.image)
    }
}
