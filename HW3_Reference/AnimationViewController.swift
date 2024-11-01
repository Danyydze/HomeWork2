//
//  AnimationViewController.swift
//  HW3_Reference
//
//  Created by Данил Марков on 29.10.2024.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    var selectedAnimationIndex: Int?
    var selectedSpeedIndex: Int?
    var selectedBackgroundColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем цвет фона
        self.view.backgroundColor = selectedBackgroundColor ?? UIColor.white
        
        guard let animationIndex = selectedAnimationIndex else {
            print("Не выбран индекс анимации.")
            return
        }

        // Создаем и настраиваем анимационное представление Lottie
        let animationName = "Animation \(animationIndex + 1)" // Предполагается, что файл называется "Animation-1.json", "Animation-2.json" и т.д.
        
        let animationView = LottieAnimationView(name: animationName)

        // Установка скорости воспроизведения в зависимости от выбранного индекса скорости
        switch selectedSpeedIndex {
            case 0:
                animationView.animationSpeed = 0.5
            case 1:
                animationView.animationSpeed = 1.0
            case 2:
                animationView.animationSpeed = 2.0
            default:
                animationView.animationSpeed = 1.0 // Значение по умолчанию
        }

        // Настройка анимации и добавление ее на экран
        animationView.frame = self.view.bounds
        animationView.contentMode = .scaleAspectFit

        self.view.addSubview(animationView)

        // Запуск анимации после добавления на экран
        animationView.play { (finished) in
            if finished {
                print("Анимация завершена")
            } else {
                print("Анимация прервана")
            }
        }
    }
}
