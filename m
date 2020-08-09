Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB4C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5BB207DA
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXs5FIpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHIUxk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHIUxj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B8C061786
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so4954498edv.13
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ow0cd4Ts9W/w9vnedCVwmDPzR0E8rZSwgRou1wCSTWI=;
        b=IXs5FIpQpB/wO7Nmeot8b4o4EVY/9GXo2YdVge5xl/h+tw1ZEsymbgC+/1wOn6C8mv
         E/9Z3SWKEj2NjsxJ7IkVn6F/vEv0ckGrGEtIMISlwjVCtPsrJBchSPIHgRsXcRrPpYpn
         xNmPLlcqzOBp3/wT+uJi8SgfTArY0H4vaK5lkjk+cHi4YRDGC4Uf9IcclHtxMPw3ewSL
         ZvcARr23WxutdLGcdHuw3j7BoYBXXgQ31ltOCGONReL1rCk3KK34FrRjNCEmNyCVWs0/
         HgcVE2cKHf6CCP7yXuzO3fxKqJgAmZ8HE89iewXQzy1xhSj1nJfMb8r2j/4DfOKQ3YPf
         i6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ow0cd4Ts9W/w9vnedCVwmDPzR0E8rZSwgRou1wCSTWI=;
        b=Ck80xiI0VZEyaHWPD70tP4gx+CCegFHlxNrESZaxn8q1frr8zgraL/r9AI3sTrY6vp
         AQTga7kK5Xdt3dv6BwWHl+JgzuzZxgWNIJJBeJbfZweTBJMugXS/0npxO7J5G9WX69Ap
         JaeBd+RcmQxgLi183G6lLDoVV753tCQUIp9cDVbdmNnvHVd8PrvvZr7FbDhBjDA7EmjQ
         hXlR2OIkmqgr/qNBqqpzFb1MhMlWkOCmT2yfu8Eh70uu0+7PRZdZy019CLoBGWDqqhQt
         T/i7H8oWi3kDsFoMUq+hFuZChTzIuYibLmOyKS30eBFGqAlCjdzWVHriA2r1uIl17j5X
         z+pg==
X-Gm-Message-State: AOAM530E57XtzGEThPDDMarXkwhDF9yDA+wC97EjpEmy9+Anj1fr7psY
        5eG9mx2dgRd1bBPtq2GqyJZJjazE
X-Google-Smtp-Source: ABdhPJx81+vd7eEuH4Ro2B/n1U+oXlUOCHnIj85WzHvkEco55XJMLDZ/TOYtanKIsJGH8iKC6kkFSQ==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr5677282edb.6.1597006418017;
        Sun, 09 Aug 2020 13:53:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/10] attribute: directly use attribute_specifier() to handle attributes
Date:   Sun,  9 Aug 2020 22:53:24 +0200
Message-Id: <20200809205329.42811-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

handle_attributes() used to also handle asm names and so used
the declarator method associated to the taken. But now, asm names
are handled in a separated function.

So, directly use attribute_specifier() to handle the attributes
instead of using it via the declarator method.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index ec675f20ef01..14b1746d38c5 100644
--- a/parse.c
+++ b/parse.c
@@ -1816,7 +1816,7 @@ static struct token *handle_attributes(struct token *token, struct decl_state *c
 			break;
 		if (!(keyword->op->type & KW_ATTRIBUTE))
 			break;
-		token = keyword->op->declarator(token->next, ctx);
+		token = attribute_specifier(token->next, ctx);
 	}
 	return token;
 }
-- 
2.28.0

