//
//  CaptionedPictureView.swift
//  photoApp
//
//  Created by Jorge Ferrusca_C on 12/04/24.
//

import UIKit

class CaptionedPictureView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // Embedding XIB into view (Option A)
    @IBOutlet weak var view: UIView!
    
    // when this variable is set in another view, it will bind the values to the ImageView and UILabel
    var captionedPicture: CaptionedPicture! {
        didSet {
            imageView.image = captionedPicture.image
            label.text = captionedPicture.caption
        }
    }
    
    // for programatic usage
    override init(frame: CGRect) {
        super.init(frame: frame)
//        Option A
//        setupViewWithOutlet()
        
//        Option B
//        setupWithNib()
        
//            Option C
        setupWithBundle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        Calling option A
//        setupViewWithOutlet()
        
//        Option B
//                setupWithNib()
//        Option C
        setupWithBundle()
    }
    
    // MARK: - Option A: registering CaptionedPictureView XIB into the bundle
    private func setupViewWithOutlet() {
        Bundle.main.loadNibNamed("CaptionedPictureView", owner: self)
        addSubview(view)
        // que hace?? (tamic)
        view.translatesAutoresizingMaskIntoConstraints = false
        // add constraints to stick the view with our class?
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    // MARK: - Option B
    private func setupWithNib() {
        guard let view = UINib(nibName: "CaptionedPictureView", bundle: nil).instantiate(withOwner: self).first as? UIView else { return }
        
        addSubview(view)
        // que hace?? (tamic)
        view.translatesAutoresizingMaskIntoConstraints = false
        // add constraints to stick the view with our class?
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    
    // MARK: - Option C (through bundle)
    private func setupWithBundle() {
        guard let view = Bundle.main.loadNibNamed("CaptionedPictureView", owner: self)?.first as? UIView else { return }
        
        addSubview(view)
        // que hace?? (tamic)
        view.translatesAutoresizingMaskIntoConstraints = false
        // add constraints to stick the view with our class?
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    
    
    
    var showCaption: Bool = true {
        didSet {
            label.isHidden = !showCaption
        }
    }
}
