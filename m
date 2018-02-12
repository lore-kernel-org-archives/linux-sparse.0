From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] fix usage of deadborn loads
Date: Mon, 12 Feb 2018 23:02:40 +0100
Message-ID: <20180212220246.17750-4-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35510 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbeBLWC5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:57 -0500
Received: by mail-wr0-f196.google.com with SMTP id 33so2740993wro.2
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:02:57 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In some situations, loads and others instructions can be
unreachable already when linearized, for example in code like:
	void foo(int *ptr)
	{
		return;
		*ptr;
	}
Such loads are detected in find_dominating_stores() and must
be discarded. This is done and the load have its opcode set
to OP_LNOP (wich is only useful for debugging) but it's
address is left as being used by the load.

Fix this by removing the address usage.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                             | 2 +-
 validation/mem2reg/load-deadborn.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 validation/mem2reg/load-deadborn.c

diff --git a/flow.c b/flow.c
index c614a11d9..528c8f32d 100644
--- a/flow.c
+++ b/flow.c
@@ -479,7 +479,7 @@ static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
 
 	/* Unreachable load? Undo it */
 	if (!bb) {
-		insn->opcode = OP_LNOP;
+		kill_use(&insn->src);
 		return 1;
 	}
 
diff --git a/validation/mem2reg/load-deadborn.c b/validation/mem2reg/load-deadborn.c
new file mode 100644
index 000000000..fa0baeae8
--- /dev/null
+++ b/validation/mem2reg/load-deadborn.c
@@ -0,0 +1,9 @@
+static void foo(int a)
+{
+	return;
+	a;
+}
+
+/*
+ * check-name: load-deadborn
+ */
-- 
2.16.0

