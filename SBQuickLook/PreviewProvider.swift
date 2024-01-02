//
//  PreviewProvider.swift
//  SBQuickLook
//
//  Created by C.W. Betts on 1/2/24.
//

import Cocoa
import Quartz
import SameQL

class PreviewProvider: QLPreviewProvider, QLPreviewingController {
    func providePreview(for request: QLFilePreviewRequest) async throws -> QLPreviewReply {
        let reply = QLPreviewReply(contextSize: NSMakeSize(640, 576), isBitmap: true) { ctx, reply in
            let status = SQLRender(ctx, request.fileURL as CFURL, false)
            guard status == noErr else {
                throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: [NSURLErrorKey: request.fileURL])
            }
        }
                
        return reply
    }
}
