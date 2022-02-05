//
//  AllCollectionViewController.swift
//  InstaSaveApplication
//
//  Created by Uğur burak Güven on 5.02.2022.
//

import UIKit
import RealmSwift

class AllCollectionViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        return collectionView
    }()
    let realm = try! Realm()

    var realmArray : [UserData]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getDataFromRealm()
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "InstaSaveViewController") as! InstaSaveViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height).integral
    }
    
    func getDataFromRealm() {
        let results = realm.objects(UserData.self)
        for result in results {
            realmArray?.append(result)
        }
    }
    


}

extension AllCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("you tapped me")
    }
}

extension AllCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realmArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError()
        }
        
        if let imageData = realmArray?[indexPath.row].image{
            let image : UIImage = UIImage(data: imageData as Data)!
            cell.imageView.image = image
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-4,
                      height: (view.frame.size.width/2)-4)
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"),handler: {_ in
                if let imageData = self.realmArray?[indexPath.row].image {
                    let image : UIImage = UIImage(data: imageData as Data)!
                    let imageToShare = [ image ]
                    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view
                          
                    self.present(activityViewController, animated: true, completion: nil)
                }
                
               
              
            })
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"),handler: { _ in
                
                if let selectedId = self.realmArray?[indexPath.row].id {
                    let results = self.realm.objects(UserData.self).filter("id='\(selectedId)'")
                    try! self.realm.write({
                        self.realm.delete(results)
                        self.realmArray?.remove(at: indexPath.row)
                    })
                    collectionView.reloadData()
                }
           
            })
            
            let downloadImage = UIAction(title: "Save", image: UIImage(systemName: "square.and.arrow.down"),handler: { _ in
                if let imageData = self.realmArray?[indexPath.row].image {
                    let image : UIImage = UIImage(data: imageData as Data)!
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            })
            
            
            
            return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [share, downloadImage, delete])
        }
        return config
    }
    
    
}
extension AllCollectionViewController: UICollectionViewDelegateFlowLayout {
        
  
}

class ImageCollectionViewCell : UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
