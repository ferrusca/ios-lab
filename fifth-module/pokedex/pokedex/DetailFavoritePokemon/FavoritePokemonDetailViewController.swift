//
//  DetailPokemonViewController.swift
//  pokedex
//
//  Created by Jorge Ferrusca on 28/06/24.
//

import UIKit
// new implemention to select photos
import PhotosUI
import Lottie

class FavoritePokemonDetailViewController: UIViewController {
    private var pokemonImageView: UIImageView = {
        let pokemonImage = UIImage(systemName: "cat")
        let pokemonImageView = UIImageView(image: pokemonImage)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pokemonImageView
    }()
    
    private var animationCount = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // MARK: this method shows a Lottie animation
        // setupView2()

    }
    
    // MARK: Currently deactivated
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(pokemonImageView)
        
        var animateImageButtonConfiguration = UIButton.Configuration.borderedTinted()
        animateImageButtonConfiguration.title = "Animate"
        
        let animateButton = UIButton(configuration: animateImageButtonConfiguration)
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        animateButton.addTarget(self, action: #selector(animateButtonTapped), for: .touchUpInside)
        
        view.addSubview(animateButton)
        
        // Adding button for photo
        
        var photoWithPokemonConfig = UIButton.Configuration.bordered()
        photoWithPokemonConfig.title = "Photo"
        let photoWithPokemonButton = UIButton(configuration: photoWithPokemonConfig)
        photoWithPokemonButton.translatesAutoresizingMaskIntoConstraints = false
        photoWithPokemonButton.addTarget(self, 
                                         action: #selector(photoButtonTapped),
                                         for: .touchUpInside)
        
        view.addSubview(photoWithPokemonButton)
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            
            animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoWithPokemonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoWithPokemonButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupView2() {
        view.backgroundColor = .systemBackground
        // this is the name of the animation json file
        let animationView = LottieAnimationView(name: "animation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc
    private func animateButtonTapped() {
        // different animations upon the image view (depending on the switch value)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
            
            switch self.animationCount % 4  {
            case 0:
                self.pokemonImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.pokemonImageView.alpha = 0.2
            case 1:
                self.pokemonImageView.transform = .identity
                self.pokemonImageView.alpha = 1
            case 2:
                self.pokemonImageView.transform = CGAffineTransform(rotationAngle: .pi)
            case 3:
                self.pokemonImageView.transform = .identity
            default:
                self.pokemonImageView.transform = .identity
            }
            
            self.animationCount += 1
        }
    }
    
    @objc func photoButtonTapped() {
        #if targetEnvironment(simulator)
        var photoPickerConfigurator = PHPickerConfiguration()
        photoPickerConfigurator.filter = .images
        photoPickerConfigurator.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: photoPickerConfigurator)
        photoPicker.delegate = self
        present(photoPicker, animated: true)
        #else
        // presenting camera only on real devices
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true)
        #endif
    }
}

extension FavoritePokemonDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // triggered when user has selected a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        // checking if it's an image
        guard let image = info[.originalImage] as? UIImage else { return }
        print(image)
    }
}

extension FavoritePokemonDetailViewController: PHPickerViewControllerDelegate {
    // once user has picked anything
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard let image = image as? UIImage, error == nil else { return }
            
            // setting the selected image in the cat's place
            DispatchQueue.main.async {
                self.pokemonImageView.image = image
            }
        }
    }
}
