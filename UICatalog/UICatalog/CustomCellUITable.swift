//
//  CustomCell.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 09/03/22.
//

import Foundation
import UIKit

protocol InnerProtocol: AnyObject {
    func reloadCell(_ cell: CustomCellUITable)
}


class CustomCellUITable: UITableViewCell {
    
    var cellsData: [Cell] = []
    var iHeader: Header?
    weak var delegate: InnerProtocol?
    var subMenuTable: AutoSizingTableView = {
        let someInnerView = AutoSizingTableView()
        someInnerView.translatesAutoresizingMaskIntoConstraints = false
        someInnerView.separatorStyle = .none
        someInnerView.isScrollEnabled = false
        return someInnerView
    }()
    
    func setupUI() {
        contentView.addSubview(subMenuTable)
    }
    func setupConstraints() {
        let superviewMargin = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            subMenuTable.topAnchor.constraint(equalTo:superviewMargin.topAnchor),
            subMenuTable.bottomAnchor.constraint(equalTo:superviewMargin.bottomAnchor),
            subMenuTable.leadingAnchor.constraint(equalTo:superviewMargin.leadingAnchor, constant: 20),
            subMenuTable.trailingAnchor.constraint(equalTo:superviewMargin.trailingAnchor)
        ])
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
}


class AutoSizingTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}

extension CustomCellUITable: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("------\(iHeader?.text)")
        let row = iHeader?.isExpanded ?? false ? cellsData.count : 0
        return row
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}


extension CustomCellUITable: UITableViewDelegate {
    
    @objc func headerHandler(sender: UITapGestureRecognizer) {
        var indexPaths = [IndexPath]()
        let section: Int
        guard let senderView = sender.view as? MyCustomHeader else {
            return
        }
        section = senderView.tag
        for index in cellsData.indices {
            let indexPath = IndexPath(row: index, section: section)
            indexPaths.append(indexPath)
        }
        guard let isExpanded = iHeader?.isExpanded else {
            return
        }
        iHeader?.isExpanded.toggle()
        self.subMenuTable.beginUpdates()
        if isExpanded{
            senderView.button.setImage(UIImage(named: "chevron.forward"), for: .normal)
            subMenuTable.deleteRows(at: indexPaths, with: .none)
            print("delete")
        } else {
            senderView.button.setImage(UIImage(named: "chevron.down"), for: .normal)
            subMenuTable.insertRows(at: indexPaths, with: .none)
            print("insert")
        }
        subMenuTable.reloadSections([section], with: .none)
        if let delegate = delegate {
            delegate.reloadCell(self)
        }
        self.subMenuTable.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "sectionHeader") as! MyCustomHeader
        
        view.title.text = iHeader?.text
        view.image.image = UIImage(named: iHeader?.image ?? "image")
        if ((iHeader?.isExpanded) != nil) {
            view.button.setImage(UIImage(named: "chevron.down"), for: .normal)
        } else {
            view.button.setImage(UIImage(named: "chevron.forward"), for: .normal)
        }
        view.tag = section
        let tapRecognizer = UITapGestureRecognizer(target: self,action: #selector(headerHandler))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subMenuTable.dequeueReusableCell(withIdentifier: "subMenu", for: indexPath)
        cell.textLabel?.text = cellsData[indexPath.row].text
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron.forward tertiary"))
        return cell
    }
}


