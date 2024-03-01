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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }
}

