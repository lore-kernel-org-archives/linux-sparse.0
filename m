From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 5/9] change the masking when loading bitfields
Date: Wed,  9 Aug 2017 21:38:02 +0200
Message-ID: <20170809193806.30975-6-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37248 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHITjE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:39:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so602281wmt.4
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:39:04 -0700 (PDT)
In-Reply-To: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

To make some simplification easier, change the way the masking
is done when loading bitfields.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                | 15 +++++++++------
 validation/bitfield-size.c |  6 ++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/linearize.c b/linearize.c
index 7313e72d8..45301f954 100644
--- a/linearize.c
+++ b/linearize.c
@@ -995,14 +995,17 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 {
 	struct symbol *ctype = ad->result_type;
 	pseudo_t new = add_load(ep, ad);
+	unsigned int off = ctype->bit_offset;
+	unsigned int siz = ctype->bit_size;
 
-	if (ctype->bit_offset) {
-		pseudo_t shift = value_pseudo(ctype->bit_offset);
-		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
-		new = newval;
+	if (siz != type_size(ad->source_type)) {
+		pseudo_t mask = value_pseudo(((1ULL << siz) - 1) << off);
+		new = add_binary_op(ep, ad->source_type, OP_AND, new, mask);
+	}
+	if (off) {
+		pseudo_t shift = value_pseudo(off);
+		new = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 	}
-	if (ctype->bit_size != type_size(ad->source_type))
-		new = cast_pseudo(ep, new, ad->source_type, ad->result_type);
 	return new;
 }
 
diff --git a/validation/bitfield-size.c b/validation/bitfield-size.c
index ce78ecf21..c8c94bb15 100644
--- a/validation/bitfield-size.c
+++ b/validation/bitfield-size.c
@@ -35,7 +35,9 @@ unsigned int get_pbfi_b(struct bfi *bf) { return bf->b; }
  * check-command: test-linearize -Wno-decl $file
  * check-output-ignore
  *
- * check-output-pattern-24-times: cast\\.
- * check-output-pattern-12-times: cast\\.4
+ * check-output-excludes: cast\\.4
+ * check-output-pattern-6-times: cast\\.
  * check-output-pattern-6-times: lsr\\..*\\$6
+ * check-output-pattern-6-times: and\\..*\\$15
+ * check-output-pattern-6-times: and\\..*\\$960
  */
-- 
2.14.0

