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

    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    var fullNameOfPerson : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFriendButton.isEnabled = false
        
        

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
        addFriendButton.isEnabled = true
        
       
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
        
        fullNameOfPerson = ("\(firstNameTextField.text!)\(surNameTextField.text!)")
        
        print(fullNameOfPerson)
        
        
        let friend:Friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: DatabaseController.getContext()) as! Friend
        
        let fetchRequest : NSFetchRequest<Friend> = Friend.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "firstName == '\(firstNameTextField.text!)' && surName == '\(surNameTextField.text!)'")
        print("Predicate: \(fetchRequest.predicate)")
        
        do{
        let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            for friend in searchResults {
                print(" - \(friend)")
            }
            
            if(searchResults.count == 0) {
                
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
                friend.firstName = firstNameTextField.text;
                friend.surName = surNameTextField.text;
                DatabaseController.saveContext()
                print("\(fullNameOfPerson) was created and saved!")
            }
            else {
                print("Friend already exists")
            }
            
        } catch {
            print("Error with request \(error)")
        }
      }

    
}


