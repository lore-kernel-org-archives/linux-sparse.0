From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] llvm: give names easier to debug
Date: Mon, 18 Sep 2017 11:30:13 +0200
Message-ID: <20170918093014.11878-5-luc.vanoostenryck@gmail.com>
References: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35431 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbdIRJa2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 05:30:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id e64so287387wmi.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 02:30:28 -0700 (PDT)
In-Reply-To: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

LLVM automatically add an numeric suffix for names
automatically created. So, if intermediate names must
be created for a pseudo whose name was, for example, "%R4",
these new names will be "%R41", "%R42".

This is quite annoying because we can't make the distinction
between these names and the original names, (maybe of some other
pseudos whose names were "%R41" & "%R42).

Change this by adding a "." at the end of each name, as this will
then allow to see what the original name was.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3a68d09d9..3fcc88686 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -277,10 +277,10 @@ static const char *pseudo_name(pseudo_t pseudo, char *buf)
 {
 	switch (pseudo->type) {
 	case PSEUDO_REG:
-		snprintf(buf, MAX_PSEUDO_NAME, "R%d", pseudo->nr);
+		snprintf(buf, MAX_PSEUDO_NAME, "R%d.", pseudo->nr);
 		break;
 	case PSEUDO_PHI:
-		snprintf(buf, MAX_PSEUDO_NAME, "PHI%d", pseudo->nr);
+		snprintf(buf, MAX_PSEUDO_NAME, "PHI%d.", pseudo->nr);
 		break;
 	case PSEUDO_SYM:
 	case PSEUDO_VAL:
@@ -1141,7 +1141,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 		LLVMValueRef arg;
 
 		arg = LLVMGetParam(function.fn, i);
-		snprintf(name, sizeof(name), "ARG%d", i+1);
+		snprintf(name, sizeof(name), "ARG%d.", i+1);
 		LLVMSetValueName(arg, name);
 	}
 
-- 
2.14.0

