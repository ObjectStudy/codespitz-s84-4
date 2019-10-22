//
//  CompositeTask.swift
//  84-4
//
//  Created by tskim on 22/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

/*
 Composite pattern 의 그룹 객체를 가진다.
 */
class CompositeTask {
    private var _title: String
    private var _date: Date
    private var isComplete: Bool
//    private var _taskReport: TaskReport  = TaskReport()
    private var _list = [CompositeTask]()

    public init(title: String, date: Date, isComplete: Bool = false) {
        self._title = title
        self._date = date
        self.isComplete = isComplete
    }
    
    public func toggle() {
        isComplete = !isComplete
    }
    
    @discardableResult
    func addTask(title: String, date: Date) -> CompositeTask{
        let task = CompositeTask(title: title, date: date)
        _list.append(task)
        return task
    }
    
    func removeTask(task: CompositeTask) {
        _list.removeAll {
            $0 === task
        }
    }
    
    func getReport(sortType: CompositeSortType) -> TaskReport {
        let report = TaskReport(task: self)
        for t in _list {
            report.add(report: t.getReport(sortType: sortType))
        }
        return report
    }
    
    func setTitle(title: String) {
        self._title = title
    }
    func setDate(date: Date) {
        self._date = date
    }
}

extension CompositeTask {
    var title: String {
        return _title
    }
    var date: Date {
        return _date
    }
    var isCompleted: Bool {
        return isComplete
    }
}
