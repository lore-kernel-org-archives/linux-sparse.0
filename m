From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] keyword: regroup the [reserved] keywords
Date: Fri,  5 May 2017 03:50:30 +0200
Message-ID: <20170505015034.65164-3-luc.vanoostenryck@gmail.com>
References: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36153 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdEEBvy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 21:51:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so6861597wmu.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 18:51:53 -0700 (PDT)
In-Reply-To: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The idents in "ident-list.h" are probably organized mainly
in the chronological order of their addition to the file and
as such a bit dispersed here and there.

Change this by regrouping them in Basic C/C99/C11/GCC extensions/...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 3c7547783..dbed06858 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -16,7 +16,6 @@ IDENT_RESERVED(for);
 IDENT_RESERVED(while);
 IDENT_RESERVED(do);
 IDENT_RESERVED(goto);
-IDENT_RESERVED(_Static_assert);
 
 /* C typenames. They get marked as reserved when initialized */
 IDENT(struct);
@@ -26,13 +25,22 @@ IDENT(__attribute); IDENT(__attribute__);
 IDENT(volatile); IDENT(__volatile); IDENT(__volatile__);
 IDENT(double);
 
+/* C storage classes. They get marked as reserved when initialized */
+IDENT(static);
+
+/* C99 keywords */
+IDENT(restrict); IDENT(__restrict); IDENT(__restrict__);
+
+/* C11 keywords */
+IDENT_RESERVED(_Alignof);
+IDENT_RESERVED(_Static_assert);
+
 /* Special case for L'\t' */
 IDENT(L);
 
 /* Extended gcc identifiers */
 IDENT(asm); IDENT_RESERVED(__asm); IDENT_RESERVED(__asm__);
 IDENT(alignof); IDENT_RESERVED(__alignof); IDENT_RESERVED(__alignof__); 
-IDENT_RESERVED(_Alignof);
 IDENT_RESERVED(__sizeof_ptr__);
 IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
@@ -88,12 +96,10 @@ IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
 IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
-IDENT(restrict); IDENT(__restrict); IDENT(__restrict__);
 IDENT(artificial); IDENT(__artificial__);
 IDENT(leaf); IDENT(__leaf__);
 IDENT(vector_size); IDENT(__vector_size__);
 IDENT(error); IDENT(__error__);
-IDENT(static);
 
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
-- 
2.12.0

