//
//  ContentViewController.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 03/03/22.
//

import UIKit

class ContentViewController: UIViewController, MyUIProtocol {
    
    var contents = DetailsContentPage()
    let contentTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupNav() {
        navigationItem.title = "Contents"
        navigationItem.backButtonTitle = "Back"
    }
    
    
    func setupUI() {
        view.addSubview(contentTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func loadView() {
        super.loadView()
        setupNav()
        setupUI()
        setupConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTableView.separatorStyle = .none
        contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default Cell")
        contentTableView.register(CustomCellUITable.self, forCellReuseIdentifier: "subMenu")
        contentTableView.register(MyCustomHeader.self,
                forHeaderFooterViewReuseIdentifier: "sectionHeader")
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.estimatedRowHeight = 600

    }

}


extension ContentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contents.details.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.details[section].items.isExpanded ?
            contents.details[section].cell.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = contents.details[indexPath.section].cell[indexPath.row] as? IHeader {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "subMenu", for: indexPath) as? CustomCellUITable
            cell?.dataArr = [data]
            return cell ?? UITableViewCell()
        }
        
        if let data = contents.details[indexPath.section].cell[indexPath.row] as? Cell {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "Default Cell", for: indexPath)
            cell.textLabel?.text = data.text
            cell.accessoryView = UIImageView(image: UIImage(named: "chevron.forward tertiary"))
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section)-\(indexPath.row):selected")
    }
}


extension ContentViewController: UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @objc func headerHandler(sender: UITapGestureRecognizer) {
        var indexPaths = [IndexPath]()
        let section: Int
        guard let senderView = sender.view as? MyCustomHeader else {
            return
        }
        section = senderView.tag
        for index in contents.details[section].cell.indices {
            let indexPath = IndexPath(row: index, section: section)
            print("row-\(index)")
            indexPaths.append(indexPath)
        }
        let isExpanded = contents.details[section].items.isExpanded
        contents.details[section].items.isExpanded.toggle()
        if isExpanded {
            senderView.button.setImage(UIImage(named: "chevron.forward"), for: .normal)
            contentTableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            senderView.button.setImage(UIImage(named: "chevron.down"), for: .normal)
            contentTableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "sectionHeader") as! MyCustomHeader
        view.title.text = contents.details[section].items.text
        view.image.image = UIImage(named: contents.details[section].items.image)
//        view.isUserInteractionEnabled = true
//        view.title.addTarget(self, action: #selector(headerHandler), for: .touchUpInside)
//        view.image.addTarget(self, action: #selector(headerHandler), for: .touchUpInside)
//        view.button.addTarget(self, action: #selector(headerHandler), for: .touchUpInside)
        view.tag = section
        let tapRecognizer = UITapGestureRecognizer(target: self,action: #selector(self.headerHandler(sender:)))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        return view
    }
}
