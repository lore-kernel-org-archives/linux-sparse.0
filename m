From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 15/15] add support for wider type in switch-case
Date: Mon, 27 Mar 2017 19:34:05 +0200
Message-ID: <20170327173405.11405-16-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36541 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdC0RhN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id u1so15370216wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:28 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the different cases of a switch-statement, or more
exactly the 'struct multijmp' that hold the value of these cases
excepted only value of 'int' type. Trying to use a wider value
results in the value being truncated but any integer value should
be valid.

Fix this by unsigned 'long long' to hold these values.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c              |  8 ++++----
 linearize.h              |  2 +-
 validation/switch-long.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 validation/switch-long.c

diff --git a/linearize.c b/linearize.c
index 574ccea94..209bd2bf3 100644
--- a/linearize.c
+++ b/linearize.c
@@ -77,7 +77,7 @@ static struct basic_block *alloc_basic_block(struct entrypoint *ep, struct posit
 	return bb;
 }
 
-static struct multijmp *alloc_multijmp(struct basic_block *target, int begin, int end)
+static struct multijmp *alloc_multijmp(struct basic_block *target, long long begin, long long end)
 {
 	struct multijmp *multijmp = __alloc_multijmp(0);
 	multijmp->target = target;
@@ -368,9 +368,9 @@ const char *show_instruction(struct instruction *insn)
 		buf += sprintf(buf, "%s", show_pseudo(insn->cond));
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
 			if (jmp->begin == jmp->end)
-				buf += sprintf(buf, ", %d -> .L%u", jmp->begin, jmp->target->nr);
+				buf += sprintf(buf, ", %lld -> .L%u", jmp->begin, jmp->target->nr);
 			else if (jmp->begin < jmp->end)
-				buf += sprintf(buf, ", %d ... %d -> .L%u", jmp->begin, jmp->end, jmp->target->nr);
+				buf += sprintf(buf, ", %lld ... %lld -> .L%u", jmp->begin, jmp->end, jmp->target->nr);
 			else
 				buf += sprintf(buf, ", default -> .L%u", jmp->target->nr);
 		} END_FOR_EACH_PTR(jmp);
@@ -1941,7 +1941,7 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 			default_case = bb_case;
 			continue;
 		} else {
-			int begin, end;
+			long long begin, end;
 
 			begin = end = case_stmt->case_expression->value;
 			if (case_stmt->case_to)
diff --git a/linearize.h b/linearize.h
index 0a70d8129..ce065fe76 100644
--- a/linearize.h
+++ b/linearize.h
@@ -48,7 +48,7 @@ extern struct pseudo void_pseudo;
 
 struct multijmp {
 	struct basic_block *target;
-	int begin, end;
+	long long begin, end;
 };
 
 struct asm_constraint {
diff --git a/validation/switch-long.c b/validation/switch-long.c
new file mode 100644
index 000000000..5bfdb4397
--- /dev/null
+++ b/validation/switch-long.c
@@ -0,0 +1,47 @@
+void def(void);
+void r0(void);
+void r1(void);
+
+void sw_long(long long a)
+{
+	switch (a) {
+	case 0: return r0();
+	case 1LL << 00: return r1();
+	case 1LL << 32: return r1();
+	}
+
+	return def();
+}
+
+/*
+ * check-name: switch-long
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+sw_long:
+.L0:
+	<entry-point>
+	switch.64   %arg1, 0 -> .L2, 1 -> .L3, 4294967296 -> .L4, default -> .L1
+
+.L2:
+	call        r0
+	br          .L5
+
+.L3:
+	call        r1
+	br          .L5
+
+.L4:
+	call        r1
+	br          .L5
+
+.L1:
+	call        def
+	br          .L5
+
+.L5:
+	ret
+
+
+ * check-output-end
+ */
-- 
2.12.0

