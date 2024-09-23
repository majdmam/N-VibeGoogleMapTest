//
//  UIViewControllerExtension.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit

extension UIViewController {
    func openInNewNavigationController(from viewController: UIViewController?, presentationStyle: UIModalPresentationStyle = .overFullScreen, transitionStyle: UIModalTransitionStyle = .coverVertical) {
        let navController = UINavigationController(rootViewController: self)
        navController.modalPresentationStyle = presentationStyle
        navController.modalTransitionStyle = transitionStyle
        viewController?.present(navController, animated: true)
    }
    
    func showErrorToast(message: String, icon: Constants.Images = .errorTriangle) {
        showToast(model: ToastModel(message: message, icon: icon, toastStyle: .error))
    }
    
    func showSuccessToast(message: String, icon: Constants.Images = .success2) {
        showToast(model: ToastModel(message: message, icon: icon, toastStyle: .success))
    }
    
    func showWarningToast(message: String, icon: Constants.Images = .errorTriangle) {
        showToast(model: ToastModel(message: message, icon: icon, toastStyle: .warning))
    }
    
    func showErrorToastAfter(message: String, icon: Constants.Images = .errorTriangle) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Constants.toastAfter)) {
            self.showToast(model: ToastModel(message: message, icon: icon, toastStyle: .error))
        }
    }
    
    func showSuccessToastAfter(message: String, icon: Constants.Images = .success2) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Constants.toastAfter)) {
            self.showToast(model: ToastModel(message: message, icon: icon, toastStyle: .success))
        }
    }
    
    func showWarningToastAfter(message: String, icon: Constants.Images = .errorTriangle) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Constants.toastAfter)) {
            self.showToast(model: ToastModel(message: message, icon: icon, toastStyle: .warning))
        }
    }
    
    private func showToast(model: ToastModel) {
        if Toast.isShowingNow {
            return
        }
        if model.message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        let toast = Toast()
        toast.toast = model
        if let vc = UIViewController.topPresentedVC() {
            toast.configureInside(container: vc.view)
            Toast.isShowingNow = true
            UIView.animate(withDuration: 1.5, delay: 2.0, options: .curveEaseOut, animations: {
                toast.alpha = 0.0
            }, completion: {(isCompleted) in
                Toast.isShowingNow = false
                toast.removeFromSuperview()
            })
        }
    }
    
    static func getWindow() -> UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
    
    static func getWindow(index: Int) -> UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
    
    static func getWindowCount() -> Int {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.count ?? 0
    }
    
    static func topPresentedVC() -> UIViewController? {
        let windowsCount = getWindowCount()
        if windowsCount < 1 {
            return nil
        }
        let index = windowsCount == 1 ? 0 : windowsCount == 2 ? 0 : windowsCount - 2
        guard let window = getWindow(index: index) else { return nil }
        if var topVC = window.rootViewController?.presentedVC() {
            if let u = topVC as? UINavigationController, u.presentedViewController != nil {
                topVC = u.presentedViewController!
            }
            return topVC
        }
        return nil
    }
    
    private func presentedVC() -> UIViewController? {
        if self.presentedViewController != nil {
            return self.presentedViewController?.presentedVC()
        } else {
            return self
        }
    }
}
