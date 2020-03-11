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
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var photosButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        cameraButton.layer.masksToBounds = true
        photosButton.layer.cornerRadius = cameraButton.frame.height / 2
        photosButton.layer.masksToBounds = true
        nextButton.alpha = 0
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func photosButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
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
        
        self.image = image
        self.displayImageView.image = self.image
        nextButton.alpha = 1
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toPost", sender: sender)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PostImageViewController {
            dest.image = image
        }
    }
}
