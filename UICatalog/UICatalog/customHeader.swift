//
//  customHeader.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 08/03/22.
//

import Foundation
import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    let title: UILabel = {
        let somelabel = UILabel()
        somelabel.font = UIFont.boldSystemFont(ofSize: 17)
        somelabel.translatesAutoresizingMaskIntoConstraints = false
        return somelabel
    }()
    
    let image: UIImageView = {
        let someImageView = UIImageView()
        someImageView.translatesAutoresizingMaskIntoConstraints = false
        return someImageView
    }()
    
    let button: UIButton = {
        let someButton = UIButton()
        someButton.translatesAutoresizingMaskIntoConstraints = false
        someButton.setImage(UIImage(named: "chevron.down"), for: .normal)
        return someButton
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(button)
    }
    func configureContents() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 20),            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                   constant: 8),
            title.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor,
                                            constant: 4),
            button.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
}
                                                

