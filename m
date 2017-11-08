From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/7] remove never-used MOD_TYPEDEF
Date: Wed,  8 Nov 2017 22:06:07 +0100
Message-ID: <20171108210613.14252-2-luc.vanoostenryck@gmail.com>
References: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53575 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753503AbdKHVIX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 16:08:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id r196so13602509wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 13:08:23 -0800 (PST)
In-Reply-To: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 gdbhelpers   | 3 ---
 show-parse.c | 1 -
 symbol.h     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/gdbhelpers b/gdbhelpers
index 86347863a..87ab5b8e9 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -128,9 +128,6 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_LONGLONGLONG)
 		printf "MOD_LONGLONGLONG "
 	end
-	if ($arg0->modifiers & MOD_TYPEDEF)
-		printf "MOD_TYPEDEF "
-	end
 	if ($arg0->modifiers & MOD_INLINE)
 		printf "MOD_INLINE "
 	end
diff --git a/show-parse.c b/show-parse.c
index d365d737f..2adeae961 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -132,7 +132,6 @@ const char *modifier_string(unsigned long mod)
 		{MOD_LONG,		"[long]"},
 		{MOD_LONGLONG,		"[long long]"},
 		{MOD_LONGLONGLONG,	"[long long long]"},
-		{MOD_TYPEDEF,		"[typedef]"},
 		{MOD_TLS,		"[tls]"},
 		{MOD_INLINE,		"inline"},
 		{MOD_ADDRESSABLE,	"[addressable]"},
diff --git a/symbol.h b/symbol.h
index 327449611..2c57d56e7 100644
--- a/symbol.h
+++ b/symbol.h
@@ -216,8 +216,6 @@ struct symbol {
 #define MOD_LONGLONGLONG	0x1000
 #define MOD_PURE	0x2000
 
-#define MOD_TYPEDEF	0x10000
