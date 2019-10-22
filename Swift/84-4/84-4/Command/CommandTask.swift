//
//  CommandTask.swift
//  84-4
//
//  Created by tskim on 2019/10/22.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation


class CommandTask {
    private let task: CompositeTask
    private var _commands = [Command]()

    private var isComplete: Bool = false
    private var saved = [String: String]()
    // redo를 구현하기 위해 cursor 를 선언
    private var cursor = 0
    
    public init(title: String, date: Date) {
        self.task = CompositeTask(title: title, date: date)
    }

    public func addTask(title: String, date: Date) {
        addCommand(command: AddCommand(title: title, date: date))
    }
    
    public func removeTask(task: CompositeTask) {
        addCommand(command: RemoveCommand(task: task))
    }
    /*
     Memonto pattern 을 구현할 때 2가지 경우가 있음.
     1. Seriablization 을 외부에 출력하는 경우
     2. 내부에 기억하는 경우 (일반적인 경우)
      - Key 가 필요
     
     */
    public func save(key: String) {
        let visitor = JsonVisitor()
        let renderer1 = Renderer(factory: { visitor })
        renderer1.render(report: task.getReport(sortType: CompositeSortType.title_asc))
        saved.updateValue(visitor.getJson(), forKey: key)
    }

    public func load(key: String) {
        let json = saved[key]
        // json 순회하면서 복원
        // 과
    }
    func addCommand(command: Command) {
        // 새로운 Command 가 추가되면 현재상태의 cursor 를 기준으로 cursor 보다 큰 Command 를 삭제한다.
        (0..<cursor).forEach {
            _commands.remove(at: $0)
        }

        _commands.append(command)
        // cursor += 1 은 버그를 유발할 수 있다.
        // 그러므로 불변식 (invariant) 로 커서를 증가시켜준다.
        cursor = _commands.count - 1
        command.execute(task: task)
    }
    /*
     여러 Command 객체를 만들어서 코드의 양이 증가한 것 같지만
     합쳐보면 코드의 양이 훨씬 작다.
     
     디자인패턴은?
     각각의 해법에 대해서 가장 짧은 코드로 짜는 것이다.
     
     Command 패턴 코드의 양이 짧은 이유는 중복 코드를 Command 객체에서 처리하기 때문이다.
     */
    public func undo() {
        if cursor < 0 { return }
        _commands[cursor].undo(task: task)
        cursor -= 1
    }

    public func redo() {
        if cursor > _commands.count - 1 { return }
        cursor += 1
        _commands[cursor].execute(task: task)
    }

    public func toggle() {
        // Toggle 이라는 명령이라는 코드가 Type 형태로 변경되었다.
        addCommand(command: Toggle())
    }

    public func setTitle(title: String) {
        // title 이란 상태는 Command 객체가 생성되면 title 에 대한 상태를 기억해야 하는 책임이 있다.
        // 함수의 클로저 변수와 같은 역할을 한다.
        addCommand(command: TitleCommand(title: title))
    }

    public func setDate(date: Date) {
        addCommand(command: DateCommand(date: date))
    }

    func getReport(sortType: CompositeSortType) -> TaskReport {
        task.getReport(sortType: sortType)
    }
}
