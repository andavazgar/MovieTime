//
//  CollapsibleSection.swift
//  MovieTime
//
//  Created by Andres Vazquez on 2023-02-11.
//

import SwiftUI

struct CollapsibleSection<Header: View, PinnedContent: View, CollapsibleContent: View>: View {
    var headerView: () -> Header
    var pinnedContent: () -> PinnedContent
    var collapsibleContent: () -> CollapsibleContent
    @State var isCollapsed: Bool
    @State private var headerAndPinnedContentHeight : CGFloat = 0
    @State private var fullContentHeight : CGFloat = 0
    
    init(isCollapsed: Bool = true,
         headerView: @escaping () -> Header,
         pinnedContent: @escaping () -> PinnedContent,
         collapsibleContent: @escaping () -> CollapsibleContent) {
        self.isCollapsed = isCollapsed
        self.headerView = headerView
        self.pinnedContent = pinnedContent
        self.collapsibleContent = collapsibleContent
    }
    
    init(isCollapsed: Bool = true,
         headerView: @escaping () -> Header,
         collapsibleContent: @escaping () -> CollapsibleContent) where PinnedContent == EmptyView {
        self.isCollapsed = isCollapsed
        self.headerView = headerView
        self.pinnedContent = { EmptyView() }
        self.collapsibleContent = collapsibleContent
    }
    
    var body: some View {
        VStack {
            Button(
                action: {
                    withAnimation {
                        isCollapsed.toggle()
                    }
                },
                label: {
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            headerView()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                                .id(isCollapsed)
                                .font(.title2)
                                .offset(y: -4)
                                .transition(.opacity.combined(with: .scale))
                        }
                        
                        pinnedContent()
                    }
                    .onCollapsedStateChanged(preferenceKey: MinimumHeightPreferenceKey.self) { height in
                        headerAndPinnedContentHeight = height
                    }
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                collapsibleContent()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onCollapsedStateChanged(preferenceKey: HeightPreferenceKey.self) { height in
            fullContentHeight = height
        }
        .frame(maxWidth: .infinity)
        .frame(height: isCollapsed ? headerAndPinnedContentHeight : fullContentHeight, alignment: .top)
        .clipped()
        .onTapGesture {
            withAnimation {
                isCollapsed.toggle()
            }
        }
    }
}

struct CollapsibleSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            // With pinnedContent
            CollapsibleSection(isCollapsed: true) {
                Text("Header")
            } pinnedContent: {
                Text("Content pinned with Header")
            } collapsibleContent: {
                Text("Content")
            }
            
            // Without pinnedContent
            CollapsibleSection(isCollapsed: false) {
                Text("Header")
            } collapsibleContent: {
                Text("Content")
            }
        }
    }
}


// MARK: - PreferenceKeys
struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}

struct MinimumHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}


// MARK: - Extensions
extension View {
    func onCollapsedStateChanged<T: PreferenceKey>(preferenceKey: T.Type, action: @escaping (_ height: CGFloat) -> Void) -> some View where T.Value == CGFloat {
        self
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(key: preferenceKey, value: geometry.frame(in: .local).size.height
                    )
                })
            .onPreferenceChange(preferenceKey) { newValue in
                action(newValue)
            }
    }
}
