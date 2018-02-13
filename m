From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 05/10] fix usage of deadborn loads
Date: Tue, 13 Feb 2018 22:58:07 +0100
Message-ID: <20180213215812.18735-6-luc.vanoostenryck@gmail.com>
References: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55569 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965962AbeBMWAY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:00:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id a84so7452013wmi.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:00:24 -0800 (PST)
In-Reply-To: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
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
index 62658b920..2a6bf5ea3 100644
--- a/flow.c
+++ b/flow.c
@@ -481,7 +481,7 @@ static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
 
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

