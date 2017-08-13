//
//  SegmentioBuilder.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko on 11/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Segmentio
import UIKit

struct SegmentioBuilder {
    
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 0,
            color: #colorLiteral(red: 0.6581850052, green: 0.05978029221, blue: 0.1673380733, alpha: 1)
        )
    }
    
    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle) {
        segmentioView.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle)
        )
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Unused", image: nil),
            SegmentioItem(title: "Used", image: nil),
            SegmentioItem(title: "Expired", image: nil),
            SegmentioItem(title: "Mall", image: nil)
        ]
    }
    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle) -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        //一般配置
        return SegmentioOptions(
            backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            maxVisibleItems: 4,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.2
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont(name: "Avenir-Light", size: 15)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font!,
                titleTextColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            ),
            selectedState: segmentioState(
                backgroundColor: .clear,
                titleFont: font!,
                titleTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            ),
            highlightedState: segmentioState(
                backgroundColor: .clear,
                titleFont: font!,
                titleTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    //選擇的底部顏色
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: #colorLiteral(red: 0.6433975101, green: 0.05954954773, blue: 0.1625445485, alpha: 1)
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        )
    }
    
}
