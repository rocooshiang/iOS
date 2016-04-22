//
//  ViewController.swift
//  QRReaderDemo
//
//  Created by Rocoo on 2016/4/22.
//  Copyright (c) 2016 Rocoo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
  
  var captureSession : AVCaptureSession?
  var videoPreviewLayer : AVCaptureVideoPreviewLayer?
  var qrCodeFrameView: UIView?
  
  @IBOutlet weak var messageLabel:UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Initialize Device object , and support video type.
    let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    do{
      
      //Get AVCpatureDeviceInput object from  up Device object.
      let input : AnyObject! = try AVCaptureDeviceInput(device: captureDevice)
      
      // Initialize captureSession object , set input and output.
      captureSession = AVCaptureSession()
      captureSession?.addInput(input as! AVCaptureInput)
      
      let captureMetadataOutput = AVCaptureMetadataOutput()
      captureSession?.addOutput(captureMetadataOutput)
      
      // Set output delegate and type.
      captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
      captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
      
      //Add preview layer to view layer.
      videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
      videoPreviewLayer?.frame = self.view.bounds
      view.layer.addSublayer(videoPreviewLayer!)
      
      captureSession?.startRunning()
      
      // Set upper view.
      view.bringSubviewToFront(messageLabel)
      
      qrCodeFrameView = UIView()
      qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
      qrCodeFrameView?.layer.borderWidth = 2
      view.addSubview(qrCodeFrameView!)
      view.bringSubviewToFront(qrCodeFrameView!)
      
      
    }catch let error {
      print("error: \(error)")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
}


// MARK - AVCaptureMetadataOutputObjectsDelegate
extension ViewController : AVCaptureMetadataOutputObjectsDelegate{
  func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    
    //Not detected anything.
    if metadataObjects == nil || metadataObjects.count == 0 {
      qrCodeFrameView?.frame = CGRectZero
      messageLabel.text = "No QRCode is detected"
      return
    }
    
    //Detected data and determine the type , if type is QRCode , set qrCodeFrame , show metadata value.
    let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    if metadataObject.type == AVMetadataObjectTypeQRCode{
      let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObject)
      qrCodeFrameView?.frame = (barCodeObject?.bounds)!
      if let metadataObjectString = metadataObject.stringValue{
        messageLabel.text = metadataObjectString
      }
    }
    
  }
}

