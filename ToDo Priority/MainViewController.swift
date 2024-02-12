//
//  ViewController.swift
//  ToDo Priority
//
//  Created by Jasleen on 07/02/24.
//

import UIKit
enum priority : Int{
    case High
    case Medium
    case Low
}
class MainViewController: UIViewController {
    
    let priorityNames = ["High", "Medium", "Low"]
    let viewModel = ToDoPriorityViewModel()
    let dropDownButton : UIButton = {
        let button = UIButton()
        let arrowImage = UIImage(systemName: "chevron.down")
        button.setImage(arrowImage, for: .normal)
        button.tintColor = .white // Set the color of the arrow
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let plusImage = UIImage(systemName: "plus.circle.fill")
        button.setImage(plusImage, for: .normal)
        button.tintColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let inputTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).cgColor
        
        // Add left padding for text
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        // Customize text and placeholder
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let headingLabel : UILabel = {
        let label = UILabel()
        label.text = "Priority List"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(PriorityListTableViewCell.self, forCellReuseIdentifier: PriorityListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAllItems()
        view.backgroundColor = .white
        
        
        var menuChildren: [UIMenuElement] = []
        for data in priorityNames {
            menuChildren.append(UIAction(title: data, handler:  { (action: UIAction) in
                print(action.title)
            }))
        }
        
        dropDownButton.menu = UIMenu(options: .displayInline, children: menuChildren)
        dropDownButton.showsMenuAsPrimaryAction = true
        dropDownButton.changesSelectionAsPrimaryAction = true
        
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
       
        tableView.delegate = self
        tableView.dataSource = self
        reloadTableData()
   
        
    }
    @objc func addButtonClicked(){
        if let text = inputTextField.text , text != ""{
            viewModel.createItem(listName: text, priority: dropDownButton.titleLabel?.text ?? "High")
            inputTextField.text = ""
            reloadTableData()
        }
        
    }
    func reloadTableData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        view.addSubview(headingLabel)
        view.addSubview(dropDownButton)
        view.addSubview(inputTextField)
        view.addSubview(addButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            inputTextField.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            inputTextField.leadingAnchor.constraint(equalTo: headingLabel.leadingAnchor,constant: 10),
            inputTextField.heightAnchor.constraint(equalToConstant: 30),
            dropDownButton.leadingAnchor.constraint(equalTo: inputTextField.trailingAnchor,constant: 10),
            dropDownButton.topAnchor.constraint(equalTo: inputTextField.topAnchor),
            dropDownButton.widthAnchor.constraint(equalToConstant: 100),
            dropDownButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.leadingAnchor.constraint(equalTo: dropDownButton.trailingAnchor,constant: 10),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.trailingAnchor.constraint(equalTo: headingLabel.trailingAnchor),
            addButton.topAnchor.constraint(equalTo: inputTextField.topAnchor),
            tableView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
 
    
    
    
}
extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.priorityListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriorityListTableViewCell.identifier, for: indexPath) as! PriorityListTableViewCell
        cell.toDoText.text = "- " + (viewModel.priorityListItems[indexPath.row].listName ?? "")
        cell.priorityLabel.text = PriorityListModel.findPriority(priority: viewModel.priorityListItems[indexPath.row].priority)
        cell.priorityLableView.backgroundColor = PriorityListModel.priorityColor(priority: viewModel.priorityListItems[indexPath.row].priority)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let listItem = viewModel.findItem(priorityListItem: viewModel.priorityListItems[indexPath.row])
        
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit Priority", style: .default,handler: {[weak self] _ in
            let alertController = UIAlertController(title: "Select Priority", message: nil, preferredStyle: .alert)
            let lowAction = UIAlertAction(title: "Low", style: .default, handler: { _ in
                guard let listItem = listItem else{return}
                self?.viewModel.updateItem(item: listItem, newPriority: "Low")
                self?.reloadTableData()
            })
            let mediumAction = UIAlertAction(title: "Medium", style: .default, handler: { _ in
                guard let listItem = listItem else{return}
                self?.viewModel.updateItem(item: listItem, newPriority: "Medium")
                self?.reloadTableData()
            })
            let HighAction = UIAlertAction(title: "High", style: .default, handler: { _ in
                guard let listItem = listItem else{return}
                self?.viewModel.updateItem(item: listItem, newPriority: "High")
                self?.reloadTableData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(lowAction)
            alertController.addAction(mediumAction)
            alertController.addAction(HighAction)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
           
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive,handler: {[weak self] _ in
            guard let listItem = listItem else{return}
            self?.viewModel.deleteItem(item: listItem)
            self?.reloadTableData()
        }))
        present(sheet, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

