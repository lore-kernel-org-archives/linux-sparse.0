From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/5] Fix an "'__sentinel__' attribute directive ignored" warning
Date: Sat, 18 Jul 2009 21:37:47 +0100
Message-ID: <4A62329B.9040107@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:41060 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753670AbZGRVJs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:09:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


This attribute was introduced in gcc 3.5. In order to avoid
such warnings, add a gcc version check when defining the
SENTINEL_ATTR macro. (This warning message, in particular,
was issued by a gcc 3.4.4 compiler).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

I had some, somewhat old, patches kicking around in my sparse
repo which may be useful; so I'm sending them along for your
consideration.

For this patch, an alternative solution (which I haven't tried)
would be to add -Wno-attributes to CFLAGS.

ATB,
Ramsay Jones

 lib.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib.h b/lib.h
index b22fa93..919b5b1 100644
--- a/lib.h
+++ b/lib.h
@@ -70,7 +70,11 @@ struct token *expect(struct token *, int, const char *);
 #ifdef __GNUC__
 #define FORMAT_ATTR(pos) __attribute__ ((__format__ (__printf__, pos, pos+1)))
 #define NORETURN_ATTR __attribute__ ((__noreturn__))
-#define SENTINEL_ATTR __attribute__ ((__sentinel__))
+#if ((__GNUC__ * 100 + __GNUC__MINOR__) >= 305)  /* gcc version >= 3.5 */
+# define SENTINEL_ATTR __attribute__ ((__sentinel__))
+#else
+# define SENTINEL_ATTR
+#endif
 #else
 #define FORMAT_ATTR(pos)
 #define NORETURN_ATTR
-- 
1.6.3.1


