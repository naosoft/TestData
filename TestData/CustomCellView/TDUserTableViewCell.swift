//
//  TDUserTabeleViewCell.swift
//  TestData
//
//  Created by Krzysztof Biskupski on 11.12.2017.
//  Copyright © 2017 pl.naosoft. All rights reserved.
//

import UIKit
import AlamofireImage

class TDUserTableViewCell : UITableViewCell {
    @IBOutlet var title : UILabel?
    @IBOutlet var fullName : UILabel?
    @IBOutlet var email : UILabel?
    @IBOutlet var actionButton : UIButton?
    @IBOutlet var photo : UIImageView?
    var finishSelectionAction:((TDUser) -> Void)?
    var currentUserData:TDUser?
    
    func propagerDataOnView(userData : TDUser, isFavouriteMode:Bool) {
        
        self.title?.text = userData.name?.title
        self.fullName?.text = (userData.name?.first)! + " " + (userData.name?.last)!
        self.email?.text = userData.email
        currentUserData = userData
        loadImageHelper(photo, sourceUrl: (userData.picture?.medium)!, placeholder: nil)
        if isFavouriteMode {
            actionButton?.setTitle("Delete", for: UIControlState.normal)
        }
        else {
            actionButton?.setTitle("Favourite", for: UIControlState.normal)
        }
    }
    
    @IBAction func favouriteAction() {
         if self.finishSelectionAction != nil {
            self.finishSelectionAction!(self.currentUserData!)
        }
    }
    
    func loadImageHelper(_ targetImage:UIImageView?, sourceUrl:String, placeholder:UIView?) {
        targetImage?.af_setImage(withURL:URL(string: sourceUrl)!,
                                 placeholderImage:UIImage(),
                                 filter:nil,
                                 imageTransition:.crossDissolve(0.2))
    }
}
