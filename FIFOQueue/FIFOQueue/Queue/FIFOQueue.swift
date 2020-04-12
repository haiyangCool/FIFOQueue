//
//  FIFOQueue.swift
//  FIFOQueue
//
//  Created by 王海洋 on 2020/4/12.
//  Copyright © 2020 王海洋. All rights reserved.
//

import Foundation

/// 先进先出队列： 我们使用两个数组来实现一个高效的队列
struct FIFOQueue<Element> {
    
    private var left:[Element]  = []
    private var right:[Element] = []
    
    
    /// 入队，复杂度O(1)
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    /// 出队 复杂度O(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
}
/// 实现 Collection 协议
/// 1、startIndex 和 endIndex 属性
/// 2、提供一个至少可以只读方式访问集合元素的下标
/// 3、一个用来在你的集合中进行步进的方法index(after:)
extension FIFOQueue: Collection {
    
    /// 默认第一个元素的其实位置 为0
    public var startIndex: Int { return 0 }
    /// 因为只有当left为空时，才会对 right 进行一次翻转复制，所以集合下标的最大值为两个数组的大小之和
    public var endIndex: Int { return left.count + right.count }

    public func index(after i: Int) -> Int {
        precondition(i >= startIndex && i < endIndex, "Index out of bounds")
        return i + 1
    }

    public subscript(position: Int) -> Element {
        precondition((startIndex..<endIndex).contains(position),
            "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
}

/// 实现数组字面量表达式
extension FIFOQueue: ExpressibleByArrayLiteral {

    typealias ArrayLiteralElement = Element
    /// 这里的 Element...  代表可以接受多个参数作为数组的方式进行添加。Swift是支持这种方式设置参数的。
    init(arrayLiteral elements: Element...) {
        self.init(left: elements.reversed(), right: [])
    }
}

