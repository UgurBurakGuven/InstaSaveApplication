//
//  AlertViewController.swift
//  InstaSaveApplication
//
//  Created by Uğur burak Güven on 2.02.2022.
//

import UIKit
import RealmSwift

class PopUpViewController: UIViewController {
 
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var captionTextField: UITextField!
    
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 16
        popUpView.clipsToBounds = true
        closeButton.layer.cornerRadius = 16
        closeButton.clipsToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
 
        detailImageView.image = selectedImage
        showAnimate()
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations:  {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool)in
            if(finished){
                self.view.removeFromSuperview()
            }
        })
    }
    func uploadImage(image: UIImage){
        let data = NSData(data: image.jpegData(compressionQuality: 0.9)!)

        let userData = UserData()
        userData.image = data
        userData.name = usernameTextField.text
        if captionTextField.hasText {
            userData.caption = captionTextField.text
        }else {
            userData.caption = ""
        }
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(userData)
        }
       
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        removeAnimate()
    }
  
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let selectedImage = selectedImage {
            if usernameTextField.hasText {
                uploadImage(image: selectedImage)
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "InstaSaveViewController") as! InstaSaveViewController
                self.present(vc, animated: true, completion: nil)
            } else {
                makeAlert(titleInput: "Missing value!", messageInput: "Please enter username")
            }
           
        }
          
    }
   
    
    @IBAction func repostButtonClicked(_ sender: Any) {
      
        
        if let selectedImage = selectedImage {
            if usernameTextField.hasText {
                uploadImage(image: selectedImage)
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "RepostViewController") as! RepostViewController
                vc.selectedImageView = selectedImage
                vc.selectedName = usernameTextField.text
                
                if captionTextField.hasText {
                    vc.selectedCaption = captionTextField.text
                }else {
                    vc.selectedCaption = ""
                }
                
                self.present(vc, animated: true, completion: nil)
            } else {
                makeAlert(titleInput: "Missing value!", messageInput: "Please enter username")
            }
           
        }
           
        
        
    }
    

    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }


}
