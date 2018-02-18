import UIKit
import PlaygroundSupport

class V: UIViewController {
    let spider = UILabel()
    let web = UIView()
    var animator: UIViewPropertyAnimator!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        web.backgroundColor = .gray
        web.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(web)
        web.widthAnchor.constraint(equalToConstant: 2).isActive = true
        web.heightAnchor.constraint(equalToConstant: 12).isActive = true
        web.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        web.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spider.attributedText = NSAttributedString.init(string: "🕷"
            , attributes: [ .font : UIFont.systemFont(ofSize: 36)])
        spider.sizeToFit()
        spider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spider)
        spider.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spider.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSpider))
        spider.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateSpiderDrop()
    }

    private func animateSpiderDrop() {
        animator = UIViewPropertyAnimator(duration: 5, dampingRatio: 0.4) {
            self.spider.transform = CGAffineTransform(translationX: 0, y: 300)
            self.web.frame.size.height += 300
        }
        animator.isUserInteractionEnabled = true
        animator.startAnimation()
    }

    @objc private func tapSpider(_ recognizer: UITapGestureRecognizer) {
        guard animator != nil else {
            return
        }
        animator.stopAnimation(true)
        animator.finishAnimation(at: .current)
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.spider.transform = .identity
            self.web.frame.size.height = 12
        }
        animator.addCompletion { _ in
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.animateSpiderDrop()
            }
        }
        animator.isUserInteractionEnabled = false
        animator.startAnimation()
    }
}

PlaygroundPage.current.liveView = V()
