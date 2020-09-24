//
//  Websites.swift
//  links
//
//  Created by Saman on 29/03/2020.
//  Copyright © 2020 Samans. All rights reserved.
//

import Foundation

public class WebsiteList {
    private var urls: [URL?]
    
    public init(_ urls: [URL?]) {
        self.urls = urls
    }
    
    public func getWebsiteCount() -> Int {
        return urls.count
    }
    
    public func getWebsite(_ position: Int) -> URL? {
        return urls[position]
    }
    
    public func getWebsiteList() -> [URL?] {
        return urls
    }
    
    public func setWebsite(_ url: URL?,_ position: Int) {
        urls[position] = url
    }
    
    public func addWebsite() {
        urls.append(nil)
    }
}
