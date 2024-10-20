//
//  ViewController.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 14.10.2024.
//

import UIKit

class LoginViewController: UIViewController {

    private let contentView : LoginView = .init()
    private var fieldUIMap: [FieldType: FieldUI] = [:]
    private let viewModel = LoginViewModel()
    private let navigator : AppNavigator
    
    init(navigator: AppNavigator) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        view.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldUIMap = [
                .name: FieldUI(label: contentView.nameLabel, checkmark: contentView.nameCheck),
                .lastName: FieldUI(label: contentView.lastNameLabel, checkmark: contentView.lastNameCheck),
                .birthDate: FieldUI(label: contentView.dateLabel, checkmark: contentView.dateCheck),
                .password: FieldUI(label: contentView.passwordLabel, checkmark: contentView.passwordCheck),
                .confirmPassword: FieldUI(label: contentView.confirmPasswordLabel, checkmark: contentView.confirmPasswordCheck)
            ]
        
        contentView.delegate = self
        setupValidation()
        navigateToMainScreen()
    }
    
    private func updateField(type: FieldType, isValid: Bool, errorMessage: String?) {
        guard let fieldUI = fieldUIMap[type] else { return }
        fieldUI.checkmark.isHidden = !isValid
        fieldUI.label.text = errorMessage
        fieldUI.label.isHidden = errorMessage == nil
        
        if type == .password {
            contentView.confirmPasswordTextField.isEnabled = isValid
            contentView.confirmPasswordTextField.isHidden = !isValid
        }
    }
    
    private func setupValidation() {
        viewModel.onAllFieldsValid = { [weak self] allFieldsValid in
            DispatchQueue.main.async {
                self?.contentView.registerButton.isHidden = !allFieldsValid
                self?.contentView.registerButton.isEnabled = allFieldsValid
            }
        }
        
        viewModel.onValidationResult = { [weak self] type, isValid, errorMessage in
            guard let self = self else { return }
            updateField(type: type, isValid: isValid, errorMessage: errorMessage)
        }
    }
    
    private func navigateToMainScreen() {
        viewModel.navigateToNextScreen = { [weak self] in
            self?.navigator.navigateToTableScreen()
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    
    func nameEdited(with name: String?) {
        viewModel.validateInput(name, for: .name)
    }
    
    func lastNameEdited(with lastName: String?) {
        viewModel.validateInput(lastName, for: .lastName)
    }
    
    func dateOfBirthEdited(with date: String?) {
        viewModel.validateInput(date, for: .birthDate)
    }
    
    func passwordEdited(with password: String?) {
        viewModel.validateInput(password, for: .password)
    }
    
    func confirmPasswordEdited(with confirmPassword: String?) {
        viewModel.validateInput(confirmPassword, for: .confirmPassword)
    }
    
    func didTapRegister() {
        viewModel.onButtonTapped()
    }
}


