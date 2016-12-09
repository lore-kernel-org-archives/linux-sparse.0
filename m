From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] fix missing element in types declaration
Date: Sat, 10 Dec 2016 00:03:10 +0100
Message-ID: <20161209230311.36024-2-luc.vanoostenryck@gmail.com>
References: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34396 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753854AbcLIXD1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Dec 2016 18:03:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so71248wme.1
        for <linux-sparse@vger.kernel.org>; Fri, 09 Dec 2016 15:03:22 -0800 (PST)
In-Reply-To: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In the code doing the parsing of type declaration there is a few
arrays for the each integer size (short, int, long, long long, ...)
The array for the unsigned and explicitely unsigned integer have
entry for 'slllong' & 'ulllong' last element but the one for plain
integer is missing its 'lllong' entry which make sparse crash when
trying to use this type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index b52c6abe..808a078a 100644
--- a/parse.c
+++ b/parse.c
@@ -1429,7 +1429,7 @@ Catch_all:
 }
 
 static struct symbol * const int_types[] =
-	{&short_ctype, &int_ctype, &long_ctype, &llong_ctype};
+	{&short_ctype, &int_ctype, &long_ctype, &llong_ctype, &lllong_ctype};
 static struct symbol * const signed_types[] =
 	{&sshort_ctype, &sint_ctype, &slong_ctype, &sllong_ctype,
 	 &slllong_ctype};
-- 
2.10.2

