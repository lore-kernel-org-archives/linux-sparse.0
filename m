From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/5] Fix an "'__sentinel__' attribute directive ignored" warning
Date: Tue, 22 May 2007 18:58:47 +0100
Message-ID: <46532F57.1060806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-fallback-93.mail.demon.net ([194.217.242.93]:63328 "EHLO
	anchor-fallback-93.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756849AbXEWJ0W (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 05:26:22 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4052 "EHLO
	anchor-post-34.mail.demon.net") by anchor-fallback-93.mail.demon.net
	with ESMTP id S355419AbXEVSRP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 19:17:15 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


This attribute was introduced in gcc 3.5. My Cygwin install, which
is not that old, is using gcc 3.4.4.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  lib.h |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib.h b/lib.h
index df9cfc4..6902f91 100644
--- a/lib.h
+++ b/lib.h
@@ -68,10 +68,16 @@ typedef struct pseudo *pseudo_t;
  struct token *skip_to(struct token *, int);
  struct token *expect(struct token *, int, const char *);
  #ifdef __GNUC__
+#define GCC_VERSION (__GNUC__ * 1000 + __GNUC__MINOR__)
  #define FORMAT_ATTR(pos) __attribute__ ((__format__ (__printf__, pos, pos+1)))
  #define NORETURN_ATTR __attribute__ ((__noreturn__))
+/* __sentinel__ attribute was introduced in gcc 3.5 */
+#if (GCC_VERSION >= 3005)
  #define SENTINEL_ATTR __attribute__ ((__sentinel__))
  #else
+#define SENTINEL_ATTR
+#endif /* gcc >= 3.5 */
+#else
  #define FORMAT_ATTR(pos)
  #define NORETURN_ATTR
  #define SENTINEL_ATTR
-- 
1.5.1
