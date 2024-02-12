//
//  PriorityListTableViewCell.swift
//  ToDo Priority
//
//  Created by Jasleen on 10/02/24.
//

import UIKit

class PriorityListTableViewCell: UITableViewCell {
    static let identifier = "PriorityListTableViewCell"
    
    let toDoText : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let priorityLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    let priorityLableView : UIView = {
       let view = UIView()
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    override func layoutSubviews() {
        addSubview(toDoText)
        addSubview(priorityLableView)
        priorityLableView.addSubview(priorityLabel)

        NSLayoutConstraint.activate([
            toDoText.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            toDoText.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            toDoText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priorityLableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            priorityLableView.leadingAnchor.constraint(equalTo: toDoText.trailingAnchor,constant: 10),
            priorityLableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priorityLableView.widthAnchor.constraint(equalToConstant: 50),
            priorityLableView.heightAnchor.constraint(equalToConstant: 30),
            priorityLabel.centerYAnchor.constraint(equalTo: priorityLableView.centerYAnchor),
            priorityLabel.centerXAnchor.constraint(equalTo: priorityLableView.centerXAnchor),
            
        ])
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
