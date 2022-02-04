//
//  RepostViewController.swift
//  InstaSaveApplication
//
//  Created by Uğur burak Güven on 3.02.2022.
//

import UIKit

class RepostViewController: UIViewController {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var myLeftViewNameLabel: UILabel!
    @IBOutlet weak var myRightViewNameLabel: UILabel!
    @IBOutlet weak var myTopRightViewNameLabel: UILabel!
    @IBOutlet weak var myTopViewNameLabel: UILabel!
    
    @IBOutlet weak var spaceButton: UIButton!
    @IBOutlet weak var atButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var repostImageView: UIImageView!
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var darkButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var colorPickerImage: UIImageView!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myLeftView: UIView!
    @IBOutlet weak var myTopView: UIView!
    @IBOutlet weak var myTopRightView: UIView!
    @IBOutlet weak var myRightView: UIView!
    
    var selectedButtonIndex = 1
    var selectedTypeIndex = 1
    
    var selectedName: String?
    var selectedImageView : UIImage?
    var selectedCaption : String?
    var newImageView : UIImage?
    
    var selectedColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repostImageView.image = selectedImageView
        titleNameLabel.text = selectedName
        colorPickerImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openColorPicker))
        colorPickerImage.addGestureRecognizer(gestureRecognizer)
       
     
        repostButton.layer.borderWidth = 0.3
        repostButton.layer.borderColor = UIColor.systemGray.cgColor
        
        setViewCorner()
        typeActivity()
        buttonActivity()

    }
    @objc func goBack(){
        print("hello")
    }
   
    func setViewCorner(){
        myLeftView.layer.cornerRadius = 10
        myLeftView.layer.maskedCorners = [.layerMaxXMinYCorner]
        myRightView.layer.cornerRadius = 10
        myRightView.layer.maskedCorners = [.layerMinXMinYCorner]
        myTopView.layer.cornerRadius = 10
        myTopView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        myTopRightView.layer.cornerRadius = 10
        myTopRightView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    func typeActivity(){
        if selectedTypeIndex == 1 {
            darkButton.backgroundColor = nil
            lightButton.backgroundColor = UIColor.white
            myLeftView.backgroundColor = UIColor.white
            myTopView.backgroundColor = UIColor.white
            myTopRightView.backgroundColor = UIColor.white
            myRightView.backgroundColor = UIColor.white
            
            if selectedColor == nil {
                myLeftViewNameLabel.textColor = UIColor.black
                myRightViewNameLabel.textColor = UIColor.black
                myTopRightViewNameLabel.textColor = UIColor.black
                myTopViewNameLabel.textColor = UIColor.black
            }
           
       
        }
        if selectedTypeIndex == 2 {
            lightButton.backgroundColor = nil
            myLeftView.backgroundColor = UIColor.black
            myTopView.backgroundColor = UIColor.black
            myTopRightView.backgroundColor = UIColor.black
            myRightView.backgroundColor = UIColor.black
            darkButton.backgroundColor = UIColor.white
            
          
                myLeftViewNameLabel.textColor = UIColor.white
                myRightViewNameLabel.textColor = UIColor.white
                myTopRightViewNameLabel.textColor = UIColor.white
                myTopViewNameLabel.textColor = UIColor.white
            
            
        }
    }
    
    func buttonActivity(){
        if selectedButtonIndex == 1 {
            leftButton.backgroundColor = UIColor.white
            myLeftView.isHidden = false
            if let selectedName = selectedName {
                myLeftViewNameLabel.text = selectedName
                myLeftViewNameLabel.textColor = selectedColor
            }
        } else {
            leftButton.backgroundColor = nil
            myLeftView.isHidden = true
        }
        if selectedButtonIndex == 2 {
            rightButton.backgroundColor = UIColor.white
            myRightView.isHidden = false
            if let selectedName = selectedName {
                myRightViewNameLabel.text = selectedName
                myRightViewNameLabel.textColor = selectedColor
            }
        }else {
            rightButton.backgroundColor = nil
            myRightView.isHidden = true
        }
        if selectedButtonIndex == 3 {
            topButton.backgroundColor = UIColor.white
            myTopView.isHidden = false
            if let selectedName = selectedName {
                myTopViewNameLabel.text = selectedName
                myTopViewNameLabel.textColor = selectedColor
            }
        }else {
            topButton.backgroundColor = nil
            myTopView.isHidden = true
        }
        if selectedButtonIndex == 4 {
            topRightButton.backgroundColor = UIColor.white
            myTopRightView.isHidden = false
            if let selectedName = selectedName {
                myTopRightViewNameLabel.text = selectedName
                myTopRightViewNameLabel.textColor = selectedColor
            }
        } else {
            topRightButton.backgroundColor = nil
            myTopRightView.isHidden = true
        }
        if selectedButtonIndex == 5 {
            atButton.backgroundColor = UIColor.white
            myLeftView.isHidden = false
        }else {
            atButton.backgroundColor = nil
           // myLeftView.isHidden = true
        }
         if selectedButtonIndex == 6 {
            spaceButton.backgroundColor = UIColor.white
            myLeftView.isHidden = true
             myTopView.isHidden = true
             myRightView.isHidden = true
             myTopRightView.isHidden = true
        }else {
            spaceButton.backgroundColor = nil
           // myLeftView.isHidden = true
        }
        
                    
    
    }

    @IBAction func buttonClicked(_ sender: Any) {
        if selectedButtonIndex == 1 {
            UIGraphicsBeginImageContextWithOptions(myLeftView.bounds.size, false, UIScreen.main.scale)
            myLeftView.drawHierarchy(in: myLeftView.bounds, afterScreenUpdates: true)
        }else if selectedButtonIndex == 2 {
            UIGraphicsBeginImageContextWithOptions(myRightView.bounds.size, false, UIScreen.main.scale)
            myRightView.drawHierarchy(in: myRightView.bounds, afterScreenUpdates: true)
        }else if selectedButtonIndex == 3 {
            UIGraphicsBeginImageContextWithOptions(myTopView.bounds.size, false, UIScreen.main.scale)
            myTopView.drawHierarchy(in: myTopView.bounds, afterScreenUpdates: true)
        }else if selectedButtonIndex == 4 {
            UIGraphicsBeginImageContextWithOptions(myTopRightView.bounds.size, false, UIScreen.main.scale)
            myTopRightView.drawHierarchy(in: myTopRightView.bounds, afterScreenUpdates: true)
        }
       
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
        
        if let instagramUrl = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(instagramUrl) {
                let paste = [["com.instagram.sharedSticker.backgroundImage": saveImage(image: image) as Any]]
                UIPasteboard.general.setItems(paste)
                UIApplication.shared.open(instagramUrl)
            }
        }
    }
    func clipPhoto() -> UIImage? {
        if selectedButtonIndex == 1 {
            UIGraphicsBeginImageContextWithOptions(myLeftView.bounds.size, false, UIScreen.main.scale)
            myLeftView.drawHierarchy(in: myLeftView.bounds, afterScreenUpdates: true)
        }else if selectedButtonIndex == 2 {
            UIGraphicsBeginImageContextWithOptions(myRightView.bounds.size, false, UIScreen.main.scale)
            myRightView.drawHierarchy(in: myRightView.bounds, afterScreenUpdates: true)
        }else if selectedButtonIndex == 3 {
            UIGraphicsBeginImageContextWithOptions(myTopView.bounds.size, false, UIScreen.main.scale)
            myTopView.drawHierarchy(in: myTopView.bounds, afterScreenUpdates: true)
        }else if selectedButtonIndex == 4 {
            UIGraphicsBeginImageContextWithOptions(myTopRightView.bounds.size, false, UIScreen.main.scale)
            myTopRightView.drawHierarchy(in: myTopRightView.bounds, afterScreenUpdates: true)
        }
       
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
        
        return saveImage(image: image)
    }
   
    @IBAction func leftButtonClicked(_ sender: Any) {
        selectedButtonIndex = 1
        buttonActivity()
    }
    @IBAction func rightButtonClicked(_ sender: Any) {
        selectedButtonIndex = 2
        buttonActivity()
    }
    @IBAction func topButtonClicked(_ sender: Any) {
        selectedButtonIndex = 3
        buttonActivity()
    }
    @IBAction func bottomButtonClicked(_ sender: Any) {
        selectedButtonIndex = 4
        buttonActivity()
    }
    @IBAction func atButtonClicked(_ sender: Any) {
        selectedButtonIndex = 5
        buttonActivity()
    }
    @IBAction func spaceButtonClicked(_ sender: Any) {
        selectedButtonIndex = 6
        buttonActivity()
    }
    @IBAction func lightButtonClicked(_ sender: Any) {
        selectedTypeIndex = 1
        typeActivity()
    }
    @IBAction func darkButtonClicked(_ sender: Any) {
        selectedTypeIndex = 2
        typeActivity()
    }
   
    func saveImage(image: UIImage) -> UIImage? {
        let bottomImage = repostImageView
        let topImage = image
        let newSize = CGSize(width: repostImageView.frame.width, height: repostImageView.frame.height)
      
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        bottomImage?.draw(CGRect(origin: CGPoint.zero, size: newSize))
        
        if selectedButtonIndex == 1 {
            topImage.draw(in: CGRect(x: 0, y: repostImageView.frame.height - 23 , width: 150, height: 23))
        }else if selectedButtonIndex == 2{
            topImage.draw(in: CGRect(x: repostImageView.frame.width - 150, y: repostImageView.frame.height - 23 , width: 150, height: 23))
        }else if selectedButtonIndex == 3 {
            topImage.draw(in: CGRect(x: 0, y: 0, width: 150, height: 23))
        }else if selectedButtonIndex == 4 {
            topImage.draw(in: CGRect(x: repostImageView.frame.width - 150 , y: 0, width: 150, height: 23))
        }

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
     
    }
    @IBAction func goBackButtonClicked(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "InstaSaveViewController") as! InstaSaveViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func downloadButtonClicked(_ sender: Any) {
        let image = clipPhoto()
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
        
    }
    @IBAction func optionButtonClicked(_ sender: Any) {
    }
    
    
}

//MARK: - UIColorPickerViewControllerDelegate

extension RepostViewController : UIColorPickerViewControllerDelegate {
    
    @objc func openColorPicker() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.title = "Text Color"
        colorPickerVC.isModalInPresentation = true
        present(colorPickerVC, animated: true)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        selectedColor = color
        if selectedButtonIndex == 1 {
            myLeftViewNameLabel.textColor = color
        }else if selectedButtonIndex == 2 {
            myRightViewNameLabel.textColor = color
        }else if selectedButtonIndex == 3 {
            myTopViewNameLabel.textColor = color
        }else if selectedButtonIndex == 4 {
            myTopRightViewNameLabel.textColor = color
        }
    }
}
