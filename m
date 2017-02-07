From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] define __LONG_MAX__ & __SIZEOF_POINTER__
Date: Tue,  7 Feb 2017 21:04:24 +0100
Message-ID: <20170207200425.34189-4-luc.vanoostenryck@gmail.com>
References: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33433 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753893AbdBGUGf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:06:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so30256544wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:06:34 -0800 (PST)
In-Reply-To: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

They're part of GCC's common predefined macros and some
code & header files depends on them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib.c b/lib.c
index 018fa145e..2a1bbac87 100644
--- a/lib.c
+++ b/lib.c
@@ -804,7 +804,13 @@ static char **handle_switch(char *arg, char **next)
 
 static void predefined_macros(void)
 {
+	unsigned long long val;
+
 	add_pre_buffer("#define __CHECKER__ 1\n");
+
+	val = (1ULL << (bits_in_long-1)) - 1;
+	add_pre_buffer("#weak_define __LONG_MAX__ %#llxLL\n", val);
+	add_pre_buffer("#weak_define __SIZEOF_POINTER__ %d\n", bits_in_pointer/8);
 }
 
 void declare_builtin_functions(void)
-- 
2.11.0

