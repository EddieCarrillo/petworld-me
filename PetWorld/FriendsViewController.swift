//
//  FriendsViewController.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/26/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
