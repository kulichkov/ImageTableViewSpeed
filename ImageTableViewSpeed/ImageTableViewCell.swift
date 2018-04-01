//
//  ImageTableViewCell.swift
//  ImageTableViewSpeed
//
//  Created by Mikhail Kulichkov on 31/03/2018.
//  Copyright © 2018 Mikhail Kulichkov. All rights reserved.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    
    private let urlSession: URLSession = URLSession(configuration: .ephemeral)
    private var imageTask: URLSessionDataTask? = nil
    private let lblSize: UILabel = UILabel()
    private let imgImage: UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgImage)
        
        imgImage.contentMode = .scaleAspectFill
        imgImage.clipsToBounds = true
        
        imgImage.translatesAutoresizingMaskIntoConstraints = false
        imgImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imgImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imgImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imgImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(lblSize)
        
        lblSize.textAlignment = .center
        lblSize.font = UIFont.boldSystemFont(ofSize: 18)
        lblSize.textColor = .white
        
        lblSize.translatesAutoresizingMaskIntoConstraints = false
        lblSize.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        lblSize.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageTask?.cancel()
        imgImage.image = nil
        lblSize.text = nil
    }
    
    func fill(with url: URL) {
        imageTask = urlSession.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            if let imageData = data {
                if let image: UIImage = UIImage(data: imageData),
                    let resizedImage: UIImage = image.resizedAspectBy(scale: UIScreen.main.bounds.width / image.size.width),
                    let endDataSize: Int = UIImageJPEGRepresentation(resizedImage, 1.0)?.count {
                    let startDataSize: Int = imageData.count
                    DispatchQueue.main.async {
                        self?.imgImage.image = resizedImage
                        self?.lblSize.text = "\(startDataSize / 1000) Kb -> \(endDataSize / 1000) Kb"
                    }
                }
                
            } }
        imageTask?.resume()
    }
    
}

extension UIImage {
    
    func resizedAspectBy(scale: CGFloat) -> UIImage? {
        let size = self.size
        
        let newSize: CGSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
