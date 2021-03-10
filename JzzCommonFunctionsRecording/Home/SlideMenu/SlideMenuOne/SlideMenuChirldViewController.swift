//
//  SlideMenuChirldViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/22.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class SlideMenuChirldViewController: UIViewController {

    @IBOutlet weak var title_label: UILabel!

    init(title: String) {
        super.init(nibName: String(describing: SlideMenuChirldViewController.self), bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.title_label.text = self.title
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
