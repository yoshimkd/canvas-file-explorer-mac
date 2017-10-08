//
//  StateManager.swift
//  StateManager
//
//  Created by Jovan Jovanovski on 10/7/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Dispatch

public final class StateManager
<S: State, E: Event, SS, SD: StatesDifference> {
    
    //MARK:
    //MARK: Types
    
    public typealias Handler = (S?, E) -> [StateChangeRequest<S, SS>]
    public typealias StatesDifferenceCreator = (S?, S) -> SD
    public typealias Applier = (SD, Bool, SS?, @escaping () -> ()) -> ()
    
    //MARK:
    //MARK: Properties
    
    private var state: S?
    private var eventsPipeline: WorkingQueue<E>!
    
    private let handlers: [Handler]
    private let statesDifferenceCreator: StatesDifferenceCreator
    private let applier: Applier
    
    //MARK:
    //MARK: Initializer
    
    public init(handlers: [Handler],
                statesDifferenceCreator: @escaping StatesDifferenceCreator,
                applier: @escaping Applier) {
        self.handlers = handlers
        self.statesDifferenceCreator = statesDifferenceCreator
        self.applier = applier
    }
    
    public func setup() {
        eventsPipeline = WorkingQueue<E>(elementHandler: eventHandler)
    }
    
    //MARK:
    //MARK: Methods
    
    public func handle(event: E, inBackground: Bool = true) {
        print("⚡")
        print("⚡ The event \(event) is received by the state manager")
        print("⚡")
        
        if inBackground {
            print("⚡ Will enqueue the event in the background")
            DispatchQueue.global().async {
                [event = event] in
                self.eventsPipeline.enqueue(event)
            }
        } else {
            print("⚡ Will enqueue the event on the calling thread")
            eventsPipeline.enqueue(event)
        }
    }
    
    private func eventHandler(event: E) {
        print("✋ Starting handling event: \(event)")
        let transitions = handlers.flatMap {
            [state = state] handler in
            return handler(state, event)
        }
        perform(transitions: transitions)
        print("✋ Finished handling event: \(event)")
    }
    
    private func perform(transitions: [StateChangeRequest<S, SS>]) {
        if transitions.isEmpty {
            print("⇒ No transitions requested to be performed")
            return
        }
        
        print("⇒ Requested to perform: \(transitions.count) transitions")
        transitions.enumerated().forEach {
            [unowned self, applier = applier] index, transition in
            print("⇒ Starting performing transition with index: \(index)")
            
            let statesDifference =
                statesDifferenceCreator(self.state, transition.endState)
            print("⇒ Created states difference")
            
            let semaphore = DispatchSemaphore(value: 0)
            applier(
                statesDifference,
                transition.animated,
                transition.screenSignals,
                {
                    [semaphore = semaphore] in
                    semaphore.signal()
                }
            )
            semaphore.wait()
            self.state = transition.endState
            print("⇒ Finished performing transition with index: \(index)")
        }
    }
    
}

//MARK:
//MARK: Protocols

public protocol State {}
public protocol Event {}
public protocol StatesDifference {}

func print(_ items: Any...) {
    #if DEBUG
//        Swift.print(items[0])
    #endif
}
