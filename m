From: Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] sparse: add no_sanitize_address as an ignored attribute
Date: Wed,  1 Jun 2016 10:45:26 +0800
Message-ID: <1464749126-326-1-git-send-email-rui.teng@linux.vnet.ibm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:58119 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830AbcFACqM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 May 2016 22:46:12 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <rui.teng@linux.vnet.ibm.com>;
	Tue, 31 May 2016 20:46:11 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, Rui Teng <rui.teng@linux.vnet.ibm.com>

Add attribute "no_sanitize_address" or "__no_sanitize_address__" as an ignored
attribute. Fixes this sparse warning:

include/linux/compiler.h:232:8: error: attribute 'no_sanitize_address': unknown attribute

Also add test case for 'no_sanitize_address': validation/attr-no_sanitize_address.c.
'make check' says for this test case:
    TEST     attribute no_sanitize_address (attr-no_sanitize_address.c)

Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
---
 parse.c                               | 2 ++
 validation/attr-no_sanitize_address.c | 9 +++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 validation/attr-no_sanitize_address.c

diff --git a/parse.c b/parse.c
index b43d683..5a90b4d 100644
--- a/parse.c
+++ b/parse.c
@@ -601,6 +601,8 @@ const char *ignored_attributes[] = {
 	"__warning__",
 	"weak",
 	"__weak__",
+	"no_sanitize_address",
+	"__no_sanitize_address__",
 };
 
 
diff --git a/validation/attr-no_sanitize_address.c b/validation/attr-no_sanitize_address.c
new file mode 100644
index 0000000..b57ee55
--- /dev/null
+++ b/validation/attr-no_sanitize_address.c
@@ -0,0 +1,9 @@
+#define __no_sanitize_address __attribute__((no_sanitize_address))
+
+static void __no_sanitize_address bar(void)
+{
+}
+
+/*
+ * check-name: attribute no_sanitize_address
+ */
-- 
2.7.4

