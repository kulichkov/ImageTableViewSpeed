//
//  DemoViewController.swift
//  ImageTableViewSpeed
//
//  Created by Mikhail Kulichkov on 31/03/2018.
//  Copyright © 2018 Mikhail Kulichkov. All rights reserved.
//

import UIKit

final class DemoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let imageURLs: [URL] = [
        URL(string: "https://images.duckduckgo.com/iu/?u=http%3A%2F%2F1.bp.blogspot.com%2F-Bi4mi7nN3Zg%2FT2HOV6mAHtI%2FAAAAAAAAAfA%2FYOh046D0Xa8%2Fs1600%2FBeautiful_Nature_1280x1024_Wallpaper.jpg&f=1")!,
        URL(string: "http://trm96.com/homepage/Images/bg/wallpaper-1136839.jpg")!,
        URL(string: "https://cn.pling.com/img/7/5/1/4/fd5ae06d4ffe9b10048335cd5a092f78fa6a.jpg")!,
        URL(string: "http://mocah.org/uploads/posts/9102-images-of-nature-scenes-hd__images-of-nature-scenes-hd.jpg")!,
        URL(string: "https://cdn.photographylife.com/wp-content/uploads/2012/01/Sunset-Rainbow.jpg")!,
        URL(string: "https://i.ytimg.com/vi/-FAFf7mq9s4/maxresdefault.jpg")!,
        URL(string: "http://www.52dazhew.com/data/out/167/586897341-nature-laptop-wallpaper.jpg")!,
        URL(string: "http://hdwbay.com/wp-content/uploads/2017/12/green-landscape-nature-image.jpg")!,
        URL(string: "https://orig00.deviantart.net/773f/f/2017/300/c/0/out_in_the_woods_by_keldbach-d3gq2cf.jpg")!,
        URL(string: "http://uspstrackingtool.com/wp-content/uploads/2018/03/Meadow-Flowers-Wallpaper-HD.jpg")!,
        URL(string: "http://www.marz-kreations.com/Photos/Photos/14-Bns/BennasJun04-JakobstadHarbourDark2.jpg")!,
        URL(string: "http://onlymylife.com/wp-content/uploads/2016/11/2016-09-23-Nimis-road-trip-300kb-8-of-46.jpg")!,
        URL(string: "https://www.xbhp.com/talkies/attachments/motorcycle-ownership-experiences/187439d1436426528-kawasaki-ninja-300-ownership-experience-img_20150704_060943.jpg")!,
        URL(string: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,fl_lossy,h_9000,w_1200,f_auto,q_auto/v1/410574/TransformingAuckland_v4kbe3.jpg")!,
        URL(string: "http://www.scheufelen.com/fileadmin/user_upload/Alb1_wiese.jpg")!,
        URL(string: "https://static.bikehub.co.za/uploads/monthly_08_2016/hubevents-91536-0-05540300-1471987475.jpg")!
    ]
    
    let kImageCellID: String = "ImageCell"
    private var tblImages: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tblImages)
        
        tblImages.tableFooterView = UIView()
        tblImages.separatorStyle = .none
        tblImages.dataSource = self
        tblImages.delegate = self
        
        tblImages.frame = view.bounds
        
        tblImages.register(ImageTableViewCell.self, forCellReuseIdentifier: kImageCellID)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ImageTableViewCell = tblImages.dequeueReusableCell(withIdentifier: kImageCellID, for: indexPath) as? ImageTableViewCell {
            cell.fill(with: imageURLs[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
