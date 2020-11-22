Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BF2C5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 22:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA4620758
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 22:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNGk4KpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKVW0n (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKVW0m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 17:26:42 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99EC0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 14:26:42 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so15635032wmi.0
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 14:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l5Hnv+Sx3NetcWOf/olWVXpm+WjIKV4MRsx3l4Z/N38=;
        b=SNGk4KpGJEg+drNdyfZsMUi2vf6h+DPWjyG3/hFQU/RLl3fKP428L9EMPxY345v/ny
         4yPuP1sSp0LAp0I6hxElGYwWsaA8hKLUqLdohgH+4GdAj79G4p+I0YSV8UFYEltHt4Xu
         mH9UJ8KSurPKMVh1LQQYW0kugIIQroxPlinkU3LnhaPOMaH7mkdYDO/RFpVIuoynTNEK
         sewdV838OksIRFE77sWu/bX6mPkAJ0hwiqTMwlhsHcrX3kyXsfpWSBcwYtf8ZcIrXYa6
         uRlPWWoFYa/uZGZs4ch8F+Kevsp7Usc1Xxai1ybJlFSi0wQKgUE/9DEcAOXMHUUWBkT/
         HVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l5Hnv+Sx3NetcWOf/olWVXpm+WjIKV4MRsx3l4Z/N38=;
        b=nslLhY3UMucnq62LiODFlWj0AH883Qv0LpHUgje9dA0uzp0IMF4CiP7yfFDUwgQB+k
         D8/xv4I1+WFWw/Ovrd2annvGjs6FmMTsAeV0WCygrBGKYUBWWRJHuIygabl2GrEuapr0
         4wc9Ve/b29R8+Lmrgk1Xm6dBAB34enzbDCGFhiRyFTCxNaBxDdKT0y8aejyrPwwhnHJf
         acnT4I+QhrcdWVg4HKMIqgNFi+F+K7OT9Wt1PJM0juct658ellBezpe4NsRgNbyubcpf
         cSuGDbNHACQ9eOdRz9cBoCxuWioLYuTC8vG2tw7yzO9GZuu09yiEBKqTTxqstdydxbEF
         IlSw==
X-Gm-Message-State: AOAM5329EA0drfTQ2tdFtTG7LTU+KWNnkYUgiepI1DanY4RkpPlxMXbi
        XXL1EU/obCtbJsUnFxQuAKpbhbArqLQ=
X-Google-Smtp-Source: ABdhPJy4YfgoMUDLhijpE+GuCqr597X1mN5oEhY4oenz6iXUheL7x6+3oXArKoNfQBDYHMvK5bNaOw==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr15252001wme.42.1606083999367;
        Sun, 22 Nov 2020 14:26:39 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b0d0:6cd2:d2ec:fc3c])
        by smtp.gmail.com with ESMTPSA id i10sm16380368wrs.22.2020.11.22.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 14:26:38 -0800 (PST)
Date:   Sun, 22 Nov 2020 23:26:37 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 1/7] not: add testcases for canonicalization &
 simplification of negations
Message-ID: <20201122222637.sr4dlsalacb3zaqt@ltop.local>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
 <20201122152731.10994-2-luc.vanoostenryck@gmail.com>
 <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
 <20201122195746.uq44lstsy2pissxi@ltop.local>
 <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Nov 22, 2020 at 12:13:46PM -0800, Linus Torvalds wrote:
> On Sun, Nov 22, 2020 at 11:57 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > In the case here with your example, the if-conversion doesn't happen
> > because the phi-sources is not defined in the top block because of
> > the OR:
> 
> Ahh. Yes, it's more obvious with a more realistic test-case that
> actually translates one set of bits to another set of bits (which is
> something we do in the kernel for various reasons - different bit
> "namespaces", for example user interfaces etc):
> 
>    #define BIT1   4
>    #define BIT1x 16
> 
>    #define BIT2   8
>    #define BIT2x 32
> 
>    int translate_bits(int x)
>    {
>         int y = 0;
>         if (x & BIT1)
>                 y |= BIT1x;
>         if (x & BIT2)
>                 y |= BIT2x;
>         return y;
>    }
> 
> and the first one gets nicely translated as
> 
>    and.32      %r2 <- %arg1, $4
>    select.32   %r14(y) <- %r2, $16, $0
> 
> but then the second one doesn't for the reason you mention.

One thing that can be done (but probably excessive) is something
like the patch below: each time a phi-source is 'blocked' by
it's defining instruction, try to move this instruction up.
With this, we get the expected result for your patch:
	translate_bits:
		and.32      %r2 <- %arg1, $4
		select.32   %r14(y) <- %r2, $16, $0
		and.32      %r7 <- %arg1, $8
		or.32       %r10 <- %r14(y), $32
		select.32   %r13(y) <- %r7, %r10, %r14(y)
		ret.32      %r13(y)

It gives very good result in all sort of code but sadly it
doesn't improve the context imbalance warnings, it even
make them (very) slightly worse.


From be38aca2a4ca3fc0911da9187e2ea58a379824cc Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sun, 22 Nov 2020 22:49:13 +0100
Subject: [PATCH] move up instructions blocking if-conversion

---
 linearize.h |  6 +++++
 simplify.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/linearize.h b/linearize.h
index 31c754e200c2..dcd4359eb2a6 100644
--- a/linearize.h
+++ b/linearize.h
@@ -300,6 +300,12 @@ static inline void replace_bb_in_list(struct basic_block_list **list,
 	replace_ptr_list_entry((struct ptr_list **)list, old, new, count);
 }
 
+static inline void replace_insn(struct instruction *old, struct instruction *new)
+{
+	replace_ptr_list_entry((struct ptr_list **)&old->bb->insns, old, new, 1);
+}
+
+
 struct entrypoint {
 	struct symbol *name;
 	struct symbol_list *syms;
diff --git a/simplify.c b/simplify.c
index a0e23d6de01f..7d5e0d9bcb3a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -46,11 +46,69 @@
 #include "linearize.h"
 #include "flow.h"
 #include "symbol.h"
+#include "flowgraph.h"
 
 ///
 // Utilities
 // ^^^^^^^^^
 
+///
+// check if a pseudo is defined in a BB
+//
+// :note: this could also use the liveness information if available.
+//
+static inline bool is_defined_at(pseudo_t src, struct basic_block *bb)
+{
+	if (src->type != PSEUDO_REG)
+		return true;
+	return domtree_dominates(src->def->bb, bb);
+}
+
+///
+// move an instruction at the end of the given BB
+static void move_insn(struct instruction *insn, struct basic_block *bb)
+{
+	struct instruction *last = delete_last_instruction(&bb->insns);
+	insn->bb = bb;
+	add_instruction(&bb->insns, insn);
+	add_instruction(&bb->insns, last);
+}
+
+///
+// move an instruction into a BB if all its arguments are defined there
+static bool try_to_move_insn(struct instruction *insn, struct basic_block *bb)
+{
+	static struct instruction NOP;	// will later be ignore because !ep
+
+	if (!bb || bb == insn->bb)
+		return 0;
+
+	switch (insn->opcode) {
+	case OP_SEL:
+		if (!is_defined_at(insn->src3, bb))
+			return 0;
+	case OP_ADD: case OP_SUB:
+	case OP_ASR: case OP_LSR: case OP_SHL:
+	case OP_AND: case OP_XOR: case OP_OR:
+	case OP_BINCMP ... OP_BINCMP_END:
+	case OP_FPCMP ... OP_FPCMP_END:
+	case OP_FADD: case OP_FSUB:
+		// basically, all the binops but multiply and divide, just because
+		if (!is_defined_at(insn->src2, bb))
+			return 0;
+	case OP_UNOP ... OP_UNOP_END:
+		if (!is_defined_at(insn->src1, bb))
+			return 0;
+		break;
+	default:
+		return 0;
+	}
+	replace_insn(insn, &NOP);
+	move_insn(insn, bb);
+	repeat_phase |= REPEAT_CSE;
+	return 1;
+}
+
 ///
 // find the trivial parent for a phi-source
 static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseudo)
@@ -58,8 +116,11 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
 	/* Can't go upwards if the pseudo is defined in the bb it came from.. */
 	if (pseudo->type == PSEUDO_REG) {
 		struct instruction *def = pseudo->def;
-		if (def->bb == source)
-			return source;
+		if (def->bb == source) {
+			// unless we can move the defining instruction up
+			if (!try_to_move_insn(def, source->idom))
+				return source;
+		}
 	}
 	if (bb_list_size(source->children) != 1 || bb_list_size(source->parents) != 1)
 		return source;
-- 
2.29.2

