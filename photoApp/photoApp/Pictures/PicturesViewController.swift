//
//  PicturesViewController.swift
//  photoApp
//
//  Created by Jorge Ferrusca_C on 05/04/24.
//

import UIKit

class PicturesViewController: UIViewController {
    // EmbededView
    @IBOutlet weak var firstCaptionedPictureView: CaptionedPictureView!;
    
    var pictureType: PictureType = .dog
    var showCaptions: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setPictures()
        setCaptionsVisibility()
        // Remove extra space that appears due to large tatle option enabled by default
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    
    private func setCaptionsVisibility() {
        firstCaptionedPictureView.showCaption = showCaptions
        // Adding second captioned view through parent element
        addCaptionedViewInPlace(atPlace: 1)
        
        // Adding third captioned view through parent element
        addCaptionedViewInPlace(atPlace: 2)
    }
    
    private func addCaptionedViewInPlace(atPlace: Int) {
        let captionedPictureView = CaptionedPictureView()
        captionedPictureView.captionedPicture = pictureType.captionedPictures[atPlace]
        captionedPictureView.isHidden = !showCaptions
        
        (firstCaptionedPictureView.superview as? UIStackView)?.insertArrangedSubview(captionedPictureView, at: atPlace)
    
    }
    
    private func setPictures() {
        // these are the images with their label
        let captionedPictures = pictureType.captionedPictures
        firstCaptionedPictureView.captionedPicture = captionedPictures.first
        
        
//        thirdImage.image = captionedPictures.last?.image
//        thirdCaption.text = captionedPictures.last?.caption
    }

}
