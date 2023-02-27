Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5467DC64ED6
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Feb 2023 19:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjB0Tj5 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjB0Tj4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2023 14:39:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971127D49
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2023 11:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1852060F10
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2023 19:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27825C433D2;
        Mon, 27 Feb 2023 19:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677526769;
        bh=+0BMPkfbvEjFXZ/Pf4xCzrgB0sRBf2UOfT/UecGKZ1s=;
        h=From:To:Cc:Subject:Date:From;
        b=ftBsntkNVeqjDJvkfp9XhpUN+Qf4ZTDd7ERlJu8m8sQzlr4q14fgQzehtlyX5/4B7
         rYkRBGtNdsZgqSyJiUTlJsYcoqTHgC/UJyLmFrwSqjaC8h5oV0RgWlmZXyLrw3FsrX
         07yEd74oZqfSZIMLHbY8tZt6w47SCGT49Sg4sxQSbhYDVxN1Vrl+H+Y3dSFxXIQL8Z
         9OofUoDYW66u8fTTWbNuZqYmAmHQd1OR6g1FAFYOTSgdvldVxhcMaBwq6Je40o2hTJ
         ZxijkokKqUzo3adbObi6rgWFqu29brFrDjOudCPSLYWhiqCKexXDmNXcGNVIk5E0wy
         e29x0aTAXZI5Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     luc.vanoostenryck@gmail.com
Subject: [sparse PATCH resend] linearize.c: fix buffer overrun warning from fortify
Date:   Mon, 27 Feb 2023 14:39:27 -0500
Message-Id: <20230227193927.87985-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The resulting string from snprintf, won't be nearly 64 bytes, but "buf"
is only 16 bytes long here. This causes FORTIFY_SOURCE to complain when
given the right options.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index d9aed61b361f..1db2d505a7d4 100644
--- a/linearize.c
+++ b/linearize.c
@@ -91,7 +91,7 @@ const char *show_label(struct basic_block *bb)
 
 	if (!bb)
 		return ".L???";
-	snprintf(buf, 64, ".L%u", bb->nr);
+	snprintf(buf, 16, ".L%u", bb->nr);
 	return buf;
 }
 
-- 
2.39.2

