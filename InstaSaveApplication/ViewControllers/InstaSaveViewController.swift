//
//  ViewController.swift
//  InstaSaveApplication
//
//  Created by Uğur burak Güven on 1.02.2022.
//

import UIKit
import RealmSwift

class InstaSaveViewController: UIViewController {
    
    @IBOutlet weak var openAllImageButton: UIButton!
    @IBOutlet weak var openInstagramButton: UIButton!
    @IBOutlet weak var selectPicsButton: UIButton!
    @IBOutlet weak var instaTableView: UITableView!
    
    private var collectionView: UICollectionView?
    
    let realm = try! Realm()
    var realmArray : [UserData]? = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonFont()
        setCollectionView()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        instaTableView.delegate = self
        instaTableView.dataSource = self
        self.instaTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        getImageFromRealm()
        let keyboardGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        keyboardGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardGestureRecognizer)
        
    }
    
    func getImageFromRealm() {
        let results = realm.objects(UserData.self)
        for result in results {
            realmArray?.append(result)
        }
        
        
    }
    
    func setCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(MainMenuCollectionViewCell.self, forCellWithReuseIdentifier: MainMenuCollectionViewCell.identifier)
        collectionView?.showsHorizontalScrollIndicator = false
        
        guard let myCollection = collectionView else {
            return
        }
        
        view.addSubview(myCollection)
    }
    
    func setButtonFont(){
        openInstagramButton.layer.borderWidth = 0.3
        openInstagramButton.layer.borderColor = UIColor.systemGray.cgColor
        selectPicsButton.layer.borderWidth = 0.3
        selectPicsButton.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 100, width: (view.frame.size.width - 50), height: 80).integral

    }
    @IBAction func openInstagramButtonClicked(_ sender: Any) {
           let appURL = URL(string: "instagram://app")!
           let application = UIApplication.shared

           if application.canOpenURL(appURL) {
               application.open(appURL)
           } else {
               let webURL = URL(string: "https://instagram.com/")!
               application.open(webURL)
           }
    }
    @IBAction func selectPicsFromGallery(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func openAllImageButtonClicked(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AllCollectionViewController") as! AllCollectionViewController
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayoutInvalidationContext, UICollectionViewDelegate

extension InstaSaveViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realmArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuCollectionViewCell.identifier, for: indexPath) as! MainMenuCollectionViewCell
        if let imageData = realmArray?[indexPath.row].image{
            let image : UIImage = UIImage(data: imageData as Data)!
            cell.configure(with: image)
        }
        return cell
    }
    
}
extension InstaSaveViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "RepostViewController") as! RepostViewController
        vc.selectedName = realmArray?[indexPath.row].name
        vc.selectedCaption = realmArray?[indexPath.row].caption
        vc.selectedId = realmArray?[indexPath.row].id
        if let imageData = realmArray?[indexPath.row].image{
            let image : UIImage = UIImage(data: imageData as Data)!
            vc.selectedImageView = image
        }
        self.present(vc, animated: true, completion: nil)
    }
    
}


//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension InstaSaveViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let popOverVC = self.storyboard!.instantiateViewController(withIdentifier: "AlertViewController") as! PopUpViewController
        popOverVC.selectedImage = info[.originalImage] as? UIImage
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension InstaSaveViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            if let imageData = realmArray?[indexPath.row].image{
                let image : UIImage = UIImage(data: imageData as Data)!
                cell.tableViewImageView.image = image
                cell.tableViewNameLabel.text = realmArray?[indexPath.row].name
                if let captionLabel = realmArray?[indexPath.row].caption {
                    cell.tableViewCaptionLabel.text = captionLabel
                } else {
                    cell.tableViewCaptionLabel.text = ""
                }
                cell.tableViewDateLabel.text = realmArray?[indexPath.row].date
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "RepostViewController") as! RepostViewController
        vc.selectedName = realmArray?[indexPath.row].name
        vc.selectedCaption = realmArray?[indexPath.row].caption
        vc.selectedId = realmArray?[indexPath.row].id
        if let imageData = realmArray?[indexPath.row].image{
            let image : UIImage = UIImage(data: imageData as Data)!
            vc.selectedImageView = image
        }
  
   
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
