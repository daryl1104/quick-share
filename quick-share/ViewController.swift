//
//  ViewController.swift
//  quick-share
//
//  Created by daryl on 2023/5/9.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var assetCollection: PHAssetCollection?
    var photos: PHFetchResult<PHAsset>?

    @IBOutlet var tableView: UITableView!
    
    
    let reuseIdentifier = "tableViewCell"
    let toDetailSegueIdentifier = "toDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumRecentlyAdded, options: nil)
//        let collection = PHAssetCollection.fetchMoments(with: nil)
        if collection.firstObject != nil {
            self.assetCollection = collection.firstObject! as PHAssetCollection
            
            // ???
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
//            self.photos = PHAsset.fetchAssets(in: assetCollection!, options: options)
            self.photos = PHAsset.fetchAssets(with: options)
            
        }else {
            print("nothing found")
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    // MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG photos:\(photos?.count)")
        return photos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyTableViewCell
        
        if let asset = self.photos?[indexPath.row] {
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 320, height: 240), contentMode: .aspectFill, options: nil) { image, info in
                if let result = image {
                    cell.myImageView?.image = result
                }
            }
        }
//        cell.myImageView.image = UIImage(named: "polaroid")
//        cell.textLabel?.text = dummy[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: toDetailSegueIdentifier, sender: photos?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        
        detailViewController.photos = sender as? PHAsset
    }
    

}

    
