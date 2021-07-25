//
//  DirDataService.swift
//  A8_NotesApp
//
//  Created by Dipak on 03/05/1943 Saka.
//

import Foundation
class DirDataService
{
    static func getDocDir() -> URL
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print("Directory path:\(path[0])")
        
        return path[0]
    }
}
