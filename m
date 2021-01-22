Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7463C433DB
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B03023A79
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 16:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbhAVQ1p (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbhAVQ1S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Jan 2021 11:27:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E005C061786
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 08:26:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d22so7263313edy.1
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qMrYhw/JpGefi9QcHRMWf1KFYFi1rHH7cCzTpDn30I=;
        b=d3q/krWld++YczzE0u/Qpk3U6UzXzrcpbrj8qot3skYbt+79XmR00/iX6wlS67budW
         U44MFOFUwSBasgnE83O6dF4i/A7mIwUIQ4Jwqev9vjVFHx7JfbF4JLrS0R3Tj7IIJQCP
         CBqVv4V8F4d+fFRll6d3BZDXlx18ycR4D00QX2iLwpp8N1dskNk1Noq9DCQZN36jWV5N
         Bc2WqS2dej4P0di3TZnYIXaHTXZ+0eCCUeGVIXsrH2JIJIlJ9bTpf1FA+QfZqj33uDwN
         a6m3YnLhXIyqf2PWu/IJQ2b8Uu3Pslrte/KAUuY7qd17bw+vzIIRggy24h8IqxSp67r1
         E1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qMrYhw/JpGefi9QcHRMWf1KFYFi1rHH7cCzTpDn30I=;
        b=HjFYIrmPplXOXAGM+JFOi3SWdpzP+dPzhJLZAxqhCbkk6qUcanQr5wcFk4RL2slIh6
         MF6FtF2dFpH8njR0IoPgH0n0UMn96CZeZoqN3Ec+l3/gVdlhVrD5YrrHZYQvgiP3ojgv
         H1bsPUTb0zQJognPRWCT+iosfhB5soj3F2C810YnlqSrJSqhK1fh3H/gWFR0sOAKUEds
         1259nvJ9kdLP1XSQ+q1epCDaKdBzGS+1GrNK4C9nFP2/07sfaKpIOtaM15iN+pm673pt
         jqpMFQ5a0wPor8CiBIwup8mZwVGyMxpYzMq814Wo3NwUUxqVuHKmeOkun9nF+CkwsTmn
         gqUA==
X-Gm-Message-State: AOAM5309vgg1F48PM4yxnOk+3/tr32Q6bXhaMNfUbZ+Ni2J+g7cQYGan
        E0pXj1KeftyMrlxWhSL8C0bHm0ZTNzM=
X-Google-Smtp-Source: ABdhPJy89QtPmqAQHn0ez/nf6d/fS6+pj408jxXYGIl9P/RYDNmtZQlIPQ+opoYp56adz0vMkSTe+A==
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr3634732edo.203.1611332793161;
        Fri, 22 Jan 2021 08:26:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:acac:599f:da7a:3dd7])
        by smtp.gmail.com with ESMTPSA id m22sm5717963edp.81.2021.01.22.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 08:26:31 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] handle qualified anonymous structures
Date:   Fri, 22 Jan 2021 17:26:25 +0100
Message-Id: <20210122162625.73007-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
References: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
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

An easy solution is to handle this inside find_identifier(), where
access to are recursively searched inside sub-structures. It's
very easy but it feels wrong to do semantics inside this function.
Worse, it's only working for fields that are effectively accessed,
doing a type evaluation on the anonymous struct (or its parent)
would not by itself handle this.

So, the solution chosen here is to handle this during type examination,
more precisely, inside examine_struct_union_type(), where things are
a bit more complicated (it can't be done when examining the members
themselves because only the parent SYM_STRUCT is accessible and the
qualifiers are in the SYM_NODE, so it needs to be done when examining
the anonymous struct itself) but can be done for all members.

Note: It would seems to logical to also handle at least all qualifier-like
      attributes but GCC seems to only bother with the true qualifiers
      and ignore things like attributes and  alignment specifiers.

Link: lore.kernel.org/r/CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com
Link: lore.kernel.org/r/CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/symbol.c b/symbol.c
index aa02c8c5ad80..0030afb5f3f5 100644
--- a/symbol.c
+++ b/symbol.c
@@ -175,6 +175,30 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	// warning (sym->pos, "regular: offset=%d", sym->offset);
 }
 
+///
+// propagate properties of anonymous structs or unions into their members.
+//
+// :note: GCC seems to only propagate the qualifiers.
+// :note: clang doesn't propagate anything at all.
+static void examine_anonymous_member(struct symbol *sym)
+{
+	struct symbol *parent = sym;
+	struct symbol *sub;
+
+	if (parent->type == SYM_NODE)
+		parent = sym->ctype.base_type;
+	if (parent->type != SYM_STRUCT && parent->type != SYM_UNION)
+		return;
+
+	FOR_EACH_PTR(parent->symbol_list, sub) {
+		sub->ctype.modifiers |= sym->ctype.modifiers & MOD_QUALIFIER;
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
@@ -196,6 +220,8 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 		if (info.flex_array)
 			sparse_error(info.flex_array->pos, "flexible array member '%s' is not last", show_ident(info.flex_array->ident));
 		examine_symbol_type(member);
+		if (!member->ident)
+			examine_anonymous_member(member);
 
 		if (member->ctype.alignment > info.max_align && !sym->packed) {
 			// Unnamed bitfields do not affect alignment.
-- 
2.30.0

