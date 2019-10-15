//
//  SettingsTests.swift
//  YippyTests
//
//  Created by Matthew Davidson on 26/9/19.
//  Copyright © 2019 MatthewDavidson. All rights reserved.
//

import XCTest
@testable import Yippy
@testable import RxRelay
@testable import RxTest
@testable import RxSwift

class SettingsTests: XCTestCase {
    
    var old: [String: Any]!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        old = UserDefaults.standard.blank()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        UserDefaults.standard.restore(from: old)
    }
    
    func assertHistorySaved(_ history: [HistoryItem]) {
        _ = expectation(for: NSPredicate(block: { (_, _) -> Bool in
            return Settings.main!.history == history
        }), evaluatedWith: nil, handler: .none)
        waitForExpectations(timeout: 3, handler: .none)
    }

    func testDefaultSettings() {
        // 1. Given nothing
        
        // 2. Load the settings
        let settings = Settings.main
        
        // 3. Assert they are default values
        XCTAssertNotNil(settings)
//        XCTAssertEqual(settings!.panelPosition, Settings.default.panelPosition)
//        XCTAssertEqual(settings!.pasteboardChangeCount, Settings.default.pasteboardChangeCount)
//        XCTAssertEqual(settings!.history, Settings.default.history)
        XCTAssertEqual(settings!, Settings.default)
    }

    func testPersistentStorage() {
        // 1. Given settings
        var settings = Settings.main
        
        // 2. Set some things
        settings?.panelPosition = .bottom
        settings?.pasteboardChangeCount = 42
        settings?.history = [HistoryItem()]
        Settings.main = settings
        // Retrieve the settings again
        settings = Settings.main
        
        // 3. Check they have been saved
        XCTAssertEqual(settings?.panelPosition, .bottom)
        XCTAssertEqual(settings?.pasteboardChangeCount, 42)
        assertHistorySaved([HistoryItem()])
    }
    
    func testObserving() {
        // 1. Given fresh settings
        XCTAssertEqual(Settings.main.panelPosition, Settings.default.panelPosition)
        XCTAssertEqual(Settings.main.pasteboardChangeCount, Settings.default.pasteboardChangeCount)
        XCTAssertEqual(Settings.main.history, Settings.default.history)
        let disposeBag = DisposeBag()
        
        // 2. Bind settings to behaviour relays
        let panelPosition = BehaviorRelay<PanelPosition>(value: .right)
        Settings.main.bindPanelPositionTo(state: panelPosition).disposed(by: disposeBag)
        panelPosition.accept(.bottom)
        
        let pasteboardChangeCount = BehaviorRelay<Int>(value: -1)
        Settings.main.bindPasteboardChangeCountTo(state: pasteboardChangeCount).disposed(by: disposeBag)
        pasteboardChangeCount.accept(42)
        
        let history = BehaviorRelay<[HistoryItem]>(value: [])
        Settings.main.bindHistoryTo(state: history).disposed(by: disposeBag)
        history.accept([HistoryItem()])
        
        // 3. Check that the settings have been saved
        XCTAssertEqual(Settings.main.panelPosition, .bottom)
        XCTAssertEqual(Settings.main.pasteboardChangeCount, 42)
        assertHistorySaved([HistoryItem()])
    }
}
