From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] fix implicit zero initializer.
Date: Fri,  7 Apr 2017 01:00:29 +0200
Message-ID: <20170406230029.11384-5-luc.vanoostenryck@gmail.com>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36666 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753035AbdDFXAl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 19:00:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id o21so10188783wrb.3
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 16:00:40 -0700 (PDT)
In-Reply-To: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The C standard requires that, when initializing an aggregate, all
fieds not explicitly initialized shall be implicity zero-initialized
(more exactly "the same as objects that have static storage duration"
[6.7.9.21]).

Until now sparse didn't did this.
Fix this (when an initializer is present and the object not a scalar)
by first storing zeroes in the whole object before doing the
initialization of each fields explicitly initialized.

Note 1: the code simplify nicely when there is a single field that is
        initialized, much less so when there is several ones.
Note 2: this implicit initialization is not needed if all fields are
        explicitly initialized but is done anyway for the moment.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                             |  11 ++++
 validation/linear/bitfield-init-zero.c  | 102 ++++++++++++++++++++++++++++++++
 validation/linear/struct-init-full.c    |  28 +++++++++
 validation/linear/struct-init-partial.c |  41 +++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 validation/linear/bitfield-init-zero.c
 create mode 100644 validation/linear/struct-init-full.c
 create mode 100644 validation/linear/struct-init-partial.c

diff --git a/linearize.c b/linearize.c
index e9610932b..e4cbc8bd4 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1634,6 +1634,17 @@ static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym)
 
 	sym->initialized = 1;
 	ad.address = symbol_pseudo(ep, sym);
+
+	if (sym->initializer && !is_scalar_type(sym)) {
+		// default zero initialization [6.7.9.21]
+		struct expression *expr = sym->initializer;
+		ad.pos = expr->pos;
+		ad.result_type = sym;
+		ad.source_type = base_type(sym);
+		ad.address = symbol_pseudo(ep, sym);
+		linearize_store_gen(ep, value_pseudo(0), &ad);
+	}
+
 	value = linearize_initializer(ep, sym->initializer, &ad);
 	finish_address_gen(ep, &ad);
 	return value;
diff --git a/validation/linear/bitfield-init-zero.c b/validation/linear/bitfield-init-zero.c
new file mode 100644
index 000000000..39a64345e
--- /dev/null
+++ b/validation/linear/bitfield-init-zero.c
@@ -0,0 +1,102 @@
+struct bfu {
+	unsigned int a:11;
+	unsigned int f:9;
+	unsigned int  :2;
+	unsigned int z:3;
+};
+
+struct bfu bfuu_init(unsigned int a)
+{
+	struct bfu bf = { .f = a, };
+	return bf;
+}
+
+struct bfu bfus_init(int a)
+{
+	struct bfu bf = { .f = a, };
+	return bf;
+}
+
+unsigned int bfu_get0(void)
+{
+	struct bfu bf = { };
+	return bf.f;
+}
+
+
+struct bfs {
+	signed int a:11;
+	signed int f:9;
+	signed int  :2;
+	signed int z:3;
+};
+
+struct bfs bfsu_init(unsigned int a)
+{
+	struct bfs bf = { .f = a, };
+	return bf;
+}
+
+struct bfs bfss_init(int a)
+{
+	struct bfs bf = { .f = a, };
+	return bf;
+}
+
+int bfs_get0(void)
+{
+	struct bfs bf = { };
+	return bf.f;
+}
+
+/*
+ * check-name: bitfield implicit init zero
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+bfuu_init:
+.L0:
+	<entry-point>
+	cast.9      %r2 <- (32) %arg1
+	shl.32      %r4 <- %r2, $11
+	ret.32      %r4
+
+
+bfus_init:
+.L2:
+	<entry-point>
+	scast.9     %r10 <- (32) %arg1
+	shl.32      %r12 <- %r10, $11
+	ret.32      %r12
+
+
+bfu_get0:
+.L4:
+	<entry-point>
+	ret.32      $0
+
+
+bfsu_init:
+.L6:
+	<entry-point>
+	cast.9      %r23 <- (32) %arg1
+	shl.32      %r25 <- %r23, $11
+	ret.32      %r25
+
+
+bfss_init:
+.L8:
+	<entry-point>
+	scast.9     %r31 <- (32) %arg1
+	shl.32      %r33 <- %r31, $11
+	ret.32      %r33
+
+
+bfs_get0:
+.L10:
+	<entry-point>
+	ret.32      $0
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/struct-init-full.c b/validation/linear/struct-init-full.c
new file mode 100644
index 000000000..f1b03db71
--- /dev/null
+++ b/validation/linear/struct-init-full.c
@@ -0,0 +1,28 @@
+struct s {
+	int a, b, c;
+};
+
+struct s s_init_all(int a)
+{
+	struct s s = { .a = a, .b = 42, .c = 123, };
+	return s;
+}
+
+/*
+ * check-name: struct implicit init zero not needed
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+s_init_all:
+.L4:
+	<entry-point>
+	store.32    %arg1 -> 0[s]
+	store.32    $42 -> 4[s]
+	store.32    $123 -> 8[s]
+	load.96     %r8 <- 0[s]
+	ret.96      %r8
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/struct-init-partial.c b/validation/linear/struct-init-partial.c
new file mode 100644
index 000000000..1f5078bfa
--- /dev/null
+++ b/validation/linear/struct-init-partial.c
@@ -0,0 +1,41 @@
+struct s {
+	int a, b, c;
+};
+
+struct s s_init_first(int a)
+{
+	struct s s = { .a = a, };
+	return s;
+}
+
+struct s s_init_third(int a)
+{
+	struct s s = { .c = a, };
+	return s;
+}
+
+/*
+ * check-name: struct implicit init zero needed
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+s_init_first:
+.L0:
+	<entry-point>
+	store.96    $0 -> 0[s]
+	store.32    %arg1 -> 0[s]
+	load.96     %r2 <- 0[s]
+	ret.96      %r2
+
+
+s_init_third:
+.L2:
+	<entry-point>
+	store.96    $0 -> 0[s]
+	store.32    %arg1 -> 8[s]
+	load.96     %r5 <- 0[s]
+	ret.96      %r5
+
+
+ * check-output-end
+ */
-- 
2.12.0

