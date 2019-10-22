//
//  Renderer.swift
//  84-4
//
//  Created by tskim on 22/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

/*
 TaskReport 를 순회하는 제어구조이다.
 이 제어구조의 행위를 외부에 위임할 수 있다.
 
 Visitor Pattern
 */

typealias SupplierVisitorFactory = () -> Visitor
class Renderer {
//    private let visitor: Visitor

//    public init(visitor: Visitor) {
//        self.visitor = visitor
//    }
    
    /*
     Render 를 할때마다 새로운 visitor 가 생성되기 때문에 동시성 문제를 해결할 수 있다.
     
     */
    private let factory: SupplierVisitorFactory

    public init(factory: @escaping SupplierVisitorFactory) {
        self.factory = factory
    }
    
    
    /*
     순회하면서 그리는 함수를 정의
     depth 는 사용자가 이 함수를 최초 실행될 때 depth 를 0으로 준다는 보장이 없기 때문에 private 이다.
     */
    
    private func render(visitor: Visitor, report: TaskReport, depth: Int) {
        // 제어를 실행하는 객체와 제어를 통제하는 객체를 분리하여야 한다.
        // 여기서는 제어를 실행하고 있다. for loop)
        visitor.drawTask(task: report.task, depth: depth)
        for report in report._list {
            render(visitor: visitor, report: report, depth: depth + 1)
        }
        visitor.end(depth: depth)
    }
    /*
     사용자가 호출할 수 있도록 public 으로 지정한다.
     */
    public func render(report: TaskReport) {
        let visitor = self.factory()
        render(visitor: visitor, report: report, depth: 0)
    }
    
    
}
