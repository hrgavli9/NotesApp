//
//  NewNotesVc.swift
//  A8_NotesApp
//
//  Created by Dipak on 03/05/1943 Saka.
//

import UIKit

class NewNotesVc: UIViewController {

    var updatefilename = ""
    
    private let NotesFileName:UITextField = {
        let mytext = UITextField()
        mytext.placeholder = "Note Title "
        mytext.textAlignment = .center
        mytext.textColor = .black
        mytext.backgroundColor = .systemFill
        mytext.autocapitalizationType = .none
        return mytext
    }()
    
    private let NotesFileContent:UITextView = {
        let textview = UITextView()
        textview.text = "Write Content"
        textview.textAlignment = .left
        textview.backgroundColor = .systemFill
        textview.textColor = .black
        textview.font = .systemFont(ofSize: 20.0)
        return textview
    }()

    private let NoteSave:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(notesavefunc), for: .touchUpInside)
        btn.backgroundColor = .purple
        btn.layer.cornerRadius = 10
        return btn
    }()
    @objc func notesavefunc()
    {
        let name = NotesFileName.text!
        let content = NotesFileContent.text!
        let filepath = DirDataService.getDocDir().appendingPathComponent("\(name).txt")
      
        do
        {
            try content.write(to: filepath, atomically: true, encoding: .utf8)
            let fetchcontent = try String(contentsOf: filepath)
            print(fetchcontent)
            
            let alert = UIAlertController(title: "Congrats!", message: "Note saved successfully..", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {
                [weak self] _ in self?.navigationController?.popViewController(animated: true)
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        catch
        {
                print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.backgroundColor = .systemYellow
        view.addSubview(NoteSave)
        view.addSubview(NotesFileContent)
        view.addSubview(NotesFileName)
     
        
        if updatefilename != ""
        {
            showdadafunc()
            let editnote = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(updatefunc))
            navigationItem.setRightBarButton(editnote, animated: true)
           
        }
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotesFileName.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 20, width: view.width - 80, height: 40)
        NotesFileContent.frame = CGRect(x: 40, y: NotesFileName.bottom + 20, width: view.width - 80, height: 300)
        NoteSave.frame = CGRect(x: 40, y: NotesFileContent.bottom + 20, width: view.width - 80, height: 40)
    }
}
extension NewNotesVc
{
    @objc private func updatefunc()
    {
        if updatefilename != ""
        {
            NotesFileName.text = updatefilename.components(separatedBy:".").first
            NotesFileName.isEnabled = false
            NoteSave.isEnabled = true
            let filepath = DirDataService.getDocDir().appendingPathComponent(updatefilename)
            
            do
            {
                let content = try String(contentsOf: filepath)
                NotesFileContent.text = content
                NotesFileContent.isSelectable = true
                NotesFileContent.isEditable = true
            }
            catch
            {
                print(error)
            }
        }
    }
    
    @objc func showdadafunc()
    {
        NotesFileName.text = updatefilename.components(separatedBy:".").first
        NotesFileName.isEnabled = false
//        NotesFileContent.isEditable = false
        NoteSave.isEnabled = false
        let filepath = DirDataService.getDocDir().appendingPathComponent(updatefilename)
        
        do
        {
            let content = try String(contentsOf: filepath)
            NotesFileContent.text = content
            NotesFileContent.isSelectable = false
        }
        catch
        {
            print(error)
        }
        
    }
}
