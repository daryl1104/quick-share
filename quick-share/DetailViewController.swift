//
//  DetailViewController.swift
//  quick-share
//
//  Created by daryl on 2023/5/9.
//

import UIKit
import Photos
import Social


class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var photos: PHAsset?
    var image: UIImage?
    
    
    @IBOutlet var detailImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photo = photos {
            PHImageManager.default().requestImage(for: photo, targetSize: CGSize(width: self.view.frame.width, height: self.view.frame.height*0.5625), contentMode: .aspectFill, options: .none) { image, info in
                //
                if let result = image {
                    self.detailImageView.image = result
                }
                
            }
        }else if self.image != nil {
            self.detailImageView.image = image
        }
        
    }
    
    @IBAction func sharedButtonsTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // facebook
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        case 3:
            print("3")
        case 4:
            print("4")
        case 5:
            //
            takePhoto()
        default:
            return
            
        }
        
    }
    
    var imagePickerController: UIImagePickerController!
    func takePhoto() {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true)
        
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            if let image = info[.originalImage] as? UIImage{
                detailVC.image = image
                show(detailVC, sender: self)
            }
        }
        
            
    }
}
