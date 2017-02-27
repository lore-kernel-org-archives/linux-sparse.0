From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] fix size of loaded bitfields
Date: Mon, 27 Feb 2017 10:27:49 +0100
Message-ID: <20170227092749.30083-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=n3WhBF4v1u-BRJMnqWmqY5xrtF=6yrPiFV5y+8GQD5A@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35841 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdB0JzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 04:55:18 -0500
In-Reply-To: <CANeU7Q=n3WhBF4v1u-BRJMnqWmqY5xrtF=6yrPiFV5y+8GQD5A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
Changes since v1:
- Fix the test case that was still at the and-mask version instead
  of the cast for doing the truncation.
- Slightly change the bitfield's width in the test case for easier
  parsing of the result.


 linearize.c                |  4 +++-
 validation/bitfield-size.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 validation/bitfield-size.c

diff --git a/linearize.c b/linearize.c
index 99203d915..c77555bd6 100644
--- a/linearize.c
+++ b/linearize.c
@@ -32,6 +32,7 @@ static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym);
 struct access_data;
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *);
 static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
+static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *from, struct symbol *to);
 
 struct pseudo void_pseudo = {};
 
@@ -999,7 +1000,8 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
-		
+	if (ad->bit_size != type_size(ad->source_type))
+		new = cast_pseudo(ep, new, ad->source_type, ad->result_type);
 	return new;
 }
 
diff --git a/validation/bitfield-size.c b/validation/bitfield-size.c
new file mode 100644
index 000000000..ce78ecf21
--- /dev/null
+++ b/validation/bitfield-size.c
@@ -0,0 +1,41 @@
+struct bfu {
+	unsigned int a:4;
+	unsigned int  :2;
+	unsigned int b:4;
+};
+unsigned int get__bfu_a(struct bfu bf) { return bf.a; }
+unsigned int get__bfu_b(struct bfu bf) { return bf.b; }
+unsigned int get_pbfu_a(struct bfu *bf) { return bf->a; }
+unsigned int get_pbfu_b(struct bfu *bf) { return bf->b; }
+
+
+struct bfs {
+	signed int a:4;
+	signed int  :2;
+	signed int b:4;
+};
+signed int get__bfs_a(struct bfs bf) { return bf.a; }
+signed int get__bfs_b(struct bfs bf) { return bf.b; }
+signed int get_pbfs_a(struct bfs *bf) { return bf->a; }
+signed int get_pbfs_b(struct bfs *bf) { return bf->b; }
+
+
+struct bfi {
+	int a:4;
+	int  :2;
+	int b:4;
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
+ * check-output-pattern-24-times: cast\\.
+ * check-output-pattern-12-times: cast\\.4
+ * check-output-pattern-6-times: lsr\\..*\\$6
+ */
-- 
2.11.1

