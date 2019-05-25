//
//  String+Extension.swift
//  To Do List
//
//  Created by Давид on 27/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

extension String {
    var name: String {
        return components(separatedBy: "/").last ?? ""
    }
}
