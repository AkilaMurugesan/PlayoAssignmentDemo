//
//  connectivity.swift
//  PlayoAssignment
//
//  Created by Arun Subbu on 7/16/22.
//

import Foundation
import Alamofire
import Reachability
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
    }
}
