//
//  SceneDelegate.swift
//  gsseninPW3
//
//  Created by Георгий Сенин on 08.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options сonnectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene)
        else { return }
    
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: WelcomeViewController())
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

final class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private var value: Int = 0
    let incrementButton = UIButton (type: .system)
    let paletteView = ColorPaletteView()
    var buttonsSV = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
        setColor()
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo:
        button.widthAnchor).isActive = true
        return button
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
            
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
        
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
    }
                                      
    @discardableResult
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom: 16, .right: 16])
        commentLabel.text = "Tap!"
        return commentView
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(self.value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    
    private func setupIncrementButton() {
        self.view.addSubview(incrementButton)
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        //incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    func getCommentLabel(value: Int) -> String{
        switch value {
            case 0...10:
                return "1"
            case 10...20:
                return "2"
            case 20...30:
                return "3"
            case 30...40:
                return "4"
            case 40...50:
                return "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
            case 50...60:
                return "big boy"
            case 60...70:
                return "70 70 70 moreeeee"
            case 70...80:
                return "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
            case 80...90:
                return "80+\n go higher!"
            case 90...100:
                return "100!! to the moon!!"
            default:
                return "100!! to the moon!!"
        }
    }
    
    func updateUI() {
        valueLabel.text = "\(self.value)"
        if getCommentLabel(value: self.value) != self.commentLabel.text{
            UIView.transition(with: commentLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.commentLabel.text = self.getCommentLabel(value: self.value)
            })
        }
    }
    
    @objc
    func incrementButtonPressed() {
        self.value += 1
        self.updateUI()
    }
    
    private func setupColorControlSV() {
        paletteView.isHidden = true

        view.addSubview(paletteView)
        paletteView.translatesAutoresizingMaskIntoConstraints = false
        paletteView.addTarget(self, action: #selector(setColor), for: .touchDragInside)
        NSLayoutConstraint.activate([ paletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8), paletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24), paletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24), paletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -8)])
    }
    @objc
    private func paletteButtonPressed() {
        paletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc
    private func setColor() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = self.paletteView.chosenColor
        }
    }
}
