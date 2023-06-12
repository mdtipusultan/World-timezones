//
//  TimeZoneCollectionViewCell.swift
//  TimeZoneOFDifferentCountries
//
//  Created by Tipu on 16/5/23.
//

import UIKit

class TimeZoneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var AMPM: UILabel!
    @IBOutlet weak var gtmtimes: UILabel!
    @IBOutlet weak var cityTimes: UILabel!
    
    @IBOutlet weak var cityTimeLeadingConstraint: NSLayoutConstraint!
    
    func resetCell() {
        contentView.subviews.forEach { subview in
            if subview.tag == 999 { // Adjust the tag value based on your implementation
                subview.removeFromSuperview()
            }
        }
        
        lable.text = nil
        gtmtimes.text = nil
        cityTimes.text = nil
        AMPM.text = nil
        dates.text = nil
    }
}
