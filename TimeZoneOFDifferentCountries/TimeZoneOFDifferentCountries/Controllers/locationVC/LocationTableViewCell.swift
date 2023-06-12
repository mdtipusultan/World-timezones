//
//  LocationTableViewCell.swift
//  TimeZoneOFDifferentCountries
//
//  Created by Tipu on 16/5/23.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var countryLable: UILabel!
    @IBOutlet weak var timeGTM: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
                   tintColor = UIColor.brown
               } else {
                   tintColor = UIColor.white
               }
    }
    
    func configureCell(cityName: String, countryName: String, gmtOffset: Int) {
        lable.text = cityName
        countryLable.text = countryName
        timeGTM.text = "GMT \(gmtOffset > 0 ? "+" : "")\(gmtOffset)"
        }

}
