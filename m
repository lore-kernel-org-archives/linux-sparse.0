From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH] Handle SForced in storage_modifiers
Date: Mon, 14 Nov 2016 14:12:16 -0500
Message-ID: <1479150736-28392-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754187AbcKNTMR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 14:12:17 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Al Viro <viro@ftp.linux.org.uk>

We have been seeing errors like this for a while now in the sparse
Fedora package, when doing kernel builds:

    ./include/linux/err.h:53:25: warning: dereference of noderef expression
    ./include/linux/err.h:35:16: warning: dereference of noderef expression

This spews all over the build because this comes from IS_ERR(), which
is called everywhere. Even odder, it turns out that if we build the
package with -fpic turned off, then it works fine.

With some brute-force debugging, I think I've finally found the cause.
This array is missing the SForced element. When this is added then the
problem goes away.

As to why this goes away when -fpic is removed, I can only assume that
we get lucky with the memory layout and have a zeroed out region just
beyond the end of the array.

Fixes: 3829c4d8b097776e6b3472290a9fae08a705ab7a
Cc: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 205e12644a6c..b290ff2636f2 100644
--- a/parse.c
+++ b/parse.c
@@ -1286,7 +1286,8 @@ static unsigned long storage_modifiers(struct decl_state *ctx)
 		[SAuto] = MOD_AUTO,
 		[SExtern] = MOD_EXTERN,
 		[SStatic] = MOD_STATIC,
-		[SRegister] = MOD_REGISTER
+		[SRegister] = MOD_REGISTER,
+		[SForced] = 0
 	};
 	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0)
 		| (ctx->is_tls ? MOD_TLS : 0);
-- 
2.7.4

