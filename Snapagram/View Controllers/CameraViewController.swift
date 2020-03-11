//
//  CameraViewController.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageToDisplay: UIImage!
    //    var imagePicker: UIImagePickerController?
    @IBOutlet var displayImageView: UIImageView!
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var photosButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        displayImageView.image = nil
        nextButton.alpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        cameraButton.layer.masksToBounds = true
        photosButton.layer.cornerRadius = cameraButton.frame.height / 2
        photosButton.layer.masksToBounds = true
    }

    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func photosButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            displayImageView.image = image
            imageToDisplay = image
            nextButton.alpha = 1
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.image = image
//            self.displayImageView.image = image
//            nextButton.alpha = 1
//            picker.dismiss(animated: true, completion: nil)
//        } else {
//            print("what went wrong?!")
//        }
//    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toPost", sender: sender)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PostImageViewController {
            dest.image = imageToDisplay
        }
    }
}
