//
//  LoginView.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 14.10.2024.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func nameEdited(with name: String?)
    func lastNameEdited(with lastName: String?)
    func passwordEdited(with password: String?)
    func dateOfBirthEdited(with date: String?)
    func confirmPasswordEdited(with confirmPassword: String?)
    func didTapRegister()
}

class LoginView: UIView {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowRadius = 4
        
        return label
    }()
    
    // --------name-------------
    
    private lazy var nameMainStack: UIStackView = {
        let nameStack = UIStackView()
        nameStack.axis = .vertical
        nameStack.spacing = 4
        nameStack.addArrangedSubview(nameHStack)
        nameStack.addArrangedSubview(nameLabel)
        
        return nameStack
    }()
    
    private lazy var nameHStack: UIStackView  = {
        let nameStack = UIStackView(arrangedSubviews: [nameTextField, nameCheck])
        nameStack.axis = .horizontal
        nameStack.spacing = 8
        
        return nameStack
    }()
    
    lazy var nameCheck: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark.circle")
        checkImage.tintColor = .green
        checkImage.isHidden = true
        
        return checkImage
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .red
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.numberOfLines = 0
        nameLabel.isHidden = true
        
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Имя"
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    //---------------lastName---------------
    
    private lazy var lastNameMainStack: UIStackView = {
        let lastNameStack = UIStackView()
        lastNameStack.axis = .vertical
        lastNameStack.spacing = 4
        lastNameStack.addArrangedSubview(lastNameHStack)
        lastNameStack.addArrangedSubview(lastNameLabel)
        
        return lastNameStack
    }()
    
    private lazy var lastNameHStack: UIStackView  = {
        let lastNameStack = UIStackView(arrangedSubviews: [lastNameTextField, lastNameCheck])
        lastNameStack.axis = .horizontal
        lastNameStack.spacing = 8
        
        return lastNameStack
    }()
    
    lazy var lastNameCheck: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark.circle")
        checkImage.tintColor = .green
        checkImage.isHidden = true
        
        return checkImage
    }()
    
    lazy var lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.textColor = .red
        lastNameLabel.font = UIFont.systemFont(ofSize: 12)
        lastNameLabel.numberOfLines = 0
        lastNameLabel.isHidden = true
        
        return lastNameLabel
    }()
    
    private lazy var lastNameTextField: UITextField = {
        
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Фамилия"
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        
        return textField
    }()
    
    // ------------dateOfBirth-------------
    
    private lazy var dateMainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.addArrangedSubview(dateHStack)
        stack.addArrangedSubview(dateLabel)
        
        return stack
    }()
    
    private lazy var dateHStack: UIStackView  = {
        let dateStack = UIStackView(arrangedSubviews: [dateTextField, dateCheck])
        dateStack.axis = .horizontal
        dateStack.spacing = 8
        
        return dateStack
    }()
    
    lazy var dateCheck: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark.circle")
        checkImage.tintColor = .green
        checkImage.isHidden = true
        
        return checkImage
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .red
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.isHidden = true
        dateLabel.numberOfLines = 0
        
        return dateLabel
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Дата рождения"
        textField.borderStyle = .roundedRect
        textField.inputView = datePicker
        
        return textField
    }()
    
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.locale = Locale(identifier: "ru_RU")
        
        return datePicker
    }()
    
    // ---------------password-----------
    private lazy var passwordMainStack: UIStackView = {
        let passwordStack = UIStackView()
        passwordStack.axis = .vertical
        passwordStack.spacing = 4
        passwordStack.addArrangedSubview(passwordHStack)
        passwordStack.addArrangedSubview(passwordLabel)
        
        return passwordStack
    }()
    
    private lazy var passwordHStack: UIStackView  = {
        let passwordStack = UIStackView(arrangedSubviews: [passwordTextField, passwordCheck])
        passwordStack.axis = .horizontal
        passwordStack.spacing = 8
        
        return passwordStack
    }()
    
    lazy var passwordCheck: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark.circle")
        checkImage.tintColor = .green
        checkImage.isHidden = true
        
        return checkImage
    }()
    
    lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.textColor = .red
        passwordLabel.font = UIFont.systemFont(ofSize: 12)
        passwordLabel.isHidden = true
        passwordLabel.numberOfLines = 0
        
        return passwordLabel
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        
        return textField
    }()
    
    //----------------confirmPassword-------------------
    
    private lazy var confirmPasswordMainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.addArrangedSubview(confirmPasswordHStack)
        stack.addArrangedSubview(confirmPasswordLabel)
        
        return stack
    }()
    
    private lazy var confirmPasswordHStack: UIStackView  = {
        let stack = UIStackView(arrangedSubviews: [confirmPasswordTextField, confirmPasswordCheck])
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var confirmPasswordCheck: UIImageView = {
        let checkImage = UIImageView()
        checkImage.image = UIImage(systemName: "checkmark.circle")
        checkImage.tintColor = .green
        checkImage.isHidden = true
        
        return checkImage
    }()
    
    lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Подтвердите пароль"
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        textField.isHidden = true
        
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        
        button.isEnabled = false
        button.isHidden = true
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        let stackView = UIStackView(arrangedSubviews: [nameMainStack, lastNameMainStack, dateMainStack, passwordMainStack, confirmPasswordMainStack, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            stackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    @objc func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func registerButtonTapped() {
        delegate?.didTapRegister()
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            delegate?.nameEdited(with: nameTextField.text)
        case lastNameTextField:
            delegate?.lastNameEdited(with: lastNameTextField.text)
        case dateTextField:
            delegate?.dateOfBirthEdited(with: dateTextField.text)
        case passwordTextField:
            delegate?.passwordEdited(with: passwordTextField.text)
        case confirmPasswordTextField:
            delegate?.confirmPasswordEdited(with: confirmPasswordTextField.text)
        default: break
    }
 }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
        case nameTextField:
            lastNameTextField.becomeFirstResponder()
            
        case lastNameTextField:
            dateTextField.becomeFirstResponder()
            
        case dateTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            textField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
            
        case confirmPasswordTextField:
            textField.resignFirstResponder()
            
        default: break
        }
        return true
    }
}





