//
//  DetailsContentPage.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 11/03/22.
//

import Foundation

struct DetailsContentPage {
    var details: [UHeader]
    init() {
        let searchBarsHeader = Header(image: "Search Bars", text: "Search Bars")
        let searchBarsIHeader = IHeader(items: searchBarsHeader, cell: [Cell(text: "Default Search Bar"),Cell(text: "Custom Search Bar")])
        let pageControlsHeader = Header(image: "Page Controls", text: "Page Controls")
        let pageControlsIHeader = IHeader(items: pageControlsHeader, cell: [Cell(text: "Page Control"), Cell(text: "Custom Page Control")])
        let buttonsHeader = Header(image: "Buttons", text: "Buttons")
        let buttonsIHeder = IHeader(items: buttonsHeader, cell: [Cell(image: "Buttons Inner", text: "Buttons"),
                                                                Cell(image: "Menu Buttons", text: "Menu Buttons")])
        let extraCellsforSection1 = [Cell(text: "Segmented Controls"), Cell(text: "Sliders"), Cell(text: "Switches"), Cell(text: "Text Fields"), Cell(text: "Steppers")]
        let totalCellsforSection1 = [buttonsIHeder, pageControlsIHeader, searchBarsIHeader] + extraCellsforSection1
        
        
        
        let extraCellsforSection2_1 = [Cell(text: "Activity Indicators"), Cell(text: "Alert Controls"),Cell(text: "Text View")]
        
        let imageViewsHeader = Header(image: "Image Views", text: "Image Views")
        let imageViewsIHeader = IHeader(items: imageViewsHeader, cell: [Cell(text: "Image View"), Cell(text: "SF Symbols")])
        let extraCellsforSection2_2 = [Cell(text: "Progress Views"), Cell(text: "Stack Views")]
        let toolbarsHeader = Header(image: "Toolbars", text: "Toolbars")
        let toolbarsIHeader = IHeader(items: toolbarsHeader, cell: [Cell(text: "Default Toolbar"), Cell(text: "Tinted Toolbar"), Cell(text: "Custom Toolbar")])
        let extraCellsforSection2_3 = [Cell(text: "Visual Effect"), Cell(text: "Web Views")]
        let totalCellsforSection2 = extraCellsforSection2_1 + [imageViewsIHeader] + extraCellsforSection2_2 + [toolbarsIHeader] + extraCellsforSection2_3
        
        
        
        let totalCellsforSection3 = [Cell(text: "Data Picker"), Cell(text: "Color Picker"), Cell(text: "Font Picker"), Cell(text: "Image Picker"), Cell(text: "Picker View")]
        details = [
            UHeader(items: Header(image: "Controls", text: "Controls"), cell: totalCellsforSection1),
            UHeader(items: Header(image: "Views", text: "Views"), cell: totalCellsforSection2),
            UHeader(items: Header(image: "Pickers", text: "Pickers"), cell: totalCellsforSection3)
        ]
    }
}

struct Header {
    var image: String
    var text: String
    var isExpanded: Bool = true
}

struct UHeader {
    var items: Header
    var cell: [Any]
}

struct IHeader {
    var items: Header
    var cell: [Cell]
}
struct Cell {
    var image: String? = nil
    var text: String
}

//enum CellType: {
//    case defaultCell
//}
