//
//  ViewController.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 03/03/22.
//

import UIKit

class MainViewController: UIViewController, MyUIProtocol {

    let openUIKitButton: UIButton = {
        let someButton = UIButton(type: .system)
        someButton.translatesAutoresizingMaskIntoConstraints = false
        someButton.backgroundColor = UIColor.homeButton
        someButton.setTitle("OpenTheBook", for: .normal)
        someButton.layer.cornerRadius = 5
        someButton.setTitleColor(UIColor.darkText, for: .normal)
        someButton.addTarget(self, action: #selector(goToContentViewController), for: .touchUpInside)
        return someButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        super.loadView()
        setupNav()
        setupUI()
        setupConstraints()
    }
    
    
    func setupNav() {
        navigationItem.title = "UIBook"
    }
    
    func setupUI() {
        view.addSubview(openUIKitButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            openUIKitButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            openUIKitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
    }
    
    @objc func goToContentViewController() {
        performSegue(withIdentifier: "goToContentViewController", sender: .none)
    }
}


