//
//  PriorityListModel.swift
//  ToDo Priority
//
//  Created by Jasleen on 09/02/24.
//

import Foundation
import UIKit
struct PriorityListModel{
    let listName:String?
    let priority:priority
    
    init(listName: String?, priority: priority) {
        self.listName = listName
        self.priority = priority
    }
  static func findPriority(text:String?) -> priority{
        switch text{
        case "High": return .High
        case "Low" : return .Low
        case "Medium" : return .Medium
        default: return .High
        }
    }
  static func findPriority(priority:priority) -> String{
        switch priority {
        case .High:
            return "High"
        case .Medium:
            return "Medium"
        case .Low:
            return "Low"
        }
    }
    static func priorityColor(priority:priority) -> UIColor{
          switch priority {
          case .High:
              return .systemRed
          case .Medium:
              return .systemYellow
          case .Low:
              return .systemGreen
          }
      }
}
extension PriorityListModel: Comparable {
    static func <(lhs: PriorityListModel, rhs: PriorityListModel) -> Bool { lhs.priority.rawValue < rhs.priority.rawValue }
}

