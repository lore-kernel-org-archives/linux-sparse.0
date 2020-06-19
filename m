From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] gensel: add testcases from DR481
Date: Fri, 19 Jun 2020 17:02:56 +0200
Message-ID: <20200619150300.63695-2-luc.vanoostenryck@gmail.com>
References: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390621AbgFSPEG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C2C0613EE
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so10552741eju.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:05 -0700 (PDT)
In-Reply-To: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Following the resolution of DR481, the controlling expression
is subject to a few different rules.

Add the testcases from this defect report.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/generic-dr481.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 validation/generic-dr481.c

diff --git a/validation/generic-dr481.c b/validation/generic-dr481.c
new file mode 100644
index 000000000000..2ed15c9bc6d3
--- /dev/null
+++ b/validation/generic-dr481.c
@@ -0,0 +1,17 @@
+static char const* a = _Generic("bla", char*: "blu");
+static char const* b = _Generic("bla", char[4]: "blu");
+static char const* c = _Generic((int const){ 0 }, int: "blu");
+static char const* d = _Generic((int const){ 0 }, int const: "blu");
+static char const* e = _Generic(+(int const){ 0 }, int: "blu");
+static char const* f = _Generic(+(int const){ 0 }, int const: "blu");
+
+/*
+ * check-name: generic-dr481
+ * check-known-to-fail
+ *
+ * check-error-start
+generic-dr481.c:2:32: error: no generic selection for 'char *'
+generic-dr481.c:4:32: error: no generic selection for 'int const [toplevel]'
+generic-dr481.c:6:32: error: no generic selection for 'int'
+ * check-error-end
+ */
-- 
2.27.0
