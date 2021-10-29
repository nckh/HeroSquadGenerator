extension ClosedRange where Bound == Int {

  /// Returns a half-open interval with zero as the lower bound, and up to a random number within the range.
  /// For example, `3...5` becomes either `0..<3`, `0..<4`, or `0..<5`.
  ///
  /// Probably the worst method name I have ever came up with.
  func zeroLowerBoundRandomUpperBoundRange() -> Range<Bound> {
    let upperBound = randomElement() ?? 0
    return 0..<upperBound
  }

}
