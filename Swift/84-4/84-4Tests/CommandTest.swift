//
//  CommandTest.swift
//  84-4Tests
//
//  Created by tskim on 2019/10/22.
//  Copyright © 2019 assin. All rights reserved.
//
import XCTest
@testable import _4_4

class CommandTest: XCTestCase {

    func testConsoleVisitor() {
        let root = CommandTask(title: "Root", date: Date())
        root.addTask(title: "sub1", date: Date())
        root.addTask(title: "sub2", date: Date())

//        let renderer1 = Renderer(factory: { ConsoleVisitor() })
//        renderer1.render(report: root.getReport(sortType: CompositeSortType.title_asc))
//        root.undo()
//        renderer1.render(report: root.getReport(sortType: CompositeSortType.title_asc))
    }
}
