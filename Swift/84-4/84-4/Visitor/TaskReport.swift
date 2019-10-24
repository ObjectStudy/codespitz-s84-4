//
//  TaskReport.swift
//  84-4
//
//  Created by tskim on 22/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

/*
 TaskReport 는 Composite pattern 이다.
 
 TaskReport 는 Leaf 이자 Tree 가 된다.
 */
class TaskReport {
    private let _task: CompositeTask

    private(set) var list = [TaskReport]()
    
    public init(task: CompositeTask) {
        self._task = task
    }
    
    func add(report: TaskReport) {
        list.append(report)
    }
    
    func getReport(sortType: SortType) -> TaskReport {
        return self
    }
}

extension TaskReport {
    var tasks: [TaskReport] {
        return list
    }
    
    var task: CompositeTask {
        return _task
    }
}
