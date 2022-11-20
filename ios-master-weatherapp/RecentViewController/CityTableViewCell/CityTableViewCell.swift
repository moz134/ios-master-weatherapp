//
//  CityTableViewCell.swift
//  ios-master-weatherapp
//
//  Created by Md Mozammil on 19/11/22.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    @IBOutlet public var cityNameLbl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(str: String) {
        self.cityNameLbl?.text = str
    }

    
}
