From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/3] sparse, llvm: Add test case for <stdbool.h> type
Date: Wed, 21 Dec 2011 11:25:27 +0200
Message-ID: <1324459528-9344-2-git-send-email-penberg@kernel.org>
References: <1324459528-9344-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57669 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149Ab1LUJZq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Dec 2011 04:25:46 -0500
Received: by lahd3 with SMTP id d3so467224lah.19
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2011 01:25:44 -0800 (PST)
In-Reply-To: <1324459528-9344-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

As it turns out, our validation test harness doesn't catch <stdbool.h> related
breakage so add a minimal test case that does.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 validation/backend/bool-test.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 validation/backend/bool-test.c

diff --git a/validation/backend/bool-test.c b/validation/backend/bool-test.c
new file mode 100644
index 0000000..51ae356
--- /dev/null
+++ b/validation/backend/bool-test.c
@@ -0,0 +1,11 @@
+#include <stdbool.h>
+
+static bool return_false(void)
+{
+	return false;
+}
+
+/*
+ * check-name: Boolean type code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
1.7.6.4

