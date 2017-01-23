//
//  PhotoDetailsViewController.swift
//  tumblr lab1
//
//  Created by zheng wu on 1/22/17.
//  Copyright © 2017 CodeMonkey. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var image: UIImage!

    @IBOutlet var detailImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
       // imageView.image = image
        // Do any additional setup after loading the view.
        guard let image = image else{
        print ("image nil")
            return
        }
        detailImage.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
