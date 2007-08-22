From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] add __builtin_labs()
Date: Wed, 22 Aug 2007 15:43:00 -0700
Message-ID: <20070822154300.c46c1fd0.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:32867 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761894AbXHVWnW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Aug 2007 18:43:22 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: josh@freedesktop.org

From: Randy Dunlap <randy.dunlap@oracle.com>

2.6.23-rc3-mm1 has added a user of __builtin_labs(), so add this function
to sparse lib.c to avoid the error messages.

  CHECK   kernel/unwind.c
kernel/unwind.c:1016:31: error: undefined identifier '__builtin_labs'
kernel/unwind.c:1232:25: error: undefined identifier '__builtin_labs'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 lib.c |    1 +
 1 file changed, 1 insertion(+)

--- sparse-2007-08-22.orig/lib.c
+++ sparse-2007-08-22/lib.c
@@ -590,6 +590,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_insql(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
+	add_pre_buffer("extern long __builtin_labs(long);\n");
 }
 
 void create_builtin_stream(void)
