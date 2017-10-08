//
//  WorkingQueue.swift
//  StateManager
//
//  Created by Jovan Jovanovski on 10/7/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

struct WorkingQueue<T> {
    
    private var array = [T?]()
    private var head = 0
    
    private let elementHandler: (T) -> ()
    
    init(elementHandler: @escaping (T) -> ()) {
        self.elementHandler = elementHandler
    }
    
    private var isEmpty: Bool {
        return count == 0
    }
    
    private var count: Int {
        return array.count - head
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
        print("⛏ Enqueued element")
        
        if count == 1 {
            while let element = front {
                elementHandler(element)
                _ = dequeue()
            }
            
            print("⛏")
            print("⛏ No more elements left")
            print("⛏")
        } else {
            print("⛏ \(count - 1) other elements are still in the queue")
        }
    }
    
    private mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        print("⛏ Dequeued element")
        return element
    }
    
    private var front: T? {
        return isEmpty ? nil : array[head]
    }
    
}
