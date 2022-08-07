//
//  UIImageView-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

extension UIImageView {
    
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let mimeType = response.mimeType, mimeType.hasPrefix("image"), let data = data else { return }
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func download(from link: String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: contentMode)
    }
}
