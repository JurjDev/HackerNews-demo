//
//  DateFormat.swift
//  HackerNews
//
//  Created by JurjDev on 15/04/21.
//

import Foundation

struct DateFormat: RawRepresentable {
    
    let rawValue: (hours: Int, minutes: Int, seconds: Int)
    
    public init(rawValue: (hours: Int, minutes: Int, seconds: Int)) {
        self.rawValue = rawValue
    }
}

extension DateFormat {
    
    public init(withSeconds seconds: Int) {
        self.init(rawValue: (
        hours: seconds / 3600,
        minutes: (seconds % 3600) / 60,
        seconds: (seconds % 3600) % 60
        ))
    }
    
    public init(withDate seconds: Int) {
        let newsDate = Date(timeIntervalSince1970: Double(seconds))
        let timeSinceDate = Date().timeIntervalSince(newsDate)
        self.init(withSeconds: Int(timeSinceDate))
    }
}

// MARK: - Equatable

extension DateFormat: Equatable {
    
    static func == (lhs: DateFormat, rhs: DateFormat) -> Bool {
        return rhs.rawValue.0 == lhs.rawValue.0 &&
            rhs.rawValue.1 == lhs.rawValue.1 &&
            rhs.rawValue.2 == lhs.rawValue.2
    }
}

// MARK: - Hashable

extension DateFormat: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue.0)
        hasher.combine(rawValue.1)
        hasher.combine(rawValue.2)
    }
}

// MARK: - CustomStringConvertible

extension DateFormat: CustomStringConvertible {
    public var description: String {
        switch rawValue {
        case (let hours, _, _) where hours >= 24:
            let days = rawValue.hours / 24
            if days > 1 {
                return String(format: Strings.Time.days, days)
            } else {
                return Strings.Time.yesterday
            }
        case (let hours, _, _) where hours < 24 && hours > 0:
            return String(format: Strings.Time.hours, hours)
        case (let hours, let minutes, _) where hours == 0 && minutes > 0:
            return String(format: Strings.Time.minutes, minutes)
        case (let hours, let minutes, let seconds) where hours == 0 && minutes == 0 && seconds > 0:
            return String(format: Strings.Time.seconds, seconds)
        default: return ""
        }
    }
}
