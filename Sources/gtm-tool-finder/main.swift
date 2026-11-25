import Foundation
import GTMToolFinder

var args = Array(CommandLine.arguments.dropFirst())
var kind: String? = nil
var limit = 20
var words: [String] = []
while !args.isEmpty {
    let a = args.removeFirst()
    if a == "--kind", !args.isEmpty { kind = args.removeFirst() }
    else if a == "--limit", !args.isEmpty { limit = Int(args.removeFirst()) ?? 20 }
    else { words.append(a) }
}
let hits = GTMToolFinder.search(words.joined(separator: " "), kind: kind, limit: limit)
if hits.isEmpty {
    print("Nothing found. Try a tool name like apollo or clay.")
    exit(1)
}
for h in hits { print("[\(h.kind)] \(h.name)\n    \(h.url)") }
