//
//  SendMail.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 08.06.2021.
//

import UIKit
import MessageUI
import SwiftLog

extension UIViewController {
  
  func sendEmailLogs() {
    
    if MFMailComposeViewController.canSendMail() {
      let composeVC = MFMailComposeViewController()
      composeVC.mailComposeDelegate = self
      
      // Configure the fields of the interface.
      composeVC.setToRecipients(["rustamburger@gmail.com"])
      composeVC.setSubject("Send Email Logs")
      composeVC.setMessageBody("", isHTML: false)
      
      var attachmentData: NSData?
      
      let path = Log.logger.currentPath
      if FileManager.default.fileExists(atPath: path) {
        if let data = NSData(contentsOfFile: path) {
          attachmentData = data
        }
      }
      
      guard let attData = attachmentData as Data? else { return }
      composeVC.addAttachmentData(attData, mimeType: "text/plain", fileName: "crash.log")
      self.present(composeVC, animated: true, completion: nil)
      
    } else {
      // Tell user about not able to send email directly.
    }
  }
}

extension UIViewController: MFMailComposeViewControllerDelegate {
  public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}
