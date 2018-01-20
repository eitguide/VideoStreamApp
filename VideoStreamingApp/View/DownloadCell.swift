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
    
    var stream: Stream? {
        didSet {
            if let data = stream {
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("NghiaNV-setupViewDownloadCell")
        setupView()
        visualize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(thumbStreamImageView)
        contentView.addSubview(playImageView)
        
        thumbStreamImageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbStreamImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbStreamImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        thumbStreamImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbStreamImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        playImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        playImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        playImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playImageView.heightAnchor.constraint(equalTo: playImageView.widthAnchor).isActive = true
    }
    
    
    func visualize() {
        contentView.backgroundColor = .green
        playImageView.image?.withRenderingMode(.alwaysTemplate)
        playImageView.image = #imageLiteral(resourceName: "play_stream")
        playImageView.tintColor = .white
        playImageView.contentMode = .scaleToFill
        playImageView.clipsToBounds = true
    }
}
