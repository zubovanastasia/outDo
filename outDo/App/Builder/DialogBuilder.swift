//
//  DialogBuilder.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class DialogBuilder {
    
    static let shared = DialogBuilder()
    
    lazy var navigationDrawer: NavigationDrawerPopup? = {
        return screenFactory?.makeNavigationDrawerPopup()
    }()
    
    weak var screenFactory: ScreenFactory?
    
    struct DialogModel {
        
        var dialog: UIViewController
        var parent: UIWindow
        var isRemoving: Bool
        
        init(_ dialog: UIViewController, _ parent: UIWindow) {
            self.dialog = dialog
            self.parent = parent
            self.isRemoving = false
        }
    }
    
    private var items = [DialogModel]()
    
    func show(_ dialog: UIViewController?, transition: TTransition = .crossdisolve, needDarkness: Bool = true, vSpace: CGFloat = 0, level: CGFloat = 0) {
        guard let dialog = dialog else { return }
        let leading = (Styles.shared.view.screenWidth - dialog.view.frame.width) / 2
        var frame: CGRect
        if transition == .showFromTop {
            frame = CGRect(x: leading, y: vSpace, width: dialog.view.frame.width, height: dialog.view.frame.height)
        }
        else if transition == .showFromBottom {
            let y = Styles.shared.view.screenHeight - dialog.view.frame.height - vSpace
            frame = CGRect(x: leading, y: y, width: dialog.view.frame.width, height: dialog.view.frame.height)
        }
        else if transition == .showFromRight {
            frame = CGRect(x: 0, y: 0, width: dialog.view.frame.width, height: dialog.view.frame.height)
        }
        else {
            frame = UIScreen.main.bounds
        }
    
        let vc = DialogRootVC()
        var root: UIWindow
        if #available(iOS 13.0, *), let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            root = UIWindow(windowScene: scene)
            root.frame = frame
        } else {
            root = UIWindow(frame: frame)
        }

        root.rootViewController = vc
        root.windowLevel = UIWindow.Level.alert + 1 + level
        
        dialog.transitioningDelegate = vc.transition
        dialog.modalPresentationStyle = .custom
        vc.delegate = root
        vc.transition.transition = transition
        vc.transition.vSpace = vSpace
        vc.needDarkness = needDarkness
        root.makeKeyAndVisible()
        vc.present(dialog, animated: true, completion: nil)
        items.append(DialogModel(dialog, root))
    }
    
    func remove(_ dialog: UIViewController, animated: Bool = false) {
        if let index = items.firstIndex(where: { $0.dialog == dialog }) {
            remove(at: index, animated: animated)
        }
    }
    
    private func remove(at index: Int, animated: Bool = false) {
        var dm = items[index]
        if dm.isRemoving { return }
        if let dialog = dm.dialog as? UIAlertController {
            dialog.dismiss(animated: true, completion: nil)
            dialog.actions.first?.isEnabled = false
        }
        dm.isRemoving = true
        dm.dialog.dismiss(animated: animated) {
            dm.dialog.removeFromParent()
            (dm.parent.rootViewController as? DialogRootVC)?.delegate = nil
            dm.parent.rootViewController?.dismiss(animated: false, completion: nil)
            dm.parent.isHidden = true
        }
        self.items.remove(at: index)
    }
    
    func removeAll() {
        let count = items.count
        if count == 0 { return }
        for index in (0 ..< count).reversed() {
            remove(at: index)
        }
    }
    
    func isVisible(_ dialog: UIViewController) -> Bool {
        if let index = items.firstIndex(where: { $0.dialog == dialog }) {
            for i in index + 1 ..< items.count {
                let dm = items[i]
                if dm.dialog.isKind(of: ToastPopup.self) { continue }
                return false
            }
            return true
        }
        return false
    }
}

// MARK: - Get Dialog
extension DialogBuilder {
    
    private func getDialog(_ viewClass: AnyClass) -> UIViewController? {
        return items.first(where: { $0.dialog.isKind(of: viewClass) })?.dialog
    }
}
    
// MARK: - Show Dialog
extension DialogBuilder {
  
    func showNavigationDrawer(completion: TActionAnyClosure?) {
        navigationDrawer?.presenter.completion = completion
        show(navigationDrawer,
             transition: .crossdisolve,
             needDarkness: false)
        navigationDrawer?.presenter.show()
    }
    
    func showAlert(_ data: AlertData) {
        show(
            screenFactory?.makeAlertPopup(data: data),
            transition: .crossdisolve)
    }
    
    func showDatePicker(date: Date?, onApply completion: DateClosure?) {
        show(
            screenFactory?.makeDatePickerPopup(
                date: date,
                onApply: completion),
            transition: .bottomsheet)
    }
    
    func showToast(_ message: String) {
        show(
            screenFactory?.makeToastPopup(message: message),
            transition: .showFromBottom,
            needDarkness: false,
            vSpace: 20 + Styles.shared.view.bottomInset,
            level: 100)
    }
}
    
// MARK: - Remove Dialog
extension DialogBuilder {
    
}
