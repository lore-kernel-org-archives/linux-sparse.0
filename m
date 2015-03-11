From: Michael Stefaniuc <mstefani@redhat.com>
Subject: [PATCH] Add a define for __builtin_ms_va_copy()
Date: Thu, 12 Mar 2015 00:22:14 +0100
Message-ID: <20150311232214.GB14617@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbbCKXWQ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2015 19:22:16 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BNMFha021550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2015 19:22:15 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.33.193.1])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2BNMFHI013514
	for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2015 19:22:15 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
Gets rid of the remaining "error: undefined identifier '__builtin_...'"
in Wine.


 lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib.c b/lib.c
index 58a7f2e..d5b56b0 100644
--- a/lib.c
+++ b/lib.c
@@ -970,6 +970,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#define __builtin_va_alist (*(void *)0)\n");
 	add_pre_buffer("#define __builtin_va_arg_incr(x) ((x) + 1)\n");
 	add_pre_buffer("#define __builtin_va_copy(dest, src) ({ dest = src; (void)0; })\n");
+	add_pre_buffer("#define __builtin_ms_va_copy(dest, src) ({ dest = src; (void)0; })\n");
 	add_pre_buffer("#define __builtin_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_ms_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_va_arg_pack()\n");
-- 
2.1.0
