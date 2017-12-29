From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] let handle_switches() also handle reverse logic
Date: Fri, 29 Dec 2017 22:46:24 +0100
Message-ID: <20171229214625.41368-2-luc.vanoostenryck@gmail.com>
References: <20171229214625.41368-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37125 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdL2Vqe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 29 Dec 2017 16:46:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id f140so49679241wmd.2
        for <linux-sparse@vger.kernel.org>; Fri, 29 Dec 2017 13:46:33 -0800 (PST)
In-Reply-To: <20171229214625.41368-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some flags, for good or less good reasons, exist under two
different names: like a positive version and a negative one.
This is in addition of the 'no-' prefix.

The use case here is '-f[no-][un]signed-char'.

Make it easy and allow to specify that a given flag is the
negative version of another one so that '-fsigned-char' is
handled exactly as '-fno-unsigned-char'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib.c b/lib.c
index e4bb639e5..b018eb972 100644
--- a/lib.c
+++ b/lib.c
@@ -578,6 +578,8 @@ static int handle_switches(const char *ori, const char *opt, const struct flag *
 
 		// boolean flag
 		if (opt[0] == '\0' && flags->flag) {
+			if (flags->mask & OPT_INVERSE)
+				val = !val;
 			*flags->flag = val;
 			return 1;
 		}
-- 
2.15.0

