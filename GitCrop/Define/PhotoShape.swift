//
//  PhotoShape.swift
//  GitCrop
//
//  Created by dev dfcc on 8/2/24.
//

import UIKit

protocol PhotoShape {
    var photoCount: Int { get }
    var title: String { get }
    var imageName: String { get }
    var shapeType: ShapeType { get }
}

enum ShapeType {
    case vertical
    case square
    case horizontal
}

struct FourVertical: PhotoShape {
    let photoCount: Int
    let title: String
    let imageName: String
    let shapeType: ShapeType
    
    init(
        photoCount: Int = 4,
        title: String = "인생네컷",
        imageName: String = "FourVertical",
        shapeType: ShapeType = .vertical
    ) {
        self.photoCount = photoCount
        self.title = title
        self.imageName = imageName
        self.shapeType = shapeType
    }
}

struct FourWindow: PhotoShape {
    let photoCount: Int
    let title: String
    let imageName: String
    let shapeType: ShapeType
    
    init(
        photoCount: Int = 4,
        title: String = "창문형",
        imageName: String = "FourWindow",
        shapeType: ShapeType = .square
    ) {
        self.photoCount = photoCount
        self.title = title
        self.imageName = imageName
        self.shapeType = shapeType
    }
}
