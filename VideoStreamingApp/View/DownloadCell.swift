//
//  DownloadCell.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/19/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import UIKit

class DownloadCell: UICollectionViewCell {
    
    let thumbStreamImageView = UIImageView()
    let playImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(thumbStreamImageView)
        contentView.addSubview(playImageView)
        
        thumbStreamImageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func visualize() {
       
    }
}
