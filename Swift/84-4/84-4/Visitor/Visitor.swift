//
//  Visitor.swift
//  84-4
//
//  Created by tskim on 22/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation


protocol Visitor {
    /*
     Visitor 에 2가지 Lifecycle 을 얻을 수 있다.
     [drawTask, end]
     
     */
    func drawTask(task: CompositeTask, depth: Int)
    func end(depth: Int)
}

class ConsoleVisitor: Visitor {
    func drawTask(task: CompositeTask, depth: Int) {
        var padding = ""
        (0..<depth).forEach { _ in
            padding += "-"
        }
        let isCompletedOut = task.isCompleted ? "[v]" : "[ ]"
        print("\(padding) \(isCompletedOut) \(task.title) (\(task.date))")
    }

    func end(depth: Int) {

    }
}

/*
 큰 흐름은 Template method pattern 으로 강제를 시키고
 안에 몸통은 유연하게 갖도록하는 것들은 Visitor pattern을 사용한다.
 
 Android 에서 Acitivity Lifecycle의
 [onCreate, onResume, onPause] 등은 Lifecycle 타는 거대한 Visitor 다.
 
 Renderer 는 Strategy 객체를 공급한 결과가 된다.
 그렇다면 큰 범주에서 보면 Visitor pattern 도 Strategy pattern 일까?
 
 Visitor VS Strategy
 제어 능력을 잃어버린 객체는 Visitor 라고 부른다.
 
 제어 역전은 참조를 거꿀로 하는 것이 아니다.
 
 의존성 역전과 제어역전의 의미는 다르다.
 
 의존성 역전은 구상 객체를 아는 것이 아니라 구상 객체의 추상 객체를 아는 것이다.
 제어 역전(IoC)은 제어 구문이 Lifecycle 을 가지고 있는 객체를 소비하는 것이다.
 */
class JsonVisitor: Visitor {

    private var result: String = ""
    
    func getPadding(depth: Int) -> String {
        var padding = ""
        (0..<depth).forEach { _ in
            padding += "   "
        }
        return padding
    }
    func drawTask(task: CompositeTask, depth: Int) {
        result += "{"
        result += "   title:  \"\(task.title)\","
        result += "   date:  \"\(task.date)\","
        result += "   isComplete:  \"\(task.isCompleted)\","
        result += "   sub: [ "
    }

    func end(depth: Int) {
        result += "  ]"
        result += "},"
    }
    
    func getJson() -> String {
        return result
    }
}
