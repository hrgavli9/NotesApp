//
//  ViewController.swift
//  A8_NotesApp
//
//  Created by Dipak on 03/05/1943 Saka.
//

import UIKit

class ViewController: UIViewController {

    private var notesarr = [String]()
    private var notestableview = UITableView()
    
    private func getNotes()
    {
        let path = DirDataService.getDocDir()
        
        do
        {
            let items = try FileManager.default.contentsOfDirectory(at: path , includingPropertiesForKeys: nil)
            notesarr.removeAll()
            for item in items
            {
                notesarr.append(item.lastPathComponent)
            }
        }
        catch
        {
            print(error)
        }
        notestableview.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        getNotes()
        checkAuth()
    }
    private let myButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.addTarget(self, action: #selector(btnfunc), for: .touchUpInside)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 10
        return btn
    }()
    @objc func btnfunc() {
        UserDefaults.standard.setValue(nil, forKey: "SessionToken")
        UserDefaults.standard.setValue(nil, forKey: "username")
        print("logout clicked")
        checkAuth()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Notes"
//        notestableview.backgroundColor = .systemYellow
        let addnotes = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(opennewnotes))
        navigationItem.setRightBarButton(addnotes, animated: true)
        view.addSubview(notestableview)
        notestableview.addSubview(myButton)
        setup()
    }
 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notestableview.frame = view.bounds
        myButton.frame = CGRect(x: 300, y: view.height-view.safeAreaInsets.bottom-150, width: 100, height: 50)
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    private func checkAuth()
    {
        if let token = UserDefaults.standard.string(forKey: "SessionToken"),
           let name = UserDefaults.standard.string(forKey: "username") {
            print(name)
        } else {
            let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav, animated: false)
        }
    }
    @objc func opennewnotes()
    {
        navigationController?.pushViewController(NewNotesVc(), animated: true)
    }
    private func setup()
    {
        notestableview.delegate = self
        notestableview.dataSource = self
        notestableview.register(UITableViewCell.self, forCellReuseIdentifier: "notes")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesarr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath)
        cell.textLabel?.text = notesarr[indexPath.row]
//        cell.detailTextLabel?.text = notesarr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNotesVc()
        vc.updatefilename = notesarr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notestableview.beginUpdates()
//            print(notesarr[indexPath.row])
//            let filepath = DirDataService.getDocDir().appendingPathComponent(notesarr[indexPath.row])
            do {
                 let fileManager = FileManager.default
//                 Check if file exists
                if fileManager.fileExists(atPath:notesarr[indexPath.row] ) {
                    // Delete file
                    try fileManager.removeItem(atPath: notesarr[indexPath.row])
                } else {
                    print("File does not exist")
                }
             
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
            notesarr.remove(at: indexPath.row)
            
            notestableview.deleteRows(at: [indexPath], with: .fade)
            notestableview.endUpdates()
        }
    }
}

