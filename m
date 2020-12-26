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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE01C4332B
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F0920809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgLZRxU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgLZRxU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC3C06179A
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a6so5764176wmc.2
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FwEVZF+/371nFbgxzz7i1U9JlsSybepMtcnC5zhALk=;
        b=DFpoMFZJGyKSkXdzS8mMU5EyWU7PwOKjSB7asn9R1PvYzk3+fgkuVG1pOPX+dv8+Tb
         xne1MhSjAQA+HnMMcZQqFUNqS5uWWEtMs4GPXkjewYBfbxfcWFGGkXRTSPZedrmVzwlo
         1nJBFJoRhUNldmYN9dgq76DnTo1mETaJXuVN9dZJPmSvnumAi85BFDyk1/7lqznFSiUf
         cmsZ+vkQi3+3z+u9c/wBnc/xuWwZ1pFy7LnOFOlUN6SN2EPsrbjI29WD8zuUgy4gx94N
         iE8rha+djY9Zz9djKtLxhVgbbk39noNIvkQZ3ZsxbyMmYZX1SCFkjS9GUrLasL8ooU9N
         VlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FwEVZF+/371nFbgxzz7i1U9JlsSybepMtcnC5zhALk=;
        b=cGklDL8OgF86DFkd07CXEoz+9OYzYYWjHdwh0mmMucS27E6WehKJ1z5tLHY1Il+WSX
         PuCaD5tnHkSoXrBEgxvHYghe04FHn5g3515JvbhdlB0mutqDxG/mzwNIUdKrpXeKQES2
         DWbHBzaXd5JkxECMDXTqJ57DrXdLX6gUOjZbvOcBk6w2C95k4RyJJjGoX/bPAyDsbckQ
         WpYkV67gkSthC9vYW7dp/w4IZrgxlcnw6eSaRs4UiDIn8P/R+imzJMt4nwDNcRaLrzZK
         tmfgR0VhB8FNhbLICmIAa+tgAvObqOtSkAZCDyrstZeY//bQRY/O8G2/vA1LWCtnjmpw
         SYmQ==
X-Gm-Message-State: AOAM5330XqlP7q6FpJVnFw19g/Jja5G6EOlLyGggRhTWmvLmJex3TaUY
        2IRIEYGffI0W+wWx83ds0RsECE+4H6w=
X-Google-Smtp-Source: ABdhPJzAnzse3FFBNpprinwl3KyO9vCETF1X12+ZYCeEgmQniOSMUA6VX597cbFYZD8AYp7740OEwQ==
X-Received: by 2002:a1c:87:: with SMTP id 129mr13126035wma.183.1609005125884;
        Sat, 26 Dec 2020 09:52:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:05 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 10/16] struct-attr: prepare to handle attributes at the end of struct definitions (1)
Date:   Sat, 26 Dec 2020 18:51:23 +0100
Message-Id: <20201226175129.9621-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Type attributes for struct can be placed either just after the
keyword 'struct' or after the '}' ending its definition but this
later case is currently ignored.

Prepare the handling of this by factoring the code common to both
cases in a single place.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 11 +++++------
 validation/parsing/enum-attr.c |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/parse.c b/parse.c
index d6343f0e48bf..99d810910dab 100644
--- a/parse.c
+++ b/parse.c
@@ -745,12 +745,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 			if (sym->symbol_list)
 				error_die(token->pos, "redefinition of %s", show_typename (sym));
 			sym->pos = *repos;
-			token = parse(token->next, sym);
-			token = expect(token, '}', "at end of struct-union-enum-specifier");
-
-			// Mark the structure as needing re-examination
-			sym->examined = 0;
-			sym->endpos = token->pos;
+			goto end;
 		}
 		return token;
 	}
@@ -763,10 +758,14 @@ static struct token *struct_union_enum_specifier(enum type type,
 	}
 
 	sym = alloc_symbol(token->pos, type);
+end:
 	set_current_scope(sym);		// used by dissect
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
+
+	// Mark the structure as needing re-examination
+	sym->examined = 0;
 	sym->endpos = token->pos;
 
 	return token;
diff --git a/validation/parsing/enum-attr.c b/validation/parsing/enum-attr.c
index a962d8b417af..8d851a162135 100644
--- a/validation/parsing/enum-attr.c
+++ b/validation/parsing/enum-attr.c
@@ -21,9 +21,9 @@ enum bad {
 parsing/enum-attr.c:10:15: error: typename in expression
 parsing/enum-attr.c:10:15: error: undefined identifier '__attribute__'
 parsing/enum-attr.c:10:15: error: bad constant expression type
-parsing/enum-attr.c:10:22: error: Expected } at end of struct-union-enum-specifier
+parsing/enum-attr.c:10:22: error: Expected } at end of specifier
 parsing/enum-attr.c:10:22: error: got 33
-parsing/enum-attr.c:14:18: error: Expected } at end of struct-union-enum-specifier
+parsing/enum-attr.c:14:18: error: Expected } at end of specifier
 parsing/enum-attr.c:14:18: error: got __attribute__
  * check-error-end
  */
-- 
2.29.2

