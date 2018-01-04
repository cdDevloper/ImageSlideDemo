//
//  ViewController.swift
//  imgSlideViewDemo
//
//  Created by Bhagwant-MacBook on 04/01/18.
//  Copyright © 2018 CDDevloper. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var currentPage:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Mark: Custum Methods
    
    func didTap()
    {
       print(currentPage!)
    }

}

// Mark: UICollectionView Delegat and Datasource Methods
extension MainViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (UIScreen.main.bounds.size.width/2)-15
        return CGSize(width: width, height:179)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainTypeCell", for: indexPath) as! MainTypeCollectionViewCell
        
        //cell.imgViewMainType.image = UIImage(named:"")
        //cell.lblMainType.text = ""
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionElementKindSectionHeader:
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "imgSlideViewCell",
                                                                             for: indexPath) as! SlideViewCollectionReusableView
            
           // cell.imgSlideView.layer.borderColor = color.ImgborderCoor.cgColor
            cell.imgSlideView.layer.borderWidth = 1
            cell.imgSlideView.setImageInputs([ImageSource(image: UIImage(named: "img1.png")!),
                                             ImageSource(image: UIImage(named: "img2.JPG")!),ImageSource(image: UIImage(named: "img3.jpg")!)])
            cell.imgSlideView.backgroundColor = UIColor.white
            cell.imgSlideView.slideshowInterval = 5.0
            cell.imgSlideView.pageControlPosition = PageControlPosition.insideScrollView
            cell.imgSlideView.pageControl.currentPageIndicatorTintColor = UIColor.blue
            cell.imgSlideView.pageControl.pageIndicatorTintColor = UIColor.white
            cell.imgSlideView.contentScaleMode = UIViewContentMode.scaleAspectFill
            // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
            
            
            cell.imgSlideView.activityIndicator = DefaultActivityIndicator()
            
            cell.imgSlideView.currentPageChanged = { page in
                self.currentPage = page
                print("current page:", page)
            }
            
            // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
            cell.imgSlideView.addGestureRecognizer(recognizer)
           return cell
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
