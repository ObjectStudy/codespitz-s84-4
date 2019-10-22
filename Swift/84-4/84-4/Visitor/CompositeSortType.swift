//
//  CompositeSortType.swift
//  84-4
//
//  Created by tskim on 22/10/2019.
//  Copyright © 2019 assin. All rights reserved.
//

import Foundation

typealias CompositeCamparable = (CompositeTask, CompositeTask) -> Void

enum CompositeSortType {
    case title_asc
    case title_desc
    case date_asc
    case date_desc
    
    /*
     Java 는 enum 의 안정성을 위해서 코드중복을 방치한다.
     Class 객체 생성으로 생성시점을 미룰 순 있지만 동시성 문제를 안고가야한다.
     일반적으로 엔터프라이즈에서는 동시성 문제가 훨씬 무섭기 때문에 코드 중복을 감수하더라도 enum 을 사용한다. 
     */
    func comparable(a: CompositeTask, b: CompositeTask) -> Bool {
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
