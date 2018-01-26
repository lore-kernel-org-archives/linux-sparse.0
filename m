From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib.c: early return from handle_onoff_switch()
Date: Thu, 25 Jan 2018 18:12:54 -0800
Message-ID: <d198c16f-9dcf-3238-942f-889c4322ba54@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbeAZCNG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Jan 2018 21:13:06 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

From: Randy Dunlap <rdunlap@infradead.org>

When handling "-Wsparse-all" in handle_onoff_switch(), once all
warning flags have been set, the function can return instead of
checking for "no-" or other option names because they won't be
found. Just return NULL, which is what happens when handling
"-Wsparse-all" anyway.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib.c |    1 +
 1 file changed, 1 insertion(+)

--- sprs-2018-0119.orig/lib.c
+++ sprs-2018-0119/lib.c
@@ -565,6 +565,7 @@ static char **handle_onoff_switch(char *
 			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
 				*warnings[i].flag = WARNING_ON;
 		}
+		return NULL;
 	}
 
 	// Prefixes "no" and "no-" mean to turn warning off.

