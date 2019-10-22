//
//  SortType.swift
//  84-4
//
//  Created by tskim on 21/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

/*
  Java 에서는 enum 은 인스턴스를 확정으로 만들어 주는 것이다.
 enum 은 static 초기화 이전에 OS 에 의해서 생성된다.
 Thread 가 시작되기 전에 만들어지기 때문에 Thread safe 하다.
 
 하지만 미리 만들어지기 때문에 Generic 이 되지 않는 단점이 있다.
 
 */

/*
 Java 와 Swift enum 은 다르기 때문에 다른 코드로 구현하고 있다. 
 */

/*
 TYPE 의 객체가 확정되어있다면 더 이상 확장하지 않도록 제한하는 enum 을 사용한다.
 (Class 수량 제약)
 */
typealias TaskCamparable = (Task, Task) -> Void

enum SortType {
    case title_asc
    case title_desc
    case date_asc
    case date_desc
    
    func comparable(a: Task, b: Task) -> Bool {
        switch self {
        case .title_asc:
            return a.title < b.title
        case .title_desc:
            return a.title > b.title
        case .date_asc:
            return a.date < b.date
        case .date_desc:
            return a.date > b.date
        }
    }
}
