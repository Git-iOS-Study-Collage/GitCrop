//
//  PHAssetManager.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import UIKit
import Photos

/// 사진 라이브러리 불러오기 담당 Manager

final class PHAssetManager {
    static let shared = PHAssetManager()
    private var storedPHImages: [PHImage] = []
    
    var configs = PHAssetConfiguration.default()
    
    var phFetchOptions: PHFetchOptions {
        get {
            configs.phFetchOptions
        }
        set {
            configs.phFetchOptions = newValue
        }
    }
    
    var imageRequestOptions: PHImageRequestOptions {
        get {
            configs.imageRequestOptions
        }
        set {
            configs.imageRequestOptions = newValue
        }
    }
    
    var imageRequestMiniOption: PHImageRequestOptions {
        get {
            configs.imageRequestMiniOptions
        }
        set {
            configs.imageRequestMiniOptions = newValue
        }
    }
    
    var targetSize: CGSize {
        get {
            configs.targetSize
        }
        set {
            configs.targetSize = newValue
        }
    }
    
    var livePhotoRequestOptions: PHLivePhotoRequestOptions {
        get {
            return configs.livePhotoRequestOptions
        }
        set {
            configs.livePhotoRequestOptions = newValue
        }
    }
    
    var videoRequestOptions: PHVideoRequestOptions {
        get {
            return configs.videoRequestOptions
        }
        set {
            configs.videoRequestOptions = newValue
        }
    }
    
    var albumTypeList: [PHFetchResult<PHAssetCollection>] {
        return configs.albumType
    }
}

extension PHAssetManager {
    func getPHAssetCollection() -> [PHCollection] {
        var allAssetCollections = [PHCollection]()
        
        PHAssetCollection
            .fetchTopLevelUserCollections(with: nil)
            .enumerateObjects { assetCollection, _, _ in
                allAssetCollections.append(assetCollection)
            }
        return allAssetCollections
    }
    
    func getPHAssets(with mediaType: PHAssetMediaType) -> [PHAsset] {
        var allAssets: [PHAsset] = []
        PHAsset.fetchAssets(with: mediaType, options: phFetchOptions).enumerateObjects { asset, _, _ in
            allAssets.append(asset)
        }
        return allAssets
    }
    
    func getImage(asset: PHAsset, completion: @escaping(UIImage?) -> Void) {
        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: size,
                                              contentMode: .aspectFill,
                                              options: imageRequestOptions) { image, _ in
            completion(image)
        }
    }
    
    
    func getPHAssetAlbumList() async -> [AssetAlbum] {
        var albums = [AssetAlbum]()
        for albumType in albumTypeList {
            albumType.enumerateObjects { album, _, _ in
                let title = album.localizedTitle ?? "제목없음"
                var thumbnailAsset = PHAsset()
                let fetchResult = PHAsset.fetchAssets(in: album, options: self.phFetchOptions)
                let albumCount = fetchResult.count
                if albumCount > 0 {
                    switch album.assetCollectionType {
                    case .album:
                        thumbnailAsset = fetchResult.firstObject!
                    default:
                        thumbnailAsset = fetchResult.lastObject!
                    }
                    let list = fetchResult.objects(at: IndexSet(0..<albumCount))
                    let assetAlbum = AssetAlbum(asset: thumbnailAsset,
                                                albumTitle: title.localTitleConfirm(),
                                                count: albumCount,
                                                phAssetCollection: list)
                    albums.append(assetAlbum)
                }
            }
        }
        return albums
    }
    
    func getImage(asset: PHAsset) async -> UIImage? {
        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        return await withCheckedContinuation { continuation in
            PHImageManager.default().requestImage(for: asset,
                                                  targetSize: size,
                                                  contentMode: .aspectFill,
                                                  options: imageRequestOptions) { image, _ in
                continuation.resume(returning: image)
            }
        }
    }
    
    func getImageList(
        assetList: [PHAsset],
        contentMode: PHImageContentMode = .aspectFit,
        targetSize: CGSize = CGSize(width: 200, height: 200)
    ) async -> [PHImage] {
        var phImages = [PHImage]()
        for asset in assetList {
            if let image = await withCheckedContinuation({ continuation in
                PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: self.imageRequestOptions) { image, _ in
                    continuation.resume(returning: image)
                }
            }) {
                let phImage = PHImage(asset: asset, image: image)
                phImages.append(phImage)
            }
        }
        return phImages
    }
}
