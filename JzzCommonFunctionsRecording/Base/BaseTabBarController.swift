//
//  BaseTabBarController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/26.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit
import ESTabBarController_swift
class BaseTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = BaseNavigationController(rootViewController:HomeViewController());
        let v2 = BaseNavigationController(rootViewController:SecondViewController());
        let v3 = BaseNavigationController(rootViewController:ThreeViewController());
        let v4 = BaseNavigationController(rootViewController:FourViewController());
        let v5 = BaseNavigationController(rootViewController:MineViewController());

        
        /*
         var image:UIImage = UIImage(named: "home")!

         var selectedimage:UIImage = UIImage(named: "home_1")!

         image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);

         selectedimage = selectedimage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
         */
 
        v1.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Photo", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        v4.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v5.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

        
        /*
        ///整个底部tabBar颜色
        self.tabBar.barTintColor = UIColor.black
        */
        
        /*
         
         */
        
        ///
        self.viewControllers = [v1, v2, v3, v4, v5]
 
      
        
        /*
         self.delegate = delegate
         self.title = "Irregularity"
         self.tabBar.shadowImage = UIImage(named: "transparent")
         self.tabBar.backgroundImage = UIImage(named: "background_dark")
         self.shouldHijackHandler = {
             tabbarController, viewController, index in
             if index == 2 {
                 return true
             }
             return false
         }
         self.didHijackHandler = {
             [weak tabBarController] tabbarController, viewController, index in
             
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                 let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                 let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                 alertController.addAction(takePhotoAction)
                 let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                 alertController.addAction(selectFromAlbumAction)
                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                 alertController.addAction(cancelAction)
                 tabBarController?.present(alertController, animated: true, completion: nil)
             }
         }

         let v1 = BaseNavigationController(rootViewController:HomeViewController());
         let v2 = BaseNavigationController(rootViewController:SecondViewController());
         let v3 = BaseNavigationController(rootViewController:ThreeViewController());
         let v4 = BaseNavigationController(rootViewController:FourViewController());
         let v5 = BaseNavigationController(rootViewController:MineViewController());
         
         v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
         v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
         v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
         v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
         v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
         
         self.viewControllers = [v1, v2, v3, v4, v5]

 */
        
        
        
        
        
        
        
        
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
