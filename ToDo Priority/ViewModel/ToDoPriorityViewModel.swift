//
//  ToDoPriorityViewModel.swift
//  ToDo Priority
//
//  Created by Jasleen on 12/02/24.
//

import Foundation
import UIKit
class ToDoPriorityViewModel : NSObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var toDoPriorityList = [ToDoListItem]()
    var priorityListItems = [PriorityListModel]()
    func getAllItems(){
        do{
            let items = try context.fetch(ToDoListItem.fetchRequest())
            toDoPriorityList = items
            priorityListItems = []
            items.forEach{ item in
                priorityListItems.append(PriorityListModel(listName: item.listName, priority: PriorityListModel.findPriority(text: item.priority)))
            }
            priorityListItems = priorityListItems.sorted()
            
        }catch{
            //error
        }
    }
    func findItem(priorityListItem:PriorityListModel)->ToDoListItem?{
        var toDoListItemObj : ToDoListItem?
        toDoPriorityList.forEach{ item in
            if (item.listName == priorityListItem.listName && PriorityListModel.findPriority(priority: priorityListItem.priority) == item.priority){
                toDoListItemObj = item
            }
        }
        return toDoListItemObj
    }
    func createItem(listName:String,priority:String){
        let newItem = ToDoListItem(context: context)
        newItem.priority = priority
        newItem.listName = listName
        
        do{
           try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    func deleteItem(item:ToDoListItem){
        context.delete(item)
        do{
           try context.save()
            getAllItems()
        }
        catch{
            print("error")
        }
    }
    func updateItem(item:ToDoListItem,newPriority:String){
        item.priority = newPriority
        do{
           try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
}
