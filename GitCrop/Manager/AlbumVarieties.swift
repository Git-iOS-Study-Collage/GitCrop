//
//  AlbumVarieties.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import Photos

final class AlbumVarieties {
    private let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
    private let smartAlbumPanoramas = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumPanoramas, options: nil)
    private let smartAlbumFavorites = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
    private let smartAlbumSelfPortraits = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumSelfPortraits, options: nil)
    private let smartAlbumScreenshots = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumScreenshots, options: nil)
    private let smartAlbumBursts = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumBursts, options: nil)
    private let cameraroll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
    
    lazy var albumList =  [cameraroll,
                           smartAlbumSelfPortraits,
                           smartAlbumFavorites,
                           smartAlbumBursts,
                           smartAlbumPanoramas,
                           smartAlbumScreenshots,
                           customAlbums]
}
