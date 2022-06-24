Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3389EC433EF
	for <linux-sparse@archiver.kernel.org>; Fri, 24 Jun 2022 16:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFXQqL (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiFXQqJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Jun 2022 12:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4150032
        for <linux-sparse@vger.kernel.org>; Fri, 24 Jun 2022 09:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708FE622F5
        for <linux-sparse@vger.kernel.org>; Fri, 24 Jun 2022 16:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0C8C34114;
        Fri, 24 Jun 2022 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656089167;
        bh=tQPASPYBrhtAaP/xuHHMNarWkRMi1n5PkvyUGO5ej+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=NUivbH9bBA8tpZPGAL5anvYIOYZ+dGrePv7jJZOGheDkX8ieEA4UXdOyNU6bCEiwl
         YJ+VdITFDcRrfKPVmZDjE1IFyImWt5aomAOaiTvQjssMvGVYh9JdeY/PcggbllQiJn
         RRLvhICApO2Fy4G6wYocn3yI6dssSx9LaYO74qRYimhLVR68jU3y6ODIo73M5+Myno
         QYlgzyje6KxbSJ4k2LY8qHNdv/VBVD3nHR7wCp0oWU/JhNVuNYne0u9BCvYmowr5/s
         GynuCm+HfTIWFer7IvwTFGGpvGvw6NY/XIbzOwqU8TE+EcLdvOJ9+DcmzvCLCetcSb
         WVCBsVdYn7p2g==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] fix "unreplaced" warnings caused by using typeof() on inline functions
Date:   Fri, 24 Jun 2022 18:46:01 +0200
Message-Id: <20220624164601.99527-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse do all its inlining at the tree level, during
constant expansion. To not mix-up the evaluation of the original
function body in case the address of an inline function is taken or
when the function can't otherwise be inlined, the statements and
symbols lists of inline functions are kept in separated fields.
Then, if the original body must be evaluated it must first be
'uninlined' to have a copy in the usual fields.

This make sense when dealing with the definition of the function.
But, when using typeof() on functions, the resulting type doesn't
refer to this definition, it's just a copy of the type and only
of the type. There shouldn't be any reasons to uninline anything.
However, the distinction between 'full function' and 'type only'
is not made during evaluation and the uninlining attempt produce
a lot of "warning: unreplaced symbol '...'" because of the lack
of a corresponding definition.

Fix this by not doing the uninlining if the symbol lack a definition.

Note: It would maybe be more appropriate for EXPR_TYPE to use
      a stripped-own version of evaluate_symbol() doing only the
      examination of the return and argument types, bypassing the
      attempt to uninline the body and evaluate the initializer and
      the statements since there is none of those for an EXPR_TYPE.

Link: https://lore.kernel.org/all/202206191726.wq70mbMK-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                                    |  2 +-
 validation/inline-early/unreplaced-abstract.c | 28 +++++++++++++++++++
 validation/optim/devirtualize0.c              | 17 +++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 validation/inline-early/unreplaced-abstract.c
 create mode 100644 validation/optim/devirtualize0.c

diff --git a/evaluate.c b/evaluate.c
index 61f59ee3908e..fe716f631987 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3555,7 +3555,7 @@ static struct symbol *evaluate_symbol(struct symbol *sym)
 		current_fn = sym;
 
 		examine_fn_arguments(base_type);
-		if (!base_type->stmt && base_type->inline_stmt)
+		if (!base_type->stmt && base_type->inline_stmt && sym->definition)
 			uninline(sym);
 		if (base_type->stmt)
 			evaluate_statement(base_type->stmt);
diff --git a/validation/inline-early/unreplaced-abstract.c b/validation/inline-early/unreplaced-abstract.c
new file mode 100644
index 000000000000..e38cd6681f14
--- /dev/null
+++ b/validation/inline-early/unreplaced-abstract.c
@@ -0,0 +1,28 @@
+static inline void f0(void) { }
+static inline long f1(long a) { return a + 1;}
+
+_Static_assert([typeof(f0)] != [typeof(f1)]);
+
+
+static inline void g0(void) { }
+static inline long g1(long a) { return a + 1;}
+
+extern long goo(long a);
+long goo(long a)
+{
+	g0();
+	return g1(a);
+}
+
+_Static_assert([typeof(g0)] != [typeof(g1)]);
+
+extern long moo(long a);
+long moo(long a)
+{
+	typeof(f1) *f = g1;
+	return f(a);
+}
+
+/*
+ * check-name: unreplaced-abstract
+ */
diff --git a/validation/optim/devirtualize0.c b/validation/optim/devirtualize0.c
new file mode 100644
index 000000000000..7079e79072fe
--- /dev/null
+++ b/validation/optim/devirtualize0.c
@@ -0,0 +1,17 @@
+static inline long f1(long x) { return x + 1;}
+
+extern long foo(long a);
+long foo(long a)
+{
+	typeof(f1) *f = f1;
+	return f(a);
+}
+
+/*
+ * check-name: devirtualize0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: call\\.
+ */
-- 
2.36.1

