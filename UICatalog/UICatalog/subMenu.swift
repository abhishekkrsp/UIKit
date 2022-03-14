//
//  InnerView.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 10/03/22.
//

import Foundation
import UIKit

class InnerView: UITableView  {
    
    var subMenuTable: UITableView = {
        let someInnerView = UITableView()
        someInnerView.translatesAutoresizingMaskIntoConstraints = false
        someInnerView.isScrollEnabled = false
        return someInnerView
    }()
//    override init
}
