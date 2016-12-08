From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Update maintainers in the manpage
Date: Thu,  8 Dec 2016 05:48:56 +0100
Message-ID: <20161208044856.14476-1-luc.vanoostenryck@gmail.com>
References: <20160111192813.GA27713@cloud>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33993 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcLHEtI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 23:49:08 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so52749458wjc.1
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 20:49:07 -0800 (PST)
In-Reply-To: <20160111192813.GA27713@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Josh Triplett <josh@joshtriplett.org>

The manpage still mentioned Josh Triplett as the maintainer
while Christopher is the maintainer since 2009.

CC: Christopher Li <sparse@chrisli.org>
CC: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse.1 b/sparse.1
index ccae55cc..4aeb0039 100644
--- a/sparse.1
+++ b/sparse.1
@@ -364,4 +364,4 @@ https://sparse.wiki.kernel.org/
 linux-sparse@vger.kernel.org
 .
 .SH MAINTAINER
-Josh Triplett <josh@kernel.org>
+Christopher Li <sparse@chrisli.org>
-- 
2.10.2

