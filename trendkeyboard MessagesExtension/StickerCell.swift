//
//  Custume.swift
//  trendkeyboard MessagesExtension
//
//  Created by Kaya Jones on 11/11/20.
//

import UIKit
import Messages

class StickerCell: UICollectionViewCell {
    
    
    private var stickerName: String?
    
    
    private let mySticker: MSStickerView = {
        let stickerView = MSStickerView()
        stickerView.translatesAutoresizingMaskIntoConstraints = false
        stickerView.contentMode = .scaleAspectFit
        stickerView.clipsToBounds = true

        return stickerView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mySticker)
        mySticker.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        mySticker.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        mySticker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        mySticker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with stickerURL : URL ) {

        mySticker.sticker =  try? MSSticker( contentsOfFileURL: stickerURL, localizedDescription: stickerURL.absoluteString)
        
        stickerName = stickerURL.absoluteString
        
        
    }
    
   
}

