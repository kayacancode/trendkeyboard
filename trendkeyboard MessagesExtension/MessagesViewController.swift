//
//  MessagesViewController.swift
//  trendkeyboard MessagesExtension
//
//  Created by Kaya Jones on 11/9/20.
// hello this is a test

import UIKit
import Messages


class MessagesViewController: MSMessagesAppViewController, UICollectionViewDelegate, UISearchBarDelegate {
    
    
    var stickerCollection:UICollectionView!
    
    
    var stickerList = [URL]()
    var filteredStickerList = [URL]()
    
    func createCells(){
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("Stickers.bundle")
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
            
         
            

            for item in contents
            {
                stickerList.append(item)
               
                
            }
        }
        catch let error as NSError {
            print(error)
        }
    }

    
    
    
    func setupviews(){
        let margins = view.layoutMarginsGuide
        stickerCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        stickerCollection.translatesAutoresizingMaskIntoConstraints = false
        
      
     view.addSubview(stickerCollection)
        stickerCollection.backgroundColor = UIColor(red: 0.42, green: 0.46, blue: 0.49, alpha: 1.00)
        
        
        let collectionViewConstriants = [
            
            stickerCollection.widthAnchor.constraint(equalTo: view.widthAnchor),
            stickerCollection.heightAnchor.constraint(equalTo: view.heightAnchor),
            stickerCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stickerCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(collectionViewConstriants)
        stickerCollection.register(StickerCell.self,forCellWithReuseIdentifier:"cell")
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
    }
     //SEARCH BAR
     //----- once search bar is clicked the state of the application needs to go from compact
    // expansive view
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()

        searchBar.placeholder = "Search to find a sticker"
        searchBar.barTintColor = UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.isTranslucent = false
        searchBar.sizeToFit()
        
        
        return searchBar
    }()
    
    
    func setupSearchBar() {
       
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        searchBar.heightAnchor.constraint(equalTo: view.heightAnchor)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor)
  
        view.addSubview(searchBar)
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if self.presentationStyle == MSMessagesAppPresentationStyle.compact {
            self.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded)
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStickerList = []
       
        if self.searchBar.text == "" {
            self.searchBar.showsCancelButton = false
            filteredStickerList = stickerList
            print(filteredStickerList) // once u type somthing and then you clear it, this is called
           
        } else {
            self.searchBar.showsCancelButton = true
            for sticker in stickerList {
                let string = sticker.absoluteString
                if string.lowercased().contains(searchText.lowercased()){
                    filteredStickerList.append(sticker)
                }

            }
    
        }
        self.stickerCollection.reloadData()
       
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {


        if !(self.searchBar.text?.isEmpty)! {
            self.searchBar.resignFirstResponder()
            self.searchBar.text = ""
            self.searchBar.showsCancelButton = false

        }


    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCells()
        setupviews()
        setupSearchBar()
        stickerCollection.delegate = self
        stickerCollection.dataSource = self
        searchBar.delegate = self
//        field.delegate = self
        
  
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 


}


extension MessagesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 160)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredStickerList.count == 0 {
//            print("this is the stickerlist ", stickerList)
            return stickerList.count
            
        } else {
//            print("this is the filteredstickerlist", filteredStickerList)

            return filteredStickerList.count
        }

//        if(searchBar.isActive)
//        {
//            return filteredStickerList.count
//        }
//        return stickerList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StickerCell
        if ((self.searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)){
            cell.configure(with: stickerList[indexPath.item])
        
        } else{
            if filteredStickerList.count > 0 && indexPath.item < filteredStickerList.count{
            
            cell.configure(with: filteredStickerList[indexPath.item])
        }
        }
        return cell

    }
    


}

