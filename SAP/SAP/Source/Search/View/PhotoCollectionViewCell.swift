//
//  PhotoCollectionViewCell.swift
//  SAPTest
//
//  Created by Hamza Ahmed on 31/01/2022.
//

import UIKit
import Kingfisher
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
