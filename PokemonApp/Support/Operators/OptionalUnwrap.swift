//
//  OptionalUnwrap.swift
//  PokemonApp
//
//  Created by Giuseppe Mazzilli on 15/01/2021.
//

import Foundation

precedencegroup Group {
    associativity : left
    higherThan : NilCoalescingPrecedence
}

infix operator ?!: Group

@discardableResult func ?!<T, U>(lhs: T?, rhs: (T) -> U?) -> U? {
    guard let lhs = lhs else { return nil }
    return rhs(lhs)
}
