import AppKit

final class ResponseViewController: NSViewController {

  var string: String? {
    didSet {
      textView.string = string ?? ""
    }
  }

  @IBOutlet private var textView: NSTextView!

  override func awakeFromNib() {
    super.awakeFromNib()

    if let fontDescriptor = NSFont.systemFont(ofSize: 16).fontDescriptor.withDesign(.monospaced) {
      textView.font = NSFont(descriptor: fontDescriptor, size: 16)
    }
  }

}
