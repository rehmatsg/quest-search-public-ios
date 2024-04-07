//
//  Button.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 26/06/23.
//

import SwiftUI
import Awesome
import ActivityIndicatorView

struct VibeButton: View {
    
    var label: String
    
    var action: (() -> Void)?
    
    var dense: Bool = false
    
    private var feedback: Bool = true
    
    var sfIcon: String?
    
    var awesomeIcon: Awesome.Image<Awesome.Brand>?
    
    var verticalAlignment: VerticalAlignment
    
    var cornerRadius: CGFloat
    
    private var backgroundColor: Color = Color(light: .black, dark: .accentColor)
    
    private var foregroundColor: Color = Color(light: .white, dark: .accentColor.accessibleFontColor)
    
    private var expanded: Bool = false
    
    private var disabled: Bool = false
    
    private var isLoading: Bool = false
    
    init(
        label: String,
        sfIcon: String? = nil,
        awesomeIcon: Awesome.Image<Awesome.Brand>? = nil,
        verticalAlignment: VerticalAlignment = .center,
        cornerRadius: CGFloat = 20,
        action: (() -> Void)? = nil
    ) {
        self.label = label
        self.action = action
        self.sfIcon = sfIcon
        self.awesomeIcon = awesomeIcon
        self.verticalAlignment = verticalAlignment
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Button(action: {
            if action != nil && !isLoading {
                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                impactMed.impactOccurred()
                action!()
            }
        }) {
            HStack(alignment: verticalAlignment) {
                ZStack {
                    if isLoading {
                        ActivityIndicatorView(isVisible: .constant(isLoading), type: .opacityDots(count: 3, inset: 5))
                            .frame(width: 40.0)
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)
                                )
                                .animation(.easeInOut)
                            )
                    }
                    HStack {
                        if sfIcon != nil {
                            Image(systemName: sfIcon!)
                        }
                        else if awesomeIcon != nil {
                            awesomeIcon!
                                .foregroundColor(.white)
                        }
                        Text(label)
                    }
                    .opacity(isLoading ? 0 : 1)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(foregroundColor)
            .font(.system(dense ? .body : .title3, design: .rounded))
            .opacity(disabled ? 0.5 : 1)
        }
        .buttonStyle(
            ScaleButtonStyle(
                backgroundColor: backgroundColor,
                verticalPadding: dense ? 10 : 20,
                horizontalPadding: dense ? 20 : 40,
                cornerRadius: cornerRadius,
                expanded: expanded
            )
        )
    }
    
    func expanded(_ isExpanded: Bool = true) -> VibeButton {
        var copy = self
        copy.expanded = isExpanded
        return copy
    }
    
    func disabled(_ isDisabled: Bool = true) -> VibeButton {
        var copy = self
        copy.disabled = isDisabled
        return copy
    }
    
    func loading(_ isLoading: Bool = true) -> VibeButton {
        var copy = self
        copy.isLoading = isLoading
        return copy
    }
    
    func dense(_ isDense: Bool = true) -> VibeButton {
        var copy = self
        copy.dense = isDense
        return copy
    }
    
    func backgroundStyle(_ color: Color) -> VibeButton {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    
    func foregroundStyle(_ color: Color) -> VibeButton {
        var copy = self
        copy.foregroundColor = color
        return copy
    }
    
}

struct IconButton: View {
    
    var icon: String
    
    var action: (() -> Void)?
    
    private var dense: Bool = false
    
    private var backgroundColor: Color = Color(light: .black, dark: .accentColor)
    
    private var foregroundColor: Color = Color(light: .white, dark: .accentColor.accessibleFontColor)
    
    private var disabled: Bool = false
    
    init(
        icon: String,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button {
            if action != nil {
                let impactMed = UIImpactFeedbackGenerator(style: .light)
                impactMed.impactOccurred()
                action!()
            }
        } label: {
            Image(systemName: icon)
                .font(dense ? .body : .title3)
                .foregroundColor(foregroundColor)
                .opacity(disabled ? 0.5 : 1)
        }
            .buttonStyle(
                ScaleButtonStyle(
                    backgroundColor: backgroundColor,
                    verticalPadding: dense ? 10 : 20,
                    horizontalPadding: dense ? 10 : 20,
                    cornerRadius: 30,
                    expanded: false,
                    useCircleClipShape: true
                )
            )
            .disabled(disabled)
            .opacity(disabled ? 0.5 : 1)
    }
    
    func dense(_ isDense: Bool = true) -> IconButton {
        var copy = self
        copy.dense = isDense
        return copy
    }
    
    func disabled(_ isDisabled: Bool = true) -> IconButton {
        var copy = self
        copy.disabled = isDisabled
        return copy
    }
    
    func backgroundStyle(_ color: Color) -> IconButton {
        var copy = self
        copy.backgroundColor = color
        return copy
    }
    
    func foregroundStyle(_ color: Color) -> IconButton {
        var copy = self
        copy.foregroundColor = color
        return copy
    }
    
}

struct ScaleButtonStyle: ButtonStyle {
    
    var backgroundColor: Color
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    var cornerRadius: CGFloat
    var expanded: Bool
    var useCircleClipShape: Bool = false
    
    struct CustomShape: Shape {
        var useCircle: Bool
        
        func path(in rect: CGRect) -> Path {
            if useCircle {
                return Circle().path(in: rect)
            } else {
                return Capsule().path(in: rect)
            }
        }
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .frame(maxWidth: expanded ? .infinity : nil)
            .background(
                CustomShape(useCircle: useCircleClipShape)
                    .fill(backgroundColor.opacity(configuration.isPressed ? 0.7 : 1))
                    .clipShape(
                        .rect(cornerRadius: configuration.isPressed ? cornerRadius * 0.95 : cornerRadius)
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.3), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
    
}

struct DismissIndicator: View {
    var body: some View {
        Rectangle()
            .fill(Color(hex: "#ebebeb"))
            .frame(width: 40, height: 5)
            .clipShape(
                .rect(cornerRadius: 5)
            )
    }
}

struct _VibeButtonPreviewScreen: View {
    
    @State
    private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VibeButton(
                    label: "Primary Button"
                )
                    .expanded()
                    .backgroundStyle(.accentColor)
                    .foregroundStyle(.accentColor.accessibleFontColor)
                IconButton(
                    icon: "square.and.arrow.up"
                )
                .backgroundStyle(.accentColor)
                .foregroundStyle(.accentColor.accessibleFontColor)
            }
            HStack {
                VibeButton(
                    label: "Secondary Button"
                )
                .expanded()
                .backgroundStyle(Color(light: Color.black, dark: Color.white))
                .foregroundStyle(Color(light: Color.white, dark: Color.black))
                
                IconButton(
                    icon: "paperplane"
                )
                .backgroundStyle(Color(light: Color.black, dark: Color.white))
                .foregroundStyle(Color(light: Color.white, dark: Color.black))
            }
            HStack {
                VibeButton(
                    label: "Tertiary Button"
                )
                .expanded()
                .backgroundStyle(.secondaryBackground)
                .foregroundStyle(.primary)
                IconButton(
                    icon: "trash"
                )
                .backgroundStyle(.secondaryBackground)
                .foregroundStyle(.red)
            }
            HStack {
                VibeButton(
                    label: "Disabled Button"
                )
                .expanded()
                .disabled()
                .foregroundStyle(.primary)
                .backgroundStyle(.secondaryBackground)
                
                IconButton(
                    icon: "tray.full"
                )
                .foregroundStyle(.primary)
                .backgroundStyle(.secondaryBackground)
                .disabled()
            }
            VibeButton(
                label: "Loading Button"
            ) {
                withAnimation {
                    isLoading = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
            .expanded()
            .loading(isLoading)
        }
        .padding(.horizontal, 12)
    }
}

struct VibeButtonPreview: PreviewProvider {
    static var previews: some View {
        _VibeButtonPreviewScreen()
    }
}
