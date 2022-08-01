//
//  test_variable_stateApp.swift
//  test_variable_state
//
//  Created by John on 2022/7/31.
//

import SwiftUI

@main
struct test_variable_stateApp: App {
    @StateObject var applicationViewModel = TestObservable()
    var body: some Scene {
        WindowGroup {
            TestUIView()
                .environmentObject(applicationViewModel)
        }
    }
}
