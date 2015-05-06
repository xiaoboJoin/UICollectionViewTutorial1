//
//  FlickrPhotosViewController.swift
//  UICollectionViewTutorial1
//
//  Created by iXiaobo on 15/5/6.
//  Copyright (c) 2015年 iXiaobo. All rights reserved.
//

import UIKit




class FlickrPhotosViewController: UICollectionViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout{
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsetsMake(50.0,  20.0, 50,  20)
    private var searches = [FlickrSearchResults]()
    private let flickr = Flickr()
    
    @IBOutlet weak var _searchTextField: UITextField!
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        textField.addSubview(activityIndicator);
        activityIndicator.frame = textField.bounds;
        activityIndicator.startAnimating()
        
        flickr.searchFlickrForTerm(textField.text, completion: { (results, error) -> Void in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if error != nil
            {
                println("error searching:\(error)")
            }
            
            if results != nil
            {
                println("found:\(results?.searchResults.count) matching \(results?.searchTerm)")
                self.searches.insert(results!, atIndex: 0)
                
                self.collectionView!.reloadData()
            }
            
        })
        
        textField.text = nil;
        textField.resignFirstResponder();
        return true
    }
    
    
    func photoForIndexPath(indexPath:NSIndexPath)->FlickrPhoto
    {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
       // self.collectionView!.registerClass(FlickrPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return self.searches.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.searches[section].searchResults.count;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlickrPhotoCell
    
        let flickrPhoto = photoForIndexPath(indexPath)
        //cell.backgroundColor = UIColor.greenColor()

       cell.imageView.image = flickrPhoto.thumbnail
        // Configure the cell
    
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flickrPhoto = photoForIndexPath(indexPath)
        
        if var size = flickrPhoto.thumbnail?.size
        {
            size.width += 10
            size.height += 10
            return size
        }
        return CGSize(width: 100, height: 100)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
        
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
