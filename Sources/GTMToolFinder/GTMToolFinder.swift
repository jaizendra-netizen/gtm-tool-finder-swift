import Foundation

/// One page of the OneGTMLab tool directory (https://www.onegtmlab.dev/tool-directory).
public struct Entry: Codable, Equatable {
    public let name: String
    /// Tool, Category, Comparison or Glossary.
    public let kind: String
    public let url: String
    public let summary: String

    enum CodingKeys: String, CodingKey { case name = "n", kind = "k", url = "u", summary = "d" }
}

/// Search the OneGTMLab GTM tool directory: API reviews of sales and marketing tools,
/// head-to-head comparisons and GTM glossary terms. The index ships inside the package,
/// so it works offline and sends no data anywhere.
public enum GTMToolFinder {
    public static let kinds = ["Tool", "Category", "Comparison", "Glossary"]

    /// Every entry of the directory.
    public static let all: [Entry] = {
        guard let data = indexJSON.data(using: .utf8),
              let list = try? JSONDecoder().decode([Entry].self, from: data) else { return [] }
        return list
    }()

    /// Entries whose name or description contains every word of `query`.
    /// `kind` filters by Tool, Category, Comparison or Glossary (case-insensitive).
    public static func search(_ query: String = "", kind: String? = nil, limit: Int = 20) -> [Entry] {
        let words = query.lowercased().split(separator: " ").map(String.init)
        let order = Dictionary(uniqueKeysWithValues: kinds.enumerated().map { ($1, $0) })
        let hits = all.filter { e in
            if let k = kind, e.kind.lowercased() != k.lowercased() { return false }
            let text = (e.name + " " + e.summary).lowercased()
            return words.allSatisfy { text.contains($0) }
        }
        let ranked = hits.enumerated().sorted { a, b in
            let ra = (words.first.map { a.element.name.lowercased().hasPrefix($0) } ?? false) ? 0 : 1
            let rb = (words.first.map { b.element.name.lowercased().hasPrefix($0) } ?? false) ? 0 : 1
            if ra != rb { return ra < rb }
            let ka = order[a.element.kind] ?? 9, kb = order[b.element.kind] ?? 9
            if ka != kb { return ka < kb }
            return a.offset < b.offset
        }.map { $0.element }
        return Array(ranked.prefix(limit))
    }
}
