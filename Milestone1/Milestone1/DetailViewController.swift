//
//  DetailViewController.swift
//  Milestone1
//
//  Created by Илья Сидоров  on 17.11.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var some: UIImageView!
    @IBOutlet var flagImage: UIButton!
    var selectedFlag:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedFlag
        navigationItem.largeTitleDisplayMode = .never
        
        if let flagToLoad = selectedFlag{
            flagImage.setImage(UIImage(named: flagToLoad), for: .normal)
            some.image = UIImage(named: flagToLoad)
            
        }
        // Do any additional setup after loading the view.
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
