//
//  ViewController.swift
//  HW3_Reference
//
//  Created by Владимир Мацнев on 21.10.2024.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    private struct Constants {
        static let gradientColors: [CGColor] = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        static let gradientStartPoint = CGPoint(x: 0, y: 0)
        static let gradientEndPoint = CGPoint(x: 0, y: 0.8)
        
        static let animationLabelText = "Select Animation"
        static let speedLabelText = "Select Speed"
        static let colorLabelText = "Select Color"
        static let startButtonTitle = "Start"
        static let labelTextColor = UIColor.black
        static let labelFontSize: CGFloat = 25
        
        static let backgroundViewColor = UIColor.white
        static let backgroundViewCornerRadius: CGFloat = 15
        static let animationBackgroundViewWidth: CGFloat = 230
        static let animationBackgroundViewHeight: CGFloat = 50
        
        static let colorBackgroundViewWidth: CGFloat = 200
        static let colorBackgroundViewHeight: CGFloat = 30
        static let colorBackgroundViewCornerRadius: CGFloat = 10
        static let colorLabelFontSize: CGFloat = 20
        
        static let speedBackgroundViewWidth: CGFloat = 160
        static let speedBackgroundViewHeight: CGFloat = 30
        static let speedBackgroundViewCornerRadius: CGFloat = 10
        static let speedLabelFontSize: CGFloat = 20
        
        static let animationBackgroundViewTopOffset: CGFloat = 100
        static let speedBackgroundViewBottomOffset: CGFloat = -325
        static let colorBackgroundViewBottomOffset: CGFloat = -180
        
        static let animationButtonTitles = ["Animation 1", "Animation 2", "Animation 3"]
        static let speedButtonTitles = ["0.5x", "1x", "2x"]
        static let colorButtonTitles = ["Black", "Grey", "White"]
    }
    
    private var gradientLayer: CAGradientLayer?
    private let animationSelectionLabel = UILabel()
    private let speedSelectionLabel = UILabel()
    private let colorSelectionLabel = UILabel()
    
    private var animationLabels: [UILabel] = []
    private var speedButtons: [UIButton] = []
    private var colorButtons: [UIButton] = []
    
    private var selectedAnimationIndex: Int?
    private var selectedSpeedIndex: Int?
    private var selectedBackgroundColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupUI ()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }
    
    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = Constants.gradientColors
        gradientLayer?.startPoint = Constants.gradientStartPoint
        gradientLayer?.endPoint = Constants.gradientEndPoint
        
        if let gradientLayer = gradientLayer {
            self.view.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    private func updateGradientFrame() {
        gradientLayer?.frame = self.view.bounds
    }
    private func setupUI() {
        setupAnimationSelectionLabel()
        setupSpeedSelectionLabel()
        setupColorSelectionLabel()
        setupAnimationLabels()
        setupSpeedButtons()
        setupColorButtons()
        setupStartButton()
    }
    
    private func setupSpeedSelectionLabel() {
        let speedSelectionLabel = UILabel()
        speedSelectionLabel.text = Constants.speedLabelText
        speedSelectionLabel.textColor = Constants.labelTextColor
        speedSelectionLabel.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        speedSelectionLabel.textAlignment = .center
        
        self.view.addSubview(speedSelectionLabel)
        
        speedSelectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedSelectionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            speedSelectionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20), // Отступ сверху
            speedSelectionLabel.heightAnchor.constraint(equalToConstant: 40) // Высота метки
        ])
    }
    
    private func setupAnimationSelectionLabel() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = Constants.backgroundViewColor
        backgroundView.layer.cornerRadius = Constants.backgroundViewCornerRadius
        backgroundView.layer.masksToBounds = true
        
        animationSelectionLabel.text = Constants.animationLabelText
        animationSelectionLabel.textColor = Constants.labelTextColor
        animationSelectionLabel.textAlignment = .center
        animationSelectionLabel.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        
        backgroundView.addSubview(animationSelectionLabel)
        
        self.view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.animationBackgroundViewTopOffset),
            backgroundView.widthAnchor.constraint(equalToConstant: Constants.animationBackgroundViewWidth),
            backgroundView.heightAnchor.constraint(equalToConstant: Constants.animationBackgroundViewHeight)
        ])
        
        animationSelectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationSelectionLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            animationSelectionLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            animationSelectionLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            animationSelectionLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }
    
    private func setupColorButtons() {
        let colors = [UIColor.black, UIColor.gray, UIColor.white]
        let colorNames = ["Black", "Gray", "White"]
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        
        for (index,color) in colors.enumerated() {
            let button = UIButton(type:.system)
            button.setTitle(colorNames[index], for:.normal)
            button.backgroundColor = UIColor.clear
            button.setTitleColor(.black, for:.normal)
            button.layer.borderColor = UIColor.black.cgColor
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
            button.tag = index
            button.addTarget(self, action:#selector(colorButtonTapped(_:)), for:.touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
        
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints=false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo:self.view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo:self.colorSelectionLabel.bottomAnchor, constant:(20)),
            stackView.heightAnchor.constraint(equalToConstant:(40))
        ])
    }
    
    private func setupSpeedButtons() {
        for (index, title) in Constants.speedButtonTitles.enumerated() {
            let button = UIButton(type:.system)
            button.setTitle(title, for:.normal)
            button.tag = index
            
            button.setTitleColor(.black, for:.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
            button.addTarget(self, action:#selector(speedButtonTapped(_:)), for:.touchUpInside)
            
            self.speedButtons.append(button)
            
            self.view.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints=false
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:(20 + CGFloat(index * 100))),
                button.topAnchor.constraint(equalTo:self.speedSelectionLabel.bottomAnchor, constant:(20)),
                button.widthAnchor.constraint(equalToConstant:(80)),
                button.heightAnchor.constraint(equalToConstant:(40))
            ])
        }
    }
    
    private func setupColorSelectionLabel() {
        let colorLabelView = UIView()
        colorLabelView.backgroundColor = Constants.backgroundViewColor
        colorLabelView.layer.cornerRadius = Constants.colorBackgroundViewCornerRadius
        colorLabelView.layer.masksToBounds = true
        
        colorSelectionLabel.text = Constants.colorLabelText
        colorSelectionLabel.textColor = Constants.labelTextColor
        colorSelectionLabel.font = UIFont.systemFont(ofSize: Constants.colorLabelFontSize)
        colorSelectionLabel.textAlignment = .center
        
        colorLabelView.addSubview(colorSelectionLabel)
        
        self.view.addSubview(colorLabelView)
        
        colorLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorLabelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            colorLabelView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.colorBackgroundViewBottomOffset),
            colorLabelView.widthAnchor.constraint(equalToConstant: Constants.colorBackgroundViewWidth),
            colorLabelView.heightAnchor.constraint(equalToConstant: Constants.colorBackgroundViewHeight)
        ])
        
        colorSelectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorSelectionLabel.leadingAnchor.constraint(equalTo: colorLabelView.leadingAnchor),
            colorLabelView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -400),
            colorSelectionLabel.topAnchor.constraint(equalTo: colorLabelView.topAnchor),
            colorSelectionLabel.bottomAnchor.constraint(equalTo: colorLabelView.bottomAnchor)
        ])
    }
    
    private func setupAnimationLabels() {
        for (index, title) in Constants.animationButtonTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 30)
            
            label.isUserInteractionEnabled = true
            
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animationTapped(_:))))
            
            self.animationLabels.append(label)
            
            self.view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                label.topAnchor.constraint(equalTo: self.animationSelectionLabel.bottomAnchor, constant: CGFloat(40 + index * 50)),
                label.widthAnchor.constraint(equalToConstant: 200),
                label.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    private func setupStartButton() {
        let startButton = UIButton(type: .system)
        startButton.setTitle(Constants.startButtonTitle, for: .normal)
        
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.blue
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func speedButtonTapped(_ sender: UIButton) {
             selectedSpeedIndex = sender.tag
             print("Выбрана скорость воспроизведения \(Constants.speedButtonTitles[sender.tag])")
         }
    
    @objc private func animationTapped(_ sender:UIGestureRecognizer) {
        guard let tappedlabel = sender.view as? UILabel,
              let tappedAnimationIndex = animationLabels.firstIndex(of:tappedlabel) else { return; }
        selectedAnimationIndex = tappedAnimationIndex;
        
        switch tappedAnimationIndex {
        case 0:
            print("Выбрана Анимация 1")
        case 1:
            print("Выбрана Анимация 2")
        case 2:
            print("Выбрана Анимация 3")
        default:
            break;
        }
    }
    
    @objc private func startButtonTapped() {
        guard let animationIndex = selectedAnimationIndex,
              let speedIndex = selectedSpeedIndex else {
            print("Не выбраны анимация или скорость.")
            return
        }
        
        print("Запуск анимации \(animationIndex + 1) с скоростью \(Constants.speedButtonTitles[speedIndex])")
        for label in animationLabels {
            label.isHidden = true
        }
        for button in speedButtons {
            button.isHidden = true
        }
        
        self.view.backgroundColor = selectedBackgroundColor ?? UIColor.white
        
        let animationName = "Animation-\(animationIndex + 1)"
        let animationView = LottieAnimationView(name: animationName)
        
        switch speedIndex {
        case 0:
            animationView.animationSpeed = 0.5
        case 1:
            animationView.animationSpeed = 1.0
        case 2:
            animationView.animationSpeed = 2.0
        default:
            break
        }
        
        animationView.frame = self.view.bounds
        animationView.contentMode = .scaleAspectFit
        
        self.view.addSubview(animationView)
        
        animationView.play { (finished) in
            if finished {
                print("Анимация завершена")
            } else {
                print("Анимация прервана")
            }
        }
    }
    
    @objc private func colorButtonTapped(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            selectedBackgroundColor = UIColor.black;
        case 1:
            selectedBackgroundColor = UIColor.gray;
        case 2:
            selectedBackgroundColor = UIColor.white;
        default:
            selectedBackgroundColor = UIColor.white;
        }
        
        print("Выбран цвет фона:\(selectedBackgroundColor!)")
    }
    
}
