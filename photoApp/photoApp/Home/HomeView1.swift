//
//  HomeView1.swift
//  photo-app-programmatic
//
//  Created by Jorge Ferrusca_C on 03/05/24.
//

import UIKit

class HomeView1: UIView {
    // lazy keyword to assign properties
    // note the parenthesis to call this immediately
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        // avoid autocreating constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        // margin with sibling elements
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var pictureTypeSwitch = UISwitch()
    var showCaptionSwitch = UISwitch()
    // why is this lazy (aside from assigning properties)
    lazy var customTextSwitch: UISwitch = {
        let customSwitch = UISwitch()
        // why is this needed? A: to capture the switch value of the "Custom Text" switch
        customSwitch.tag = 48
        return customSwitch
    }()
    
    lazy var customTextView: UITextView = {
        let textView = UITextView();
        textView.text = "This is a text example!"
        return textView
    }()
    
    lazy var picsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Picssss", for: .normal)
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.cornerStyle = .large
        buttonConfig.background.backgroundColor = .systemTeal
        buttonConfig.baseForegroundColor = .systemRed
        button.configuration = buttonConfig;
        return button
    }()
    
    
    private func setStackConstraints() {
        // stick view to the safe area
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func addArrangedViews() {
        stackView.addArrangedSubview(createPictureTypeView())
        stackView.addArrangedSubview(createShowCaptionsSwitchView())
        stackView.addArrangedSubview(picsButton)
        stackView.addArrangedSubview(createCustomTextSwitchView())
        stackView.addArrangedSubview(customTextView)
        // finally, add the main stack view
        addSubview(stackView)
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }
    
    // Function that setup the dog/cat togggle view
    private func createPictureTypeView() -> UIStackView {
        let stackView = createHorizontalStackView()
        // creating labels
        let catLabel = UILabel()
        catLabel.translatesAutoresizingMaskIntoConstraints = false
        catLabel.text = "Cat"
        catLabel.textAlignment = .center
        let dogLabel = UILabel()
        dogLabel.translatesAutoresizingMaskIntoConstraints = false
        dogLabel.text = "Dog"
        dogLabel.textAlignment = .center
        
        // stacking the elements
        stackView.addArrangedSubview(catLabel)
        stackView.addArrangedSubview(pictureTypeSwitch)
        stackView.addArrangedSubview(dogLabel)
        
        // set the same anchor between labels
        dogLabel.widthAnchor.constraint(equalTo: catLabel.widthAnchor, multiplier: 1).isActive = true
        
        return stackView
    }
    
    
    // Creates a view for the "Show caption" label with its toggle
    private func createShowCaptionsSwitchView() -> UIStackView {
        let stackView = createHorizontalStackView()
        let showCaptionsLabel = UILabel()
        showCaptionsLabel.translatesAutoresizingMaskIntoConstraints = false
        showCaptionsLabel.text = "Show Captions"
        // arranging elements
        stackView.addArrangedSubview(showCaptionsLabel)
        stackView.addArrangedSubview(showCaptionSwitch)
        return stackView
    }
    
    // Creates a view for the custom UITextView
    private func createCustomTextSwitchView() -> UIStackView {
        let stackView = createHorizontalStackView()
        let customTextLabel = UILabel()
        customTextLabel.translatesAutoresizingMaskIntoConstraints = true
        customTextLabel.text = "Custom text"
        
        stackView.addArrangedSubview(customTextLabel)
        stackView.addArrangedSubview(customTextSwitch)
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // setting up the whole screen
        backgroundColor = .systemBackground
        
        addArrangedViews()
        setStackConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
