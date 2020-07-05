From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: add testcase for bogus linearization of >>= & /=
Date: Sun,  5 Jul 2020 14:38:50 +0200
Message-ID: <20200705123850.25924-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGEMi6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 08:38:58 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57789C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 05:38:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dm19so25904738edb.13
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 05:38:58 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When doing a shift operation, both arguments are subjected to
integer promotion and the type of the result is simply the type
of the promoted left operand. Easy.

But for a shift-assignment, things are slightly more complex:
  -) 'a >>= n' should be equivalent to 'a = a >> n'
  -) but the type of the result must be the type of the left
     operand *before* integer promotion.

Currently, the linearization code use the type of the right
operand to infer of the type of the operation. But simply changing
the code to use the type of the left operand will also be wrong
(for example for signed/unsigned divisions). Nasty.

For example, the following C code:
	int s = ...;
	s >>= 11U;
is linearized as a logical shift:
	lsr.32      %r2 <- %arg1, $11
while, of course it's an arithmetic shift that is expected:
	asr.32      %r2 <- %arg1, $11

So, add a testcase for these.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/bug-assign-op0.c | 115 +++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 validation/linear/bug-assign-op0.c

diff --git a/validation/linear/bug-assign-op0.c b/validation/linear/bug-assign-op0.c
new file mode 100644
index 000000000000..0cabc6222b8a
--- /dev/null
+++ b/validation/linear/bug-assign-op0.c
@@ -0,0 +1,115 @@
+int asr(int s)
+{
+	s >>= 11U;
+	return s;
+}
+
+unsigned int lsr(unsigned int u)
+{
+	u >>= 11;
+	return u;
+}
+
+int divr(int s, unsigned long u)
+{
+	extern int use(int, unsigned);
+	int t = s;
+	s = s / u;
+	u = u / t;
+	return use(s, u);
+}
+
+int sdivul(int s, unsigned long u)
+{
+	s /= u;			// divu
+	return s;
+}
+
+unsigned int udivsl(unsigned int u, long s)
+{
+	u /= s;			// divs
+	return u;
+}
+
+int uldivs(int s, unsigned long u)
+{
+	u /= s;			// divu
+	return u;
+}
+
+unsigned int sldivu(unsigned int u, long s)
+{
+	s /= u;			// divs
+	return s;
+}
+
+/*
+ * check-name: bug-assign-op0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+asr:
+.L0:
+	<entry-point>
+	asr.32      %r2 <- %arg1, $11
+	ret.32      %r2
+
+
+lsr:
+.L2:
+	<entry-point>
+	lsr.32      %r6 <- %arg1, $11
+	ret.32      %r6
+
+
+divr:
+.L4:
+	<entry-point>
+	sext.64     %r11 <- (32) %arg1
+	divu.64     %r13 <- %r11, %arg2
+	trunc.32    %r14 <- (64) %r13
+	divu.64     %r18 <- %arg2, %r11
+	trunc.32    %r21 <- (64) %r18
+	call.32     %r22 <- use, %r14, %r21
+	ret.32      %r22
+
+
+sdivul:
+.L6:
+	<entry-point>
+	sext.64     %r26 <- (32) %arg1
+	divu.64     %r27 <- %r26, %arg2
+	trunc.32    %r28 <- (64) %r27
+	ret.32      %r28
+
+
+udivsl:
+.L8:
+	<entry-point>
+	zext.64     %r33 <- (32) %arg1
+	divs.64     %r34 <- %r33, %arg2
+	trunc.32    %r35 <- (64) %r34
+	ret.32      %r35
+
+
+uldivs:
+.L10:
+	<entry-point>
+	sext.64     %r39 <- (32) %arg1
+	divu.64     %r41 <- %arg2, %r39
+	trunc.32    %r43 <- (64) %r41
+	ret.32      %r43
+
+
+sldivu:
+.L12:
+	<entry-point>
+	zext.64     %r46 <- (32) %arg1
+	divs.64     %r48 <- %arg2, %r46
+	trunc.32    %r50 <- (64) %r48
+	ret.32      %r50
+
+
+ * check-output-end
+ */
-- 
2.27.0
