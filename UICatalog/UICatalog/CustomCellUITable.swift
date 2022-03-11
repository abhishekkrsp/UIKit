//
//  CustomCell.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 09/03/22.
//

import Foundation
import UIKit

class CustomCellUITable: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    var dataArr: [IHeader] = []
    var subMenuTable: UITableView = {
        let someInnerView = UITableView()
        someInnerView.translatesAutoresizingMaskIntoConstraints = false
        someInnerView.separatorStyle = .none
        someInnerView.isScrollEnabled = false
        return someInnerView
    }()
    override func layoutSubviews() {
          super.layoutSubviews()
        subMenuTable.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width-5, height: self.bounds.size.height-5)
      }
    
    func setupUI() {
        contentView.addSubview(subMenuTable)
    }
    func setupConstraints() {
        let superviewMargin = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 132),
            subMenuTable.topAnchor.constraint(equalTo:superviewMargin.topAnchor),
            subMenuTable.bottomAnchor.constraint(equalTo:superviewMargin.bottomAnchor),
            subMenuTable.leadingAnchor.constraint(equalTo:superviewMargin.leadingAnchor, constant: 20),
            subMenuTable.trailingAnchor.constraint(equalTo:superviewMargin.trailingAnchor)
        ])
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print(contentView.frame.height)

        setupUI()
        setupConstraints()
        subMenuTable.register(UITableViewCell.self, forCellReuseIdentifier: "subMenu")
        subMenuTable.register(MyCustomHeader.self,
                forHeaderFooterViewReuseIdentifier: "sectionHeader")
        subMenuTable.delegate = self
        subMenuTable.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.section)..\(indexPath.row)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArr[section].items.isExpanded ? dataArr[0].cell.count : 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func headerHandler(sender: UITapGestureRecognizer) {
        var indexPaths = [IndexPath]()
        let section: Int
        guard let senderView = sender.view as? MyCustomHeader else {
            return
        }
        section = senderView.tag
        for index in dataArr[section].cell.indices {
            let indexPath = IndexPath(row: index, section: section)
            print("row-\(index)")
            indexPaths.append(indexPath)
        }
        let isExpanded = dataArr[section].items.isExpanded
        dataArr[section].items.isExpanded.toggle()
        if isExpanded {
            senderView.button.setImage(UIImage(named: "chevron.forward"), for: .normal)
            subMenuTable.deleteRows(at: indexPaths, with: .fade)
        } else {
            senderView.button.setImage(UIImage(named: "chevron.down"), for: .normal)
            subMenuTable.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "sectionHeader") as! MyCustomHeader
        view.title.text = dataArr[0].items.text
        view.image.image = UIImage(named:dataArr[0].items.image)
        view.tag = section
        let tapRecognizer = UITapGestureRecognizer(target: self,action: #selector(headerHandler))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subMenuTable.dequeueReusableCell(withIdentifier: "subMenu", for: indexPath)
        print(indexPath.row + 1)
        cell.textLabel?.text = dataArr[0].cell[indexPath.row].text
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron.forward tertiary"))
        return cell
    }
}

