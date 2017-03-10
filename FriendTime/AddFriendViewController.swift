//
//  AddFriendViewController.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-06.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import UIKit
import CoreData

class AddFriendViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
   
    @IBOutlet weak var profilePicture: UIImageView!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    var fullNameOfPerson : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
        }
        else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum
        }else {
            print("Did not work!")
        }
        
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        profilePicture.image = image
        
       
        picker.dismiss(animated: true, completion: nil)
    }

    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first {
            
            return documentsDirectory.appending("/\(fullNameOfPerson).png")
        
        }else {
            fatalError("No documents directory :(((")
        }
    }
    
    @IBAction func addFriend(_ sender: Any) {
        
        if let data = UIImagePNGRepresentation(profilePicture.image!) {
            do {
                let url = URL(fileURLWithPath: imagePath())
                try data.write(to: url)
                
                print(url);
            }
            catch {
                NSLog("Failed to save image data")
            }
            
        }
        
        let friend:Friend = NSEntityDescription.insertNewObject(forEntityName: "friend", into: DatabaseController.persistentContainer.viewContext) as! Friend
        
        friend.firstName = firstNameTextField.text;
        friend.surName = surNameTextField.text;
        
        
        print(fullNameOfPerson)
        
        let fetchRequest : NSFetchRequest<Friend> = Friend.fetchRequest()
        
        }

    
}


