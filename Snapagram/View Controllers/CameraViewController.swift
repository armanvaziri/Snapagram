//
//  CameraViewController.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var image: UIImage!
//    var imagePicker: UIImagePickerController?
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet var outerCameraView: UIView!
    
//    var feed = FeedData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        outerCameraView.layer.cornerRadius = 15
//        outerCameraView.layer.masksToBounds = true
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .camera
//        imagePickerController.allowsEditing = false
//        imagePickerController.delegate = self
//        imagePickerController.cameraOverlayView = outerCameraView
//        imagePickerController.showsCameraControls = false
        
//        self.imagePicker = imagePickerController
    }
    
    @IBAction func snapButtonTapped(_ sender: Any) {
        
//        let alertController = UIAlertController(title: "Snap!", message: "Take a photo or choose from your image gallery", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Okay!", style: .default) { (action) in
//        }
//        alertController.addAction(alertAction)
//        present(alertController, animated: true, completion: nil)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
         
        self.present(actionSheet, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
//            let alertController = UIAlertController(title: "Whoops!", message: "There was an error unwrapping the image", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "Okay", style: .default) { (action) in
//            }
//            alertController.addAction(alertAction)
//            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.displayImageView.image = image
        self.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toPost", sender: sender)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton, let dest = segue.destination as? PostImageViewController {
            dest.image = image
        } else {
            print("failed segue optional chaining")
        }
    }

}
