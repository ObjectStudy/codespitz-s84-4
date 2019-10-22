//
//  Tasks.swift
//  84-4
//
//  Created by tskim on 21/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

class Tasks {
    var title: String

    private var list = [Task]()

    public init(title: String) {
        self.title = title
    }
    
    
    /*
    Task 를 외부에서 생성할 수 있도록 하는 순간
    Task 생성자를 함부로 고치지
    오직 addTask() 안에서만 Task 를 생성하도록 한다.
     Task 수정의 여파가 Tasks 까지만 미치도록 한다.
    */
//    func addTask(task: Task) {
    func addTask(title: String, date: Date) {
    }
    /*
     객체지향은 식별자를 통해서만 객체를 식별하기 하기 때문에 Task 를 인자로 받도록 한다.
     */
    func removeTask(task: Task) {
        let index = list.firstIndex { $0 === task }
        if let index = index {
            list.remove(at: index)
        }
    }
    
    /*
        얕은 복사로 List 를 전달해준다.
     */
    func getList(sortType: SortType) -> [Task] {
        let tasks = Array(list)
        // 함수 내부에서 if switch 호출하기 싫다면
        // 전략 객체로 바꿔준다.
        return tasks.sorted(by: sortType.comparable)
    }
}

