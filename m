From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 08/14] cast: make [u]intptr_ctype alias of [s]size_t_ctype
Date: Thu, 17 Aug 2017 06:05:23 +0200
Message-ID: <20170817040529.7289-9-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37369 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEF4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so3127138wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:56 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When processing integer to/from pointers, we would like to have
an integer type which has the same size as a pointer.

Currently, it's always th case for [s]size_t but it's preferable
to have a specific type which will always offer this guarantee,
like [u]intptr_t.

Fix this lazily by defining [u]intptr_ctype to [s]size_t_ctype.

Note: this intptr_t is just internal to sparse and can be different
      from the type choosen by the libc/platform.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/symbol.h b/symbol.h
index 327449611..3e343e41e 100644
--- a/symbol.h
+++ b/symbol.h
@@ -270,6 +270,9 @@ extern struct symbol	bool_ctype, void_ctype, type_ctype,
 			incomplete_ctype, label_ctype, bad_ctype,
 			null_ctype;
 
+#define	uintptr_ctype	 size_t_ctype
+#define	 intptr_ctype	ssize_t_ctype
+
 /* Special internal symbols */
 extern struct symbol	zero_int;
 
-- 
2.14.0

