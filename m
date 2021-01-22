Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58DC433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 21:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABF023AF8
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 21:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbhAVVYO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbhAVVYJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Jan 2021 16:24:09 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDACC06174A
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 13:23:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gx5so9660876ejb.7
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 13:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ng+UDbYpl22P+1nB4roKmmfd4KXBE6VcTX4pYmzkbIM=;
        b=Yec4cXLvxZgC1rHVEs0OHPRGdCAyZwK+EUr2XS4JcbQG5xF72ojuRrgNkynXkOiids
         jOF6dhYWNXq9SKOAJUOHAbfKg0cuARU0oDIvLwAt5AZyy4d2iMlHPrLAPqvJuPp+7PB2
         li4gZguJFWek+7OI73bbSovqeHRZSni3GqiXT4edZMt3JjZCmLhyh/DAMaKWGheIZv9Q
         BIxGIPT8HOJz5bj3+gd4xmFIKAIPy12TiaBB7KjySWUbYJnTvWLKyqISvss+vc7mqKCk
         ZcBD9ppzyZrmyAuci6TKWPfcH8NybU7bMQ7PLpOZTmH+fav1uWJi8dnkr0+VuEtmzM8a
         6wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ng+UDbYpl22P+1nB4roKmmfd4KXBE6VcTX4pYmzkbIM=;
        b=HrATUZ2bZI6xyuFHzhfRJDJfwvvG9srHyTgFzq+m2fgEiLOTrdsLNPPt8mkpc6raoW
         iOXFTqdyNSEU6ldGNtki2xUCMk2l1WZfhcHPAwSds9Rzz+oFuZ1op0TZQsTZDiV1iIki
         3vRga1U68DeRxLpmlCMG2mmP6RjADLz8iSUhRT+dILXhSfmxYF4QFDw/P9ZpJ9v7Clbx
         JPFkn3ZUy9BpjtIGrq2yZhamuYOaJKRlwvP0fvorTpu5YdYWuFZZL2ueebx/v1JvjAp5
         W1FvVWWVnsHKZK0Im1grmuHo00Stcq/Fw9I1MhbzNd4Gp2Mkx3gfV44agxFQ3AickbLB
         I6ag==
X-Gm-Message-State: AOAM531PYVRtAZn2bLmACSAFefYpkEeLMbh9uVb15mGFSjXvagTpy6VC
        +VgtM330RfmBAFjN+HWrqEOIgvbfMnk=
X-Google-Smtp-Source: ABdhPJxvHfHzdz0lSC7xefaBK4aNOgNPM05esGkllb0zz6AY7I/CfxnNlyNdREnGXlIQN0pRldNqIw==
X-Received: by 2002:a17:906:a669:: with SMTP id en9mr4370493ejb.353.1611350607645;
        Fri, 22 Jan 2021 13:23:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e13f:8447:6e59:7f11])
        by smtp.gmail.com with ESMTPSA id g14sm5230044ejr.105.2021.01.22.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 13:23:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] handle qualified anonymous structures
Date:   Fri, 22 Jan 2021 22:23:23 +0100
Message-Id: <20210122212323.80203-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The kernel is trying to use a unnamed struct to mark a group of
fields as being 'const' and get a warning if one of its member is
assigned. GCC gives indeed a warning but Sparse and clang don't.

So, the type qualifiers of the anonymous struct need to be propagate
to the members.

An easy, one-liner, solution is to handle this inside find_identifier(),
where access to the members are recursively searched inside sub-structures.
It's very easy but it feels wrong to do semantics inside this function.
Worse, it's only working for members that are effectively accessed,
doing a type evaluation on the anonymous struct (or its parent)
would, by itself, not handle this.

So, the solution chosen here is to handle this during type examination,
more precisely, inside examine_struct_union_type(), where things are
a bit more complicated (it can't be done when examining the members
themselves because only the parent SYM_STRUCT is accessible and the
qualifiers are in the SYM_NODE, so it needs to be done when examining
the anonymous struct itself) but can be done for all members.

Note: It would seem logical to also handle at least all qualifier-like
      attributes but GCC seems to only bother with the true qualifiers
      and ignore things like attributes and alignment specifiers.

Link: lore.kernel.org/r/CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com
Link: lore.kernel.org/r/CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com
Thanks-to: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Change since v1:
* factor out the modifiers from the 'sub' loop
* remove the sym-vs-parent thing thanks to the previous point
* check that sub-members are always a SYM_NODE (via an assert, sorry)

 symbol.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/symbol.c b/symbol.c
index aa02c8c5ad80..91352a3a447b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <assert.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -175,6 +176,31 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	// warning (sym->pos, "regular: offset=%d", sym->offset);
 }
 
+///
+// propagate properties of anonymous structs or unions into their members.
+//
+// :note: GCC seems to only propagate the qualifiers.
+// :note: clang doesn't propagate anything at all.
+static void examine_anonymous_member(struct symbol *sym)
+{
+	unsigned long mod = sym->ctype.modifiers & MOD_QUALIFIER;
+	struct symbol *sub;
+
+	if (sym->type == SYM_NODE)
+		sym = sym->ctype.base_type;
+	if (sym->type != SYM_STRUCT && sym->type != SYM_UNION)
+		return;
+
+	FOR_EACH_PTR(sym->symbol_list, sub) {
+		assert(sub->type == SYM_NODE);
+		sub->ctype.modifiers |= mod;
+
+		// if nested, propagate all the way down
+		if (!sub->ident)
+			examine_anonymous_member(sub);
+	} END_FOR_EACH_PTR(sub);
+}
+
 static struct symbol * examine_struct_union_type(struct symbol *sym, int advance)
 {
 	struct struct_union_info info = {
@@ -196,6 +222,8 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 		if (info.flex_array)
 			sparse_error(info.flex_array->pos, "flexible array member '%s' is not last", show_ident(info.flex_array->ident));
 		examine_symbol_type(member);
+		if (!member->ident)
+			examine_anonymous_member(member);
 
 		if (member->ctype.alignment > info.max_align && !sym->packed) {
 			// Unnamed bitfields do not affect alignment.
-- 
2.30.0

