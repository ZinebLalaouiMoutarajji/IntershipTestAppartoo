//
//  DetailsBarViewController.swift
//  TestFinal
//
//  Created by vPro on 26/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import UIKit

class DetailsBarViewController: UIViewController {
    
    @IBOutlet var barImageView: UIImageView!
    var bar: Bar = Bar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        barImageView.image = UIImage(named: bar.location)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
