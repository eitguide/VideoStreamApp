//
//  StreamCell.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol DownloadStreamDidTapDelegate: class {
    func downloadDidTap(index: Int)
}

class StreamCell: UITableViewCell {
    private let idLabel = UILabel()
    private let backgroundStreamView = UIImageView()
    private let videoNameLabel = UILabel()
    private let downloadButton = UIButton(type: .system)
    
    weak var delegate: DownloadStreamDidTapDelegate?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        visualize()
    }
    
    var stream: Stream? {
        didSet {
            guard let stream = stream else { return }
            idLabel.text = "Id: \(stream.id ?? 0)"
            videoNameLabel.text = stream.name
            backgroundStreamView.kf.setImage(with: URL(string: stream.backgroundImageUrl!))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
       
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupView() {
        contentView.addSubview(backgroundStreamView)
        contentView.addSubview(idLabel)
        contentView.addSubview(videoNameLabel)
        contentView.addSubview(downloadButton)
        
        
        backgroundStreamView.translatesAutoresizingMaskIntoConstraints = false
        videoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundStreamView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundStreamView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundStreamView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundStreamView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        videoNameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20).isActive = true
        videoNameLabel.topAnchor.constraint(equalTo: idLabel.topAnchor).isActive = true
        
        downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        downloadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func visualize() {
        
        selectionStyle = .none
        videoNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        videoNameLabel.textColor = .white
        
        backgroundStreamView.contentMode = .scaleAspectFill
        backgroundStreamView.clipsToBounds = true
        
        idLabel.font = UIFont.boldSystemFont(ofSize: 15)
        idLabel.textColor = .white
        
        downloadButton.tintColor = .white
        downloadButton.setImage(#imageLiteral(resourceName: "ic_download"), for: .normal)
        
        downloadButton.addTarget(self, action: #selector(downloadDidTap(_:)), for: .touchUpInside)
    }
    
    @objc func downloadDidTap(_ sender: UIButton) {
        delegate?.downloadDidTap(index: tag)
    }
}
