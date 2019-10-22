//
//  _4_4Tests.swift
//  84-4Tests
//
//  Created by tskim on 21/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import XCTest
@testable import _4_4

class VisitorTests: XCTestCase {

    func testConsoleVisitor() {
        let root = CompositeTask(title: "Root", date: Date())
        root.addTask(title: "sub1", date: Date())
        root.addTask(title: "sub2", date: Date())
        
        let report: TaskReport = root.getReport(sortType: CompositeSortType.title_asc)
        let sub1 = report.tasks[0].task
        let sub2 = report.tasks[1].task
        
        sub1.addTask(title: "sub1_1", date: Date())
        sub1.addTask(title: "sub1_2", date: Date())
        
        sub2.addTask(title: "sub2_1", date: Date())
        sub2.addTask(title: "sub2_2", date: Date())
        
        let renderer1 = Renderer(factory: { ConsoleVisitor() })
        renderer1.render(report: root.getReport(sortType: CompositeSortType.title_asc))
         /*
         실행 결과
         
         [ ] Root (2019-10-22 06:01:44 +0000)
         - [ ] sub1 (2019-10-22 06:01:44 +0000)
         -- [ ] sub1_1 (2019-10-22 06:01:44 +0000)
         -- [ ] sub1_2 (2019-10-22 06:01:44 +0000)
         - [ ] sub2 (2019-10-22 06:01:44 +0000)
         -- [ ] sub2_1 (2019-10-22 06:01:44 +0000)
         -- [ ] sub2_2 (2019-10-22 06:01:44 +0000)
         */
    }
    func testJsonVisitor() {
        let root = CompositeTask(title: "Root", date: Date())
        root.addTask(title: "sub1", date: Date())
        root.addTask(title: "sub2", date: Date())
        
        let report: TaskReport = root.getReport(sortType: CompositeSortType.title_asc)
        let sub1 = report.tasks[0].task
        let sub2 = report.tasks[1].task
        
        sub1.addTask(title: "sub1_1", date: Date())
        sub1.addTask(title: "sub1_2", date: Date())
        
        sub2.addTask(title: "sub2_1", date: Date())
        sub2.addTask(title: "sub2_2", date: Date())
        
        let renderer1 = Renderer(factory: { JsonVisitor() })
        renderer1.render(report: root.getReport(sortType: CompositeSortType.title_asc))
         /*
         실행 결과
         
         {
         title: "Root",
         date: "2019-10-22 06:17:05 +0000",
         isComplete: "false",
         sub: [
           {
            title: "sub1",
            date: "2019-10-22 06:17:05 +0000",
            isComplete: "false",
            sub: [
              {
               title: "sub1_1",
               date: "2019-10-22 06:17:05 +0000",
               isComplete: "false",
               sub: [
               ]
               },
              {
               title: "sub1_2",
               date: "2019-10-22 06:17:05 +0000",
               isComplete: "false",
               sub: [
               ]
               },
            ]
            },
           {
            title: "sub2",
            date: "2019-10-22 06:17:05 +0000",
            isComplete: "false",
            sub: [
              {
               title: "sub2_1",
               date: "2019-10-22 06:17:05 +0000",
               isComplete: "false",
               sub: [
               ]
               },
              {
               title: "sub2_2",
               date: "2019-10-22 06:17:05 +0000",
               isComplete: "false",
               sub: [
               ]
               },
            ]
            },
         ]
         },
         */
    }
}
