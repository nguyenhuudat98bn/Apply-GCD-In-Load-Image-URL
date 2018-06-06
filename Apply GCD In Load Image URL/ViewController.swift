//
//  ViewController.swift
//  Apply GCD In Load Image URL
//
//  Created by nguyễn hữu đạt on 5/28/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var imageView: UIImageView!
    var downloadTaskItem : DispatchWorkItem?
    let Url_Image1 = "https://goodtravel.ge/uploads/tours/608/51.jpg"
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        downLoadImage(from: Url_Image1) { [unowned self] (image) in
            self.imageView.image = image
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        downloadTaskItem?.cancel()
    }
    // xoá bộ nhớ khi tràn dữ liệu
    //            CacheImage.images.removeObject(forKey: Url_Image1 as NSString)
    
}
extension ViewController {
    func downLoadImage(from urlString: String, complete: @escaping (UIImage?) -> Void ) {
        if let url = URL(string: urlString) {
            var image: UIImage?
            
            downloadTaskItem = DispatchWorkItem(block: {
                if let cache = CacheImage.images.object(forKey: url.absoluteString as NSString) {
                    image = cache as? UIImage
                } else {
                    if let data = try? Data(contentsOf: url) {
                        image = UIImage(data: data)
                        if image != nil {
                            CacheImage.images.setObject(image!, forKey: url.absoluteString as NSString, cost: data.count)
                        }
                    }
                }
            })
            DispatchQueue.global().async {
                self.downloadTaskItem?.perform()
                DispatchQueue.main.async {
                    complete(image)
                }
            }
        }
    }
}

