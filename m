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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E333C433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA9C206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDoU+IlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHIORj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIORi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 10:17:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6082C061786
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 07:17:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so6851012ejr.5
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z07cW8utdJEcPvKuXVNT/s9ZRb1SDVVIxJFl5jIO414=;
        b=sDoU+IlGsrM6li745dBjrcwr1RGW5yeBgt93tGxMw/UuGG3rznNmiYFxPwQqWC9xTV
         cyJgEO+sbzKOC1w0xUJTm8Ew5F8u4htdIj7o1KN9a+5wlSxjtO8dc73PRP1rsgjlFtNY
         tVHdmkLnt3a9aAEBu+9Do6sEvb982MOKkl0OtV5twG/pgIZIv7URZ8tHu8UNPSusOY0Q
         8MIcPmYUa8KGZatIzp+VYcBtwYwazBycyUwTKrLM9rZ0Q2rmf7oW4ga6eZqsXp5d/zvf
         a72h+/HgcogN98rU7WVpK6V6t2E85Tzn3ZyfQfl/npZAZ/OPo9KK+SaV61hPXcTl1MOC
         Kkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z07cW8utdJEcPvKuXVNT/s9ZRb1SDVVIxJFl5jIO414=;
        b=Y8iFUR6lixax9Atbd84JP0nQ3b1jKeJDl4Z1YdOgdQsSQFB4JlLo0fRROCYB74EITM
         3l0pKC4PEVKNJnYPQcpDDdmzaZkc9GmTfKIwHmWtahSFTrx6OiC6U0vTMrdCyomi3SX5
         7sFDI9DMiJ2AhRvukHo/G0+0LvLxC/V5dlJZr0jdAW41KEPVg8fntm81d67WML+3R9zs
         KBjBZZ/7wNztGoXYcL+nd0A5PMkYM7S9+bt8AfZaPUKiEQTbojfasrsFeipqNeW4kDYz
         MvxqEbFEV3O+mcJ6Lit3py1qUc0NeASs+455LS8ZQ5C4hPrZ3sqU0HeJRm2AlABzcRQg
         pjOg==
X-Gm-Message-State: AOAM532c2AlHYqQ6f+PZrVB5dpcO7fA1Qn67P9aar0sMhpeCVJP/xCUV
        oZqx08vSKCpRCAYWvDewiT/2QBds
X-Google-Smtp-Source: ABdhPJxoRJ+VBVM9zblH4M9LJyMRm1DQCFgYc8fS2VMKrAQmoY1m3dlxqeg+guWvJSEY10Nhm87/Rw==
X-Received: by 2002:a17:906:f0cc:: with SMTP id dk12mr17034748ejb.97.1596982656111;
        Sun, 09 Aug 2020 07:17:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:788a:816d:ff27:8087])
        by smtp.gmail.com with ESMTPSA id p1sm9917956edu.11.2020.08.09.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:17:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] doc: replace nocast-vs-bitwise document with its lore link
Date:   Sun,  9 Aug 2020 16:17:27 +0200
Message-Id: <20200809141731.32433-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
References: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The nocast-vs-bitwise document was copied here to be sure
to remain accessible but isn't really useful here now because:
1) the original document have also been archived to lore.kernel.org
2) nocast & bitwise have now been documented
3) 2) contains a link to 1)

So, remove this redundant document.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst            |  1 -
 Documentation/nocast-vs-bitwise.md | 43 ------------------------------
 2 files changed, 44 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9c76419ba5dd..cbe0521b7091 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -69,7 +69,6 @@ User documentation
    :maxdepth: 1
 
    annotations
-   nocast-vs-bitwise
 
 Developer documentation
 -----------------------
diff --git a/Documentation/nocast-vs-bitwise.md b/Documentation/nocast-vs-bitwise.md
deleted file mode 100644
index 9ba5a789fc26..000000000000
--- a/Documentation/nocast-vs-bitwise.md
+++ /dev/null
@@ -1,43 +0,0 @@
-__nocast vs __bitwise
-=====================
-
-`__nocast` warns about explicit or implicit casting to different types.
-HOWEVER, it doesn't consider two 32-bit integers to be different
-types, so a `__nocast int` type may be returned as a regular `int`
-type and then the `__nocast` is lost.
-
-So `__nocast` on integer types is usually not that powerful. It just
-gets lost too easily. It's more useful for things like pointers. It
-also doesn't warn about the mixing: you can add integers to `__nocast`
-integer types, and it's not really considered anything wrong.
-
-`__bitwise` ends up being a *stronger integer separation*. That one
-doesn't allow you to mix with non-bitwise integers, so now it's much
-harder to lose the type by mistake.
-
-So the basic rule is:
-
-- `__nocast` on its own tends to be more useful for *big* integers
-  that still need to act like integers, but you want to make it much
-  less likely that they get truncated by mistake. So a 64-bit integer
-  that you don't want to mistakenly/silently be returned as `int`, for
-  example. But they mix well with random integer types, so you can add
-  to them etc without using anything special. However, that mixing also
-  means that the `__nocast` really gets lost fairly easily.
-
-- `__bitwise` is for *unique types* that cannot be mixed with other
-  types, and that you'd never want to just use as a random integer (the
-  integer `0` is special, though, and gets silently accepted - it's
-  kind of like `NULL` for pointers). So `gfp_t` or the `safe endianness`
-  types would be `__bitwise`: you can only operate on them by doing
-  specific operations that know about *that* particular type.
-
-Generally, you want `__bitwise` if you are looking for type safety.
-`__nocast` really is pretty weak.
-
-Reference:
-----------
-
-* Linus' e-mail about `__nocast` vs `__bitwise`:
-
-  <https://marc.info/?l=linux-mm&m=133245421127324&w=2>
-- 
2.28.0

