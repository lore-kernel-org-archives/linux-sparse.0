From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix size of loaded bitfields
Date: Fri, 17 Feb 2017 03:44:45 +0100
Message-ID: <20170217024445.16163-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33690 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbdBQCo5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 21:44:57 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so355290wmv.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 18:44:56 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Loading a bitfield correctly take in account the offset
of the bitfield inside the whole container integer.
But truncating it to the width of the bitfield is not done
or is done very implicitely (because the correct size is not lost).
For example, with the following code:
	struct bfu {
		unsigned int a:3;
	};
	unsigned int get__bfu_a(struct bfu bf) { return bf.a; }

test-linearize gives as output something like:
	get__bfu_a:
		cast.32     %r2 <- (3) %arg1
		ret.32      %r2

We can notice the (3) in the cast instruction but this is misleading
as %arg1 is not 3bit wide.

Fix this by adding the missing truncating cast.
This will then gives something like:
	get__bfu_a:
		cast.3      %r2 <- (32) %arg1
		cast.32     %r3 <- (3) %r2
		ret.32      %r3

Note the truncation could also be done by a and-mask but the cast
is more logical since we're here only changing size and not doing
some arithmetic operations.

Fixes: 1688f039c ("Re-do memory access linearization.")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                |  5 ++++-
 validation/bitfield-size.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 validation/bitfield-size.c

diff --git a/linearize.c b/linearize.c
index 99203d915..0d29b28ae 100644
--- a/linearize.c
+++ b/linearize.c
@@ -32,6 +32,7 @@ static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym);
 struct access_data;
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *);
 static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
+static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *from, struct symbol *to);
 
 struct pseudo void_pseudo = {};
 
@@ -999,7 +1000,9 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
-		
+	if (ad->bit_size != type_size(ad->source_type)) {
+		new = cast_pseudo(ep, new, ad->source_type, ad->result_type);
+	}
 	return new;
 }
 
diff --git a/validation/bitfield-size.c b/validation/bitfield-size.c
new file mode 100644
index 000000000..25ad1514b
--- /dev/null
+++ b/validation/bitfield-size.c
@@ -0,0 +1,41 @@
+struct bfu {
+	unsigned int a:3;
+	unsigned int  :2;
+	unsigned int b:3;
+};
+unsigned int get__bfu_a(struct bfu bf) { return bf.a; }
+unsigned int get__bfu_b(struct bfu bf) { return bf.b; }
+unsigned int get_pbfu_a(struct bfu *bf) { return bf->a; }
+unsigned int get_pbfu_b(struct bfu *bf) { return bf->b; }
+
+
+struct bfs {
+	signed int a:3;
+	signed int  :2;
+	signed int b:3;
+};
+signed int get__bfs_a(struct bfs bf) { return bf.a; }
+signed int get__bfs_b(struct bfs bf) { return bf.b; }
+signed int get_pbfs_a(struct bfs *bf) { return bf->a; }
+signed int get_pbfs_b(struct bfs *bf) { return bf->b; }
+
+
+struct bfi {
+	int a:3;
+	int  :2;
+	int b:3;
+};
+unsigned int get__bfi_a(struct bfi bf) { return bf.a; }
+unsigned int get__bfi_b(struct bfi bf) { return bf.b; }
+unsigned int get_pbfi_a(struct bfi *bf) { return bf->a; }
+unsigned int get_pbfi_b(struct bfi *bf) { return bf->b; }
+
+/*
+ * check-name: bitfield size
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-pattern-12-times: cast\\.
+ * check-output-pattern-12-times: and\\.3[ ]
+ * check-output-pattern-6-times:  lsr\\..*\\$5
+ */
-- 
2.11.0

