//
//  ViewController.swift
//  iPhoneApp
//
//  Created by Michel Anderson Lutz Teixeira on 31/08/2018.
//

import UIKit

class ViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var addButton: UIBarButtonItem!
    private var todoList: [Todo] = []
    private var todoViewModel: TodoViewModel!
    private let cellID = "todoReusable"
    private let titleString = "Todos"
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        navigationController?.title = titleString
        title = titleString
        todoViewModel = TodoViewModel()
        todoViewModel.didLoad = { [weak self] todos in
            self?.todoList = todos
            self?.tableView.reloadData()
        }
        todoViewModel.didUpdateTodo = { [weak self] todo in
            self?.todoList.append(todo)
            self?.tableView.reloadData()
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        setupViewConfiguration()
    }

    @objc private func addTodo() {
        let alert = UIAlertController(title: "Adicionar Todo", message: "Informe o título da Todo", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Título"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print("Text field: \(textField?.text)")

            self.todoViewModel.add(title: (textField?.text!)!)
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row].title
        return cell
    }
}

extension ViewController: ViewConfiguration {
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    func configureViews() {
    }
}
