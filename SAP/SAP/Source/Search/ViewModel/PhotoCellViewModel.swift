//
//  PhotoCellViewModel.swift
//  SAPTest
//
//  Created by Hamza Ahmed on 31/01/2022.
//

import Foundation

struct PhotoCellViewModel{
    let photo : Photo
    func getImageLink()-> URL{
        return photo.getImageUrl()
    }
}
