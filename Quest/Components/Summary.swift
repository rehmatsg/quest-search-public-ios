//
//  Summary.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 25/03/24.
//

import SwiftUI
import MarkdownUI

struct Summary: View {
    
    var summary: String
    
    var body: some View {
        Markdown(
            MarkdownContent(preprocessMarkdown(summary))
        )
        .markdownTheme(.quest)
    }
    
    func preprocessMarkdown(_ markdown: String) -> String {
        let pattern = "\\[citation:(\\d+)\\]"
        let replacement = "[$1]"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let range = NSRange(markdown.startIndex..<markdown.endIndex, in: markdown)
            let modifiedString = regex.stringByReplacingMatches(in: markdown, options: [], range: range, withTemplate: replacement)
            return modifiedString
        }
        return markdown
    }
}

extension Theme {
public static let quest = Theme()
  .text {
      ForegroundColor(.text)
      BackgroundColor(Color(UIColor.systemBackground))
      FontSize(17)
  }
  .code {
      FontFamilyVariant(.monospaced)
      FontSize(.em(0.85))
      BackgroundColor(.secondaryBackground)
  }
  .strong {
      FontWeight(.semibold)
  }
  .link {
      ForegroundColor(.link)
  }
  .heading1 { configuration in
      configuration.label
          .relativePadding(.bottom, length: .em(0.3))
          .relativeLineSpacing(.em(0.125))
          .markdownMargin(top: 24, bottom: 12)
          .markdownTextStyle {
              FontWeight(.semibold)
              FontSize(.em(2))
          }
  }
  .heading2 { configuration in
      configuration.label
          .relativePadding(.bottom, length: .em(0.3))
          .relativeLineSpacing(.em(0.125))
          .markdownMargin(top: 24, bottom: 12)
          .markdownTextStyle {
              FontWeight(.semibold)
              FontSize(.em(1.5))
          }
  }
  .heading3 { configuration in
      configuration.label
          .relativeLineSpacing(.em(0.125))
          .markdownMargin(top: 24, bottom: 12)
          .markdownTextStyle {
              FontWeight(.semibold)
              FontSize(.em(1.25))
          }
  }
  .heading4 { configuration in
      configuration.label
          .relativeLineSpacing(.em(0.125))
          .markdownMargin(top: 24, bottom: 12)
          .markdownTextStyle {
              FontWeight(.semibold)
          }
  }
  .heading5 { configuration in
      configuration.label
          .relativeLineSpacing(.em(0.125))
          .markdownMargin(top: 24, bottom: 0)
          .markdownTextStyle {
              FontWeight(.semibold)
              FontSize(.em(0.875))
          }
  }
  .heading6 { configuration in
      configuration.label
          .relativeLineSpacing(.em(0.125))
          .markdownMargin(top: 24, bottom: 0)
          .markdownTextStyle {
              FontWeight(.semibold)
              FontSize(.em(0.85))
              ForegroundColor(.tertiaryText)
          }
  }
  .paragraph { configuration in
      configuration.label
          .fixedSize(horizontal: false, vertical: true)
          .relativeLineSpacing(.em(0.4))
          .markdownMargin(top: 0, bottom: 16)
  }
  .blockquote { configuration in
      HStack(spacing: 0) {
          RoundedRectangle(cornerRadius: 6)
              .fill(Color.border)
              .relativeFrame(width: .em(0.2))
          configuration.label
              .markdownTextStyle { ForegroundColor(.secondaryText) }
              .relativePadding(.horizontal, length: .em(1))
      }
      .fixedSize(horizontal: false, vertical: true)
  }
  .codeBlock { configuration in
    ScrollView(.horizontal) {
      configuration.label
        .fixedSize(horizontal: false, vertical: true)
        .relativeLineSpacing(.em(0.225))
        .markdownTextStyle {
          FontFamilyVariant(.monospaced)
          FontSize(.em(0.85))
        }
        .padding(16)
    }
    .background(Color.secondaryBackground)
    .clipShape(RoundedRectangle(cornerRadius: 6))
    .markdownMargin(top: 0, bottom: 16)
  }
  .listItem { configuration in
    configuration.label
      .markdownMargin(top: .em(0.25))
  }
  .taskListMarker { configuration in
    Image(systemName: configuration.isCompleted ? "checkmark.square.fill" : "square")
      .symbolRenderingMode(.hierarchical)
      .foregroundStyle(Color.checkbox, Color.checkboxBackground)
      .imageScale(.small)
      .relativeFrame(minWidth: .em(1.5), alignment: .trailing)
  }
  .table { configuration in
    configuration.label
      .fixedSize(horizontal: false, vertical: true)
      .markdownTableBorderStyle(.init(color: .border))
      .markdownTableBackgroundStyle(
        .alternatingRows(Color(UIColor.systemBackground), Color.secondaryBackground)
      )
      .markdownMargin(top: 0, bottom: 16)
  }
  .tableCell { configuration in
    configuration.label
      .markdownTextStyle {
        if configuration.row == 0 {
          FontWeight(.semibold)
        }
        BackgroundColor(nil)
      }
      .fixedSize(horizontal: false, vertical: true)
      .padding(.vertical, 6)
      .padding(.horizontal, 13)
      .relativeLineSpacing(.em(0.25))
  }
  .thematicBreak {
    Divider()
      .relativeFrame(height: .em(0.25))
      .overlay(Color.border)
      .markdownMargin(top: 24, bottom: 24)
  }
}

extension Color {
  fileprivate static let secondaryText = Color(
    light: Color(rgba: 0x6b6e_7bff), dark: Color(rgba: 0x9294_a0ff)
  )
  fileprivate static let tertiaryText = Color(
    light: Color(rgba: 0x6b6e_7bff), dark: Color(rgba: 0x6d70_7dff)
  )
  fileprivate static let link = Color(
    light: Color(rgba: 0x2c65_cfff), dark: Color(rgba: 0x4c8e_f8ff)
  )
  fileprivate static let checkbox = Color(rgba: 0xb9b9_bbff)
  fileprivate static let checkboxBackground = Color(rgba: 0xeeee_efff)
}

func getSampleSummary() -> String {
    return """
Samuel Harris Altman is an American entrepreneur and investor best known as the **CEO of OpenAI** since 2019 (he was briefly fired and reinstated in November 2023). Altman is considered to be one of the leading figures of the AI boom. He dropped out of Stanford University after two years and founded Loopt, a mobile social networking service, raising more than $30 million in venture capital [citation:1]. In 2011, Altman joined Y Combinator, a startup accelerator, and was its president from 2014 to 2019.

## Early Life
Altman was born on April 22, 1985, in Chicago, Illinois,[citation:6][citation:7] into a Jewish family,[8] and grew up in St. Louis, Missouri. His mother is a dermatologist, while his father was a real estate broker. Altman is the eldest of four siblings.[citation:9] At the age of eight, he received his first computer, an Apple Macintosh, and began to learn how to code and take apart computer hardware.[citation:10][citation:11] He attended John Burroughs School, a private school in Ladue, Missouri.[citation:12] In 2005, after two years at Stanford University studying computer science, he dropped out without earning a bachelor's degree.[citation:1]
"""
}

#Preview {
    ScrollView {
        Summary(summary: getSampleSummary())
            .padding(.horizontal, 12)
            .padding(.vertical, 20)
    }
}
