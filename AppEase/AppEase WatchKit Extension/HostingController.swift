//
//  HostingController.swift
//  Testing WatchKit Extension
//
//  Created by Vidit Bhargava on 11/16/20.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<AnyView> {
    override var body: AnyView {
        return AnyView(ContentView().environmentObject(UserStateManager()))
    }
}
