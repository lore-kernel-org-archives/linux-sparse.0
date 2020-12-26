Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A31C433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B76D20809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgLZRxW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgLZRxV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC542C06179B
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so5771138wmz.0
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbPRwlT5cGx8c21eE81qDj+4Hc+ScoAnNDKmpU/y/wc=;
        b=DbJ/3xDPVo72vrIK6kN42ID7fpuL1ug9b7ViAUMHQ1fU/5oYglhhh37kleyY7piFEh
         S7qSxCm+M0kewWFo292408b4KBrXtuoLinmzCSk0ZZtQiNeCtXp5csYHiDdn9tUhzkVG
         WXCd7HBCFlYShyUdUVL9rgvw40rXo0k0L6pC0EMEdvau85xPByNkO0OQ2JBaG++1+npm
         np/RS7yvI7/tAWCX+rzsyLV8kJiKDGEfWzglYXI/ocwKBiEM8tyI8UUvLzWdJfxmBk6W
         LeCgjDbMU2Ncgb+Ty0I7VDlKmhJPRjf2ToMuTmcdRBQaVm0R671gXPqyRlP4JnGm2kTa
         HKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbPRwlT5cGx8c21eE81qDj+4Hc+ScoAnNDKmpU/y/wc=;
        b=laYjM8rgkoB8Vumeu9GKYKHxSf7jXnNCILfEsID+ReLn2klyzFF1SGHM8/YTEHIWgs
         OB0VCRH/Tdk6ezLqITPuzjHlEN0DosQeYV5gbMk9wuN1QcJ6ElXmcieKVdfgMVCwB7ca
         eVszWr4ESFueILTNTOfzy3iAfDZQ22asOJ2O5BXbG2I48SIfLGoLtNLQ9PxLV5CnaDQv
         u1SU/UOHbG4VaqM9cw+rPpSymZgLLEfYXBzkoW/U6CAfcoRUf/MM/dQuyf2y0UmEiYZK
         sRKQmzkzdA5W2pSvJtHuOb+EvWiYrVIDN05afUcFUGMBX93Bu5iZJebQy0Z/+l4TFLiu
         8u/g==
X-Gm-Message-State: AOAM532TprnKahqlA4qf49LvvOTl2N/7uVQnEdtV7Q7h/t0+v+3gLE53
        y/iid5GEtuFrAo51rZMari9UN+dA57A=
X-Google-Smtp-Source: ABdhPJyQoSYU0D9HXostMCpZP0VV7d/vhOpeymVelKvs5hsy1gCygz7/uwzEwU/BbYIZwx+p0mrd1Q==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr13162761wmi.161.1609005126797;
        Sat, 26 Dec 2020 09:52:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:06 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 11/16] struct-attr: prepare to handle attributes at the end of struct definitions (2)
Date:   Sat, 26 Dec 2020 18:51:24 +0100
Message-Id: <20201226175129.9621-12-luc.vanoostenryck@gmail.com>
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

Prepare the handling of this by restructuring the code handling
struct specifiers, namely inverting the condition so that the
function can return early to make next patch's job easier.
---
 parse.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/parse.c b/parse.c
index 99d810910dab..a90dcf7f7e4a 100644
--- a/parse.c
+++ b/parse.c
@@ -738,16 +738,16 @@ static struct token *struct_union_enum_specifier(enum type type,
 		ctx->ctype.base_type = sym;
 		repos = &token->pos;
 		token = token->next;
-		if (match_op(token, '{')) {
-			// The following test is actually wrong for empty
-			// structs, but (1) they are not C99, (2) gcc does
-			// the same thing, and (3) it's easier.
-			if (sym->symbol_list)
-				error_die(token->pos, "redefinition of %s", show_typename (sym));
-			sym->pos = *repos;
-			goto end;
-		}
-		return token;
+		if (!match_op(token, '{'))
+			return token;
+
+		// The following test is actually wrong for empty
+		// structs, but (1) they are not C99, (2) gcc does
+		// the same thing, and (3) it's easier.
+		if (sym->symbol_list)
+			error_die(token->pos, "redefinition of %s", show_typename (sym));
+		sym->pos = *repos;
+		goto end;
 	}
 
 	// private struct/union/enum type
-- 
2.29.2

