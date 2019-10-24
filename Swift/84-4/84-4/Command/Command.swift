//
//  Command.swift
//  84-4
//
//  Created by tskim on 22/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation
/*
 일반적으로 Command 패턴의 대표하는 메소드는 execute() 가 있다.
 Client 가 직접 조작하는 CompositeTask를 Command 패턴에 행위를 위임한다.
 행위만 위임하는 것이 아니라 그 행위를 기억할 수 있다 (undo, redo)
 */
protocol Command {
    func execute(task: CompositeTask)
    func undo(task: CompositeTask)
}

/*
 Toggle 는 Command 객체이다.
 */
class Toggle: Command {
    func execute(task: CompositeTask) {
        task.toggle()
    }

    func undo(task: CompositeTask) {
        task.toggle()
    }
}

class TitleCommand: Command {
    private final let title: String
    private var oldTitle: String = ""

    public init(title: String) {
        self.title = title
    }

    func execute(task: CompositeTask) {
        oldTitle = task.title
        task.setTitle(title: title)
    }

    func undo(task: CompositeTask) {
        task.setTitle(title: oldTitle)
    }
}

class DateCommand: Command {
    private final let date: Date
    private var oldDate: Date = Date()

    public init(date: Date) {
        self.date = date
    }

    func execute(task: CompositeTask) {
        oldDate = task.date
        task.setDate(date: task.date)
    }

    func undo(task: CompositeTask) {
        task.setDate(date: oldDate)
    }
}

/*
 코드스피츠 1강에서 켄트벡 아저씨가 말했던 대칭성이 있어야 한다. 를 말했던 적이 있다.
 (get, set 과 같이 대칭성이 있어야 한다.)

 그러므로 Add 가 있어면 Remove 도 존재해야 한다.
 */
class AddCommand: Command {
    private let title: String
    private let date: Date
    private var oldTask: CompositeTask?
    
    public init(title: String, date: Date) {
        self.title = title
        self.date = date
    }

    func execute(task: CompositeTask) {
        oldTask = task.addTask(title: title, date: date)
    }

    func undo(task: CompositeTask) {
        if let oldTask = oldTask {
            task.removeTask(task: oldTask)
        }
    }
}


class RemoveCommand: Command {
    private var oldTitle: String = ""
    private var oldDate: Date = Date()
    private var baseTask: CompositeTask

    public init(task: CompositeTask) {
        // 생성 당시에 Context 를 기억
        self.baseTask = task
    }

    func execute(task: CompositeTask) {
        // 실행 당시에 Context 를 기억
        // 실행 당시에 Context 를 기억하는 이유는 undo 하기 위해서이다.
        oldTitle = task.title
        oldDate = task.date
        task.removeTask(task: baseTask)
    }

    func undo(task: CompositeTask) {
        task.addTask(title: oldTitle, date: oldDate)
    }
}


/*
 Command 객체는 생성 시점과 실행 시점이 다르며 함수형 프로그래밍과 같이 지연실행을 하기 위해 쓰인다.
 
 코드를 실행하는 행위 자체도 많은 방법으로 활용된다. 이것만으로도 코드의 중복이 많이 없어진다.
 
 지연 실행 뿐만 아니라 비동기 실행까지도 확대할 수 있다.
 
 
 */
