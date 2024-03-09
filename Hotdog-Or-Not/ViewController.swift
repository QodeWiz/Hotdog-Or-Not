//
//  ViewController.swift
//  Hotdog-Or-Not
//
//  Created by Ishrat Kaur on 1/3/2024.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    // delegate method for after image is picked.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //info parameter contains the image user picked
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
        
        // convert to CI image, to use vision framework and core ML framework
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CI image.")
            }
            
            // pass ci image to detect image method
            detect(image: ciimage)
        }
            
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func detect(image: CIImage) {
        // load the model
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed.")
        }
        
        // requesting model to classify data passed in
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
        }
        
        // data is defined in a handler
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            // image handler is used to perform the request of classifying the image
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}
