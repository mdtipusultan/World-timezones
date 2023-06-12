//
//  CustomCollectionViewLayout.swift
//  TimeZoneOFDifferentCountries
//
//  Created by Tipu on 16/5/23.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    var isGrid: Bool = true
    
    override func prepare() {
        super.prepare()
        updateLayout()
    }
    
    func updateLayout() {
        if isGrid {
            let columns: CGFloat = 2
            let spacing: CGFloat = 0
            let itemSize = CGSize(width: (collectionView!.bounds.width - spacing * (columns - 1)) / columns, height: collectionView!.bounds.height * 0.35)
            self.itemSize = itemSize
            self.minimumInteritemSpacing = spacing
            self.minimumLineSpacing = spacing
            self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            
        } else {
            let spacing: CGFloat = 0
            let itemSize = CGSize(width: collectionView!.bounds.width - spacing * 2, height: collectionView!.bounds.height * 0.17)
            self.itemSize = itemSize
            self.minimumInteritemSpacing = spacing
            self.minimumLineSpacing = spacing
            self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        }
    }
}
