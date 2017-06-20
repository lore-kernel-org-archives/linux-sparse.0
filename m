From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: __builtin_bswap{16,32,64}() constantness
Date: Tue, 20 Jun 2017 18:42:53 +0200
Message-ID: <20170620164253.76292-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35840 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFTQnC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 12:43:02 -0400
Received: by mail-qk0-f196.google.com with SMTP id r62so11680287qkf.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 09:43:01 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When expanding those builtins, we directly excludes a non-constant
arg (via the expression expansion cost) and the to retrieve the
value we use const_expression_value().

But const_expression_value() is to be used for expressions that
qualify as 'integer constant expression' as per the C standard.
However we want to be able to use this builtin with all integer
expressions having a known value at compile time, even those
not qualified as true 'integer constant expression'.

Fix this by using get_expression_value_silent() instead of
const_expression_value().

Note: this bug was found by testing sparse on the git tree
      on ARM64.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                           | 4 +++-
 validation/builtin-bswap-constant.c | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index dbb81032b..4f2a106cb 100644
--- a/builtin.c
+++ b/builtin.c
@@ -179,13 +179,15 @@ static struct symbol_op choose_op = {
 /* The argument is constant and valid if the cost is zero */
 static int expand_bswap(struct expression *expr, int cost)
 {
+	struct expression *arg;
 	long long val;
 
 	if (cost)
 		return cost;
 
 	/* the arguments number & type have already been checked */
-	val = const_expression_value(first_expression(expr->args));
+	arg = first_expression(expr->args);
+	val = get_expression_value_silent(arg);
 	switch (expr->ctype->bit_size) {
 	case 16: expr->value = __builtin_bswap16(val); break;
 	case 32: expr->value = __builtin_bswap32(val); break;
diff --git a/validation/builtin-bswap-constant.c b/validation/builtin-bswap-constant.c
index 4560f67e9..18574d4c5 100644
--- a/validation/builtin-bswap-constant.c
+++ b/validation/builtin-bswap-constant.c
@@ -16,6 +16,12 @@ unsigned long long bswap64(void)
 	return __builtin_bswap64(0x123456789abcdef0ULL);
 }
 
+unsigned int half_constant(void);
+unsigned int half_constant(void)
+{
+	int v = 0x12345678;
+	return __builtin_bswap32(v);
+}
 /*
  * check-name: builtin-bswap-constant
  * check-command: test-linearize $file
-- 
2.13.0

