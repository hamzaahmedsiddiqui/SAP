//
//  PhotoCollectionViewCell.swift
//  SAP
//
//  Created by Hamza Ahmed on 31/01/2022.
//

import UIKit
import Kingfisher

/*
 I used Kingfisher because it is a powerful, pure-Swift library for downloading and caching images from the web.
 */
class PhotoCollectionViewCell: UICollectionViewCell {
    let placeholderImage = "placeholder-image"
    @IBOutlet weak var imageView: UIImageView!
    var cellViewModel : PhotoCellViewModel!{
        didSet{
            configCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private func configCell(){
        imageView.kf.setImage(
            with: cellViewModel.getImageLink(),
            placeholder: UIImage(named: placeholderImage),
            options: [
                .cacheOriginalImage
            ])
    }
}
