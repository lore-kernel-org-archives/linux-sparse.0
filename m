From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] keyword: explicitly add C99 & C11 keywords
Date: Fri,  5 May 2017 03:50:31 +0200
Message-ID: <20170505015034.65164-4-luc.vanoostenryck@gmail.com>
References: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36266 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdEEBv5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 21:51:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so6861776wmu.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 18:51:57 -0700 (PDT)
In-Reply-To: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Explicitly add the new keywords introduced by C99 & C11 to
the file "ident-list.h" and insure that they are marked as
reserved (even if not used, so we're future-ready).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h          |  8 ++++++++
 validation/reserved.c | 21 ++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/ident-list.h b/ident-list.h
index dbed06858..709ffce01 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -30,10 +30,18 @@ IDENT(static);
 
 /* C99 keywords */
 IDENT(restrict); IDENT(__restrict); IDENT(__restrict__);
+IDENT(_Bool);
+IDENT_RESERVED(_Complex);
+IDENT_RESERVED(_Imaginary);
 
 /* C11 keywords */
+IDENT(_Alignas);
 IDENT_RESERVED(_Alignof);
+IDENT_RESERVED(_Atomic);
+IDENT_RESERVED(_Generic);
+IDENT(_Noreturn);
 IDENT_RESERVED(_Static_assert);
+IDENT(_Thread_local);
 
 /* Special case for L'\t' */
 IDENT(L);
diff --git a/validation/reserved.c b/validation/reserved.c
index 2ca9ac40a..546fd19dd 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -16,7 +16,17 @@ static int (__typeof__);
 static int (inline);
 static int (__inline);
 static int (__inline__);
+static int (_Alignas);
+static int (_Alignof);
+static int (_Atomic);
+static int (_Bool);
+static int (_Complex);
+static int (_Generic);
+static int (_Imaginary);
+static int (_Noreturn);
 static int (_Static_assert);
+static int (_Thread_local);
+
 /*
  * check-name: const et.al. are reserved identifiers
  * check-error-start:
@@ -38,6 +48,15 @@ reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier
 reserved.c:16:12: error: Trying to use reserved word 'inline' as identifier
 reserved.c:17:12: error: Trying to use reserved word '__inline' as identifier
 reserved.c:18:12: error: Trying to use reserved word '__inline__' as identifier
-reserved.c:19:12: error: Trying to use reserved word '_Static_assert' as identifier
+reserved.c:19:12: error: Trying to use reserved word '_Alignas' as identifier
+reserved.c:20:12: error: Trying to use reserved word '_Alignof' as identifier
+reserved.c:21:12: error: Trying to use reserved word '_Atomic' as identifier
+reserved.c:22:12: error: Trying to use reserved word '_Bool' as identifier
+reserved.c:23:12: error: Trying to use reserved word '_Complex' as identifier
+reserved.c:24:12: error: Trying to use reserved word '_Generic' as identifier
+reserved.c:25:12: error: Trying to use reserved word '_Imaginary' as identifier
+reserved.c:26:12: error: Trying to use reserved word '_Noreturn' as identifier
+reserved.c:27:12: error: Trying to use reserved word '_Static_assert' as identifier
+reserved.c:28:12: error: Trying to use reserved word '_Thread_local' as identifier
  * check-error-end:
  */
-- 
2.12.0

