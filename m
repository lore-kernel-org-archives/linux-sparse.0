From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] teach sparse to linearize __builtin_unreachable()
Date: Wed, 18 Mar 2020 18:31:20 +0100
Message-ID: <20200318173120.63939-6-luc.vanoostenryck@gmail.com>
References: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCRRbc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so4371126wmi.5
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2020 10:31:29 -0700 (PDT)
In-Reply-To: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

__builtin_unreachable() is one of the builtin that shouldn't
be ignored at IR level since it directly impact the CFG.

So, add the infrastructure put in place in the previous patch
to generate the OP_UNREACH instruction instead of generating
a call to a non-existing function "__builtin_unreachable()".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                              | 7 +++++++
 validation/context-unreachable.c         | 1 -
 validation/linear/builtin_unreachable0.c | 1 -
 validation/linear/builtin_unreachable1.c | 1 -
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/linearize.c b/linearize.c
index 25d6327bf6f1..615636ed1f83 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2536,12 +2536,19 @@ struct entrypoint *linearize_symbol(struct symbol *sym)
  * Builtin functions
  */
 
+static pseudo_t linearize_unreachable(struct entrypoint *ep, struct expression *exp)
+{
+	add_unreachable(ep);
+	return VOID;
+}
+
 static struct sym_init {
 	const char *name;
 	pseudo_t (*linearize)(struct entrypoint *, struct expression*);
 	struct symbol_op op;
 } builtins_table[] = {
 	// must be declared in builtin.c:declare_builtins[]
+	{ "__builtin_unreachable", linearize_unreachable },
 	{ }
 };
 
diff --git a/validation/context-unreachable.c b/validation/context-unreachable.c
index 3e330403ce01..8664962ea088 100644
--- a/validation/context-unreachable.c
+++ b/validation/context-unreachable.c
@@ -12,5 +12,4 @@ static void foo(void)
 
 /*
  * check-name: context-unreachable
- * check-known-to-fail
  */
diff --git a/validation/linear/builtin_unreachable0.c b/validation/linear/builtin_unreachable0.c
index 5da9d074ae5f..fb59a3408987 100644
--- a/validation/linear/builtin_unreachable0.c
+++ b/validation/linear/builtin_unreachable0.c
@@ -10,7 +10,6 @@ int foo(int p)
 /*
  * check-name: builtin_unreachable0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 foo:
diff --git a/validation/linear/builtin_unreachable1.c b/validation/linear/builtin_unreachable1.c
index 280f853d8a07..a83da079a3c9 100644
--- a/validation/linear/builtin_unreachable1.c
+++ b/validation/linear/builtin_unreachable1.c
@@ -12,7 +12,6 @@ int foo(int c)
  * check-name: builtin_unreachable1
  * check-command: test-linearize -Wno-decl $file
  *
- * check-known-to-fail
  * check-output-start
 foo:
 .L0:
-- 
2.25.1
