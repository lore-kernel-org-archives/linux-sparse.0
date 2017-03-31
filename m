From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 13/25] constexpr: recognize address constants created through casts
Date: Fri, 31 Mar 2017 03:44:47 +0200
Message-ID: <20170331014459.9351-14-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36039 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935001AbdCaBqm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6so15309975wre.3
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:41 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

According to 6.6(9), an address constant may get created by casting
an integer constant to pointer type.

Make evaluate_cast() handle this case, that is tag a cast expression
as being an address constant if the target is a integer constant and
the destination is of pointer type.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                          |  7 +++++++
 validation/constexpr-pointer-cast.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 validation/constexpr-pointer-cast.c

diff --git a/evaluate.c b/evaluate.c
index c111f6d19..ce2e52e15 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2760,6 +2760,13 @@ static int cast_flags(struct expression *expr, struct expression *old)
 		 */
 		else if (old->flags & CEF_FLOAT)
 			flags = CEF_SET_ICE;
+	} else if (class & TYPE_PTR) {
+		/*
+		 * Casts of integer literals to pointer type yield
+		 * address constants [6.6(9)].
+		 */
+		if (old->flags & CEF_INT)
+			flags = CEF_ADDR;
 	}
 
 	return flags;
diff --git a/validation/constexpr-pointer-cast.c b/validation/constexpr-pointer-cast.c
new file mode 100644
index 000000000..d19c10828
--- /dev/null
+++ b/validation/constexpr-pointer-cast.c
@@ -0,0 +1,13 @@
+static int *a = (int*)0;	// OK
+static int b = 0;
+static int *c = (int*)b;	// KO
+
+
+/*
+ * check-name: integer literal cast to pointer type constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+constexpr-pointer-cast.c:3:18: warning: non-constant initializer for static object
+ * check-error-end
+ */
-- 
2.12.0

