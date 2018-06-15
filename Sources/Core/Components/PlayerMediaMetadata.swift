// The MIT License (MIT)
//
// ModernAVPlayer
// Copyright (c) 2018 Raphael Ankierman <raphael.ankierman@radiofrance.com>
//
// PlayerMediaMetadata.swift
// Created by Jean-Charles Dessaint on 12/06/2018.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import AVFoundation

public protocol PlayerMediaMetadata: CustomStringConvertible {
    var title: String? { get }
    var artist: String? { get }
    var albumTitle: String? { get }
    var localPlaceHolderImageName: String? { get }
    var remoteImageUrl: URL? { get }
}

public struct ModernAVPlayerMediaMetadata: PlayerMediaMetadata {
    public let title: String?
    public let albumTitle: String?
    public let artist: String?
    public let localPlaceHolderImageName: String?
    public let remoteImageUrl: URL?
    
    public init(title: String? = nil,
                albumTitle: String? = nil,
                artist: String? = nil,
                localImageName: String? = nil,
                remoteImageUrl: URL? = nil) {
        self.title = title
        self.albumTitle = albumTitle
        self.artist = artist
        self.localPlaceHolderImageName = localImageName
        self.remoteImageUrl = remoteImageUrl
    }
    
    public var description: String {
        let debug = "title: \(title ?? "nil") | album: \(albumTitle ?? "nil") | artist: \(artist ?? "nil") | "
                    + "localImage: \(localPlaceHolderImageName ?? "nil") | remoteImage: \(remoteImageUrl?.description ?? "nil")"
        return debug
    }
}
