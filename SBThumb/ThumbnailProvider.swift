//
//  ThumbnailProvider.swift
//  SBThumb
//
//  Created by C.W. Betts on 2/12/23.
//

import QuickLookThumbnailing
import SameQL

class ThumbnailProvider: QLThumbnailProvider {
    override func provideThumbnail(for request: QLFileThumbnailRequest, _ handler: @escaping (QLThumbnailReply?, Error?) -> Void) {
        // Second way: Draw the thumbnail into a context passed to your block, set up with Core Graphics's coordinate system.
        let reply = QLThumbnailReply(contextSize: CGSize(width: 1024, height: 1024), drawing: { (context) -> Bool in
            // Draw the thumbnail here.
            
            let success = SQLRender(context, request.fileURL as NSURL, true) == noErr
            
            // Return true if the thumbnail was successfully drawn inside this block.
            return success
        })
        handler(reply, nil)
    }
}
