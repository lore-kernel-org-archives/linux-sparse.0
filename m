Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2400C2D0A3
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 01:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596962078B
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 01:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ7P6KEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgKGBdA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 20:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKGBc7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 20:32:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF31C0613CF
        for <linux-sparse@vger.kernel.org>; Fri,  6 Nov 2020 17:32:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id cw8so4438527ejb.8
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 17:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6hzK4DcbxBd5fShpVH4xARbobl53Vz42ZcMKQiWtCZU=;
        b=YQ7P6KEc6HUTj+q8amDV+Epw90PjttCwL+XDFt9JYOASBjurP8TJzgj3R5EovVnMMY
         T3FhWLldT9SOpmKHqDfE5xkCdEhbBXcHFZVcIr16FvBabL1ai9rzHVG2sNl62QZlijsF
         pZRNpdIE/c3A0c5meMZIpNl6GZPnPE7LooumdJ9kyGD6sTZf/yjh4bmf3QN/1TqQ/gEy
         a9JpC+q7eV6updqIvrcBI7+cgmBsPB3oiL9+gHImhhivh46X2xvzZcnR4MZMuPxKFl0C
         Yhzi0zqAbzZISyta4etCx3XVlQKp0iv/mFyTEHjm4As+4rD2v7rCa/NYkGtcdZuTkBMJ
         5B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hzK4DcbxBd5fShpVH4xARbobl53Vz42ZcMKQiWtCZU=;
        b=CTobBZ4/AwGlq+hR35+fUihsqS8CKrMQ5StDA+rcilH6PPMrHDIp72nT4lpGL1C9R5
         Ue9rmshXyZOrY5VZPpUsI9x4ZzhQCe9vErlo5lVx+HieIvMcaGxaJYLqlp2Th4XPqGip
         ToXeJWulaGDVYFjq7vcty+Hxyp2yfRVcJDhMHG68hN+6ZcTPsYyc8Wy3csqzhB2yYlji
         z/Awx4tG8VKdQZj3pUD1gX6l9FSl0aOFpDwILtfbInisCx2HDVEBcxHQzUSs+dBqNYF9
         sPmZk3jvKUVoG/LGz14roYTElXwOzw86flEmdcGwmx5yrye+Z11jFlCXPsLDAQP26hU7
         RGNw==
X-Gm-Message-State: AOAM533vw+/9mXc7JeT9hOHdKuv/wQ2IcevdCLPwveDogNZLYomcO1TV
        XINSYYHqdoM/yJDjj4cJy64=
X-Google-Smtp-Source: ABdhPJysQ1lr2eP+KJ8Y3vFmZce/fOcV+2b+a860fHwMMZUg8NQuTywE+pC/wp5tExY8lPhmZ8Entw==
X-Received: by 2002:a17:906:3a49:: with SMTP id a9mr4932646ejf.95.1604712778064;
        Fri, 06 Nov 2020 17:32:58 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:6d45:89a4:a758:92e])
        by smtp.gmail.com with ESMTPSA id bx12sm2177478ejc.71.2020.11.06.17.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 17:32:57 -0800 (PST)
Date:   Sat, 7 Nov 2020 02:32:55 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201107013255.xpsfeamyco7ggnru@ltop.local>
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
 <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local>
 <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
 <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local>
 <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Nov 06, 2020 at 02:46:55PM -0800, Linus Torvalds wrote:
> On Fri, Nov 6, 2020 at 2:19 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Fri, Nov 06, 2020 at 11:44:00AM -0800, Linus Torvalds wrote:
> > > On Fri, Nov 6, 2020 at 11:05 AM Song Liu <songliubraving@fb.com> wrote:
> > >  (a) the conditional following for the return value:
> > >
> > >         select.32   %r4 <- %arg1, $0xffffffff, $0
> > >         select.32   %r6 <- %r4, $0xffffffff, $0
> > >
> > > Note how it doesn't trigger CSE, because it's not the same instruction
> > > (%arg1 vs %r4), but sparse *could* see that a select that depends on a
> > > previous select that has constant arguments can be simplified to be
> > > conditional on the original select value instead, so it *could* be
> > > CSE'd into one single thing.
> > >
> > > So the second "select" could be optimized away by realizing that it
> > > really gets the same value as the first one. That *should* be trivial
> > > to do in sparse by just having a simple pattern for select
> > > simplification.
> > >
> > > And once that optimization is in place, the second optimization would be
> >
> > I think I may even have already this in an half-polished form.
> 
> Ugh. I tried to see what I can do, and it does simplify, but not the
> way I expected.
> 
> The attached patch looks superficially sane (but probably is broken),
> and results in one less "select" statement:
> 
> 
>     .L0:
>         <entry-point>
>         cbr         %arg1, .L5, .L4
> 
>     .L4:
>         call        spin_lock
>         br          .L5
> 
>     .L5:
>         # call      %r4 <- errno, %r1
>         select.32   %r6 <- %arg1, $0xffffffff, $0
>         cbr         %arg1, .L6, .L2
> 
>     .L2:
>         call        spin_unlock
>         br          .L6
> 
>     .L6:
>         ret.32      %r6
> 
> but note how it removed not the select statement I expected, so you
> don't actually end up with a branch to a branch anyway.
> 
> Oh well. It's close. That "select" could be anywhere, so the branch
> following could know that.

Yes, the core of the problem is to move things up.
Here is a patch that kinda do this, a bit too much even but the idea
is there. With is it gives the following:
	cmp:
	.L0:
		<entry-point>
		select.32   %r4 <- %arg1, $0xffffffff, $0
		select.32   %r6 <- %r4, $0xffffffff, $0
		cbr         %arg1, .L6, .L4
	
	.L4:
		call        spin_lock
		# call      %r4 <- errno, %r1
		call        spin_unlock
		br          .L6
	
	.L6:
		ret.32      %r6


The patch move *all* selects the highest possible using the dominance
tree. It complements the select simplification. The only part really
interesting is the very last one, the remaining is just infrastructure.

So, I think that the next questions are:
* which selects should be moved up?
* up to where should them be moved?

I'll think a bit all this this WE.

-- Luc


From 7c0d5a759756989919eb2799e7e50d36941d47b3 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 7 Nov 2020 02:23:21 +0100
Subject: [PATCH] EXP: move up all selects at most as possible

---
 linearize.c | 21 +++++++++++++++++++++
 linearize.h |  1 +
 simplify.c  | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/linearize.c b/linearize.c
index c1e3455adb67..005d90b3fb45 100644
--- a/linearize.c
+++ b/linearize.c
@@ -737,6 +737,27 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	add_instruction(&bb->insns, br);
 }
 
+void copy_select(struct basic_block *bb, struct instruction *insn)
+{
+	struct instruction *br;
+	pseudo_t target;
+	struct instruction *select;
+
+	/* Remove the 'br' */
+	br = delete_last_instruction(&bb->insns);
+
+	select = alloc_typed_instruction(OP_SEL, insn->type);
+	select->bb = bb;
+
+	use_pseudo(select, insn->src1, &select->src1);
+	use_pseudo(select, insn->src2, &select->src2);
+	use_pseudo(select, insn->src3, &select->src3);
+	select->target = insn->target;
+
+	add_instruction(&bb->insns, select);
+	add_instruction(&bb->insns, br);
+}
+
 static inline int bb_empty(struct basic_block *bb)
 {
 	return !bb->insns;
diff --git a/linearize.h b/linearize.h
index 77ae7c9ac976..cc38fe07c974 100644
--- a/linearize.h
+++ b/linearize.h
@@ -311,6 +311,7 @@ struct entrypoint {
 };
 
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
+extern void copy_select(struct basic_block *bb, struct instruction *br);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
 struct instruction *alloc_phisrc(pseudo_t pseudo, struct symbol *type);
diff --git a/simplify.c b/simplify.c
index f2aaa52de84b..633ebc6fad2c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1745,8 +1745,24 @@ static int simplify_cast(struct instruction *insn)
 	return 0;
 }
 
+#include "flowgraph.h"
+static int is_defined_at(pseudo_t src, struct basic_block *bb)
+{
+	if (src->type != PSEUDO_REG)
+		return 1;
+	return domtree_dominates(bb, src->def->bb);
+}
+
+static int move_select_to(struct instruction *insn, struct basic_block *bb)
+{
+	copy_select(bb, insn);
+	kill_instruction(insn);
+	return REPEAT_CSE;
+}
+
 static int simplify_select(struct instruction *insn)
 {
+	struct basic_block *bb;
 	pseudo_t cond, src1, src2;
 
 	cond = insn->src1;
@@ -1782,6 +1798,24 @@ static int simplify_select(struct instruction *insn)
 		kill_use(&insn->src3);
 		return replace_with_value(insn, 0);
 	}
+
+	// Try to move this select 'up'.
+	bb = insn->bb;
+	while (bb->idom) {
+		bb = bb->idom;
+		if (bb == insn->bb)
+			goto out;
+		if (!is_defined_at(cond, bb))
+			goto out;
+		if (!is_defined_at(src1, bb))
+			goto out;
+		if (!is_defined_at(src2, bb))
+			goto out;
+	}
+	if (bb != insn->bb)
+		return move_select_to(insn, bb);
+
+out:
 	return 0;
 }
 
-- 
2.29.2

