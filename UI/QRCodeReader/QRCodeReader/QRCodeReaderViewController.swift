//
//  QRCodeReaderViewController.swift
//  QRCodeReader
//
//  Created by Rocoo on 2019/11/5.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import AVFoundation
import iOSCoreLibrary

class QRCodeReaderViewController: UIViewController {

    @IBOutlet weak var qrCodeView: UIView!

    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initObserver()
        checkCameraPermission()
    }

    func initObserver() {
      NotificationCenter.default.addObserver(self, selector: #selector(detectCameraPermission), name: .detectCameraPermission, object: nil)
    }

    @objc func detectCameraPermission() {
      DispatchQueue.main.async {
        self.checkCameraPermission()
      }
    }

    func checkCameraPermission() {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .authorized:
            initScanner()
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.present(alertControllerBuilder(title: "App needs your permission of camera to access", message: nil, firstButtonTitle: "Setting", secondButtonTitle: "Cancel") { (settingAction, cancelAction) in
                    if settingAction {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    if cancelAction {
                        print("clicked cancel button")
                    }
                }, animated: true, completion: nil)
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    self.initScanner()
                } else {
                    print("Camera permission denied")
                }
            }
        @unknown default:
            break
        }
    }

    func initScanner() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("No Camera")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]

            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = qrCodeView.layer.bounds
            qrCodeView.layer.addSublayer(videoPreviewLayer!)
            initScannerFrameView()
            captureSession.startRunning()
        } catch {
            print("AVCaptureDeviceInput Error: \(error.localizedDescription)")
        }

    }

    func initScannerFrameView() {
        qrCodeFrameView = UIView()
        guard let qrCodeFrameView = qrCodeFrameView else {
            return
        }
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        qrCodeView.addSubview(qrCodeFrameView)
        qrCodeView.bringSubviewToFront(qrCodeFrameView)
    }

}

extension QRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if metadataObjects.isEmpty {
            qrCodeFrameView?.frame = .zero
            print("No QR code is detected")
            return
        }

        if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject, metadataObj.type == .qr {

            if let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj) {
                qrCodeFrameView?.frame = barCodeObject.bounds
            }

            if let qrCodeContent = metadataObj.stringValue {
                print("QRCode Content: \(qrCodeContent)")
//                captureSession.stopRunning()
            }
        }
    }
}
