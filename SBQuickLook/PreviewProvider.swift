//
//  PreviewProvider.swift
//  SBQuickLook
//
//  Created by C.W. Betts on 1/2/24.
//

import Foundation
#if os(macOS)
import Cocoa
import Quartz
#else
import QuickLook
import QuickLookThumbnailing
#endif
import QuartzCore
import SameQL

class PreviewProvider: QLPreviewProvider, QLPreviewingController {
    func providePreview(for request: QLFilePreviewRequest) async throws -> QLPreviewReply {
        let reply = QLPreviewReply(contextSize: CGSize(width: 640, height: 576), isBitmap: true) { ctx, reply in
            let status = SQLRender(ctx, request.fileURL as NSURL, false)
            guard status == noErr else {
                throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: [NSURLErrorKey: request.fileURL])
            }
        }
                
        return reply
    }
}
