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
    
    /// Indices 集合的indices属性类型，是集合中所有有效索引按升序排列组成的集合。
    /// 但是不包含endIndex,因为 endIndex代表的是集合中最后一个元素之后的位置，
    /// 并不是一个有效的索引。Indices 需要报纸对原有集合的引用，才能对索引进行
    /// 步进。这里就会有一个问题，如果用户在迭代的同时改变集合的内容，可能会
    /// 造成性能问题（如果集合是以写时复制来实现的话，这个对集合的额外引用将会
    /// 触发不必要的复制），因此如果可以为自定义的集合类型提供一个不需要引用
    /// 原始序列的indices类型，这是一个很值得尝试的优化。实际上只要索引位置的计算
    /// 不依赖于集合本身，例如标准库中的数组等，就是如此，因为FIFOQueue的索引
    /// 是整数类型，可以直接使用 Range<Int>。
    typealias Indices = Range<Int>
    var indices: Range<Int> {
        return startIndex..<endIndex
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

