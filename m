From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/29] add undef_pseudo()
Date: Wed, 16 Aug 2017 17:34:38 +0200
Message-ID: <20170816153455.97693-13-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34014 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPPfb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id x43so3697579wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:30 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This helper simply create a pseudo of type PSEUDO_UNDEF.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 7 +++++++
 linearize.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/linearize.c b/linearize.c
index 9ec65079a..3d14892cd 100644
--- a/linearize.c
+++ b/linearize.c
@@ -823,6 +823,13 @@ static pseudo_t argument_pseudo(struct entrypoint *ep, int nr)
 	return pseudo;
 }
 
+pseudo_t undef_pseudo(void)
+{
+	pseudo_t pseudo = __alloc_pseudo(0);
+	pseudo->type = PSEUDO_UNDEF;
+	return pseudo;
+}
+
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type)
 {
 	struct instruction *insn;
diff --git a/linearize.h b/linearize.h
index 54fcf2a46..060d5f327 100644
--- a/linearize.h
+++ b/linearize.h
@@ -335,6 +335,7 @@ extern void insert_branch(struct basic_block *bb, struct instruction *br, struct
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type);
 pseudo_t alloc_pseudo(struct instruction *def);
 pseudo_t value_pseudo(long long val);
+pseudo_t undef_pseudo(void);
 
 struct entrypoint *linearize_symbol(struct symbol *sym);
 int unssa(struct entrypoint *ep);
-- 
2.14.0

