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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895DBC433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBE7206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9ceEM0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIQwx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgHIQwm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7848C061787
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c10so4733062edk.6
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlXyMheDEmz2Qrk2FGNb8ic4a6dGP1AHhzpQwKy+zCk=;
        b=s9ceEM0GA6Ke+Qh0st7zZ0p73ldmn94uH/W2OjtaEWlX6GGs4YOw0dw/0FKwZpsRp9
         V1/FmUj3i5Xf/BqJCAlBINuRRKBpc09nx1ivUnMSWzJ0MWGvkoZ9pI101Jelfsl8rJWm
         K5PuABQIrW+9valRjUoPC+0kZoWaIdxa4JUg42V/8swMk2GeS3fRhDm+elWWKLFZELlv
         wbZ+vH2MkjHxdIZQBVgXPC1/s915CunVVHXy6LV+a5QshkK/EHNhWLL6XTbKKLIWByQ7
         hxF0Z8rZFffnZEh0YSnr4NoPMRxo1gsnw2JlUZ+STGNGZIUjstTbZsupNDCD+ndEEmad
         2BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlXyMheDEmz2Qrk2FGNb8ic4a6dGP1AHhzpQwKy+zCk=;
        b=gwSTu9IMWnAUgywaP2/CDX+GDxRK2/FLrm0aPI+P9PIA5mrbUM96caLXXhs88Zo+dR
         zTeXfZ6GzCKOuW5PnlIg6ZRq1PDLnCeBIRCXDsKLS86OVEWNdgjAR/THlKupMPubJBJg
         rTKpnXIiilx3xpxb5wmBN6H0l71wByep22VlPaAP9lNWWHrmUsPqib0c+zQP62sFi4MD
         Mpd/iD/sxKO2uuTPXOw7NCU6sjaVLnTMIBAwpJw8AridHnNp78CbgOWYpqOBQfc4eWCH
         VhskyRq5yxaDtTfSRGktDzLzMx/iD43TrCLKzY6n6iHxAcLv8mACsyMKeXYqK/LXRdD2
         7+tg==
X-Gm-Message-State: AOAM5316UdZfgSV2NC5NUK9V9RQka0jjAHBKHvVVSdXH1FOPGuDasMjL
        aAFCuDKI6flMjEOuOVC/q8XEeR0Z
X-Google-Smtp-Source: ABdhPJzSyoQvH/f/Dfg6zqC0b/jY/1k3uvj+nqTquDzyiZ+Y8yNiNLDNjHLaioHil2kGcWwYT3X3mQ==
X-Received: by 2002:a05:6402:1a54:: with SMTP id bf20mr17841880edb.217.1596991958512;
        Sun, 09 Aug 2020 09:52:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] show-mod: no extra space when showing modifiers + ident
Date:   Sun,  9 Aug 2020 18:52:24 +0200
Message-Id: <20200809165229.36677-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 show-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/show-parse.c b/show-parse.c
index 17a4de8be64e..0546a7b9f210 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -70,7 +70,7 @@ static void do_debug_symbol(struct symbol *sym, int indent)
 
 	if (!sym)
 		return;
-	fprintf(stderr, "%.*s%s%3d:%lu %s %s (as: %s) %p (%s:%d:%d) %s\n",
+	fprintf(stderr, "%.*s%s%3d:%lu %s%s (as: %s) %p (%s:%d:%d) %s\n",
 		indent, indent_string, typestr[sym->type],
 		sym->bit_size, sym->ctype.alignment,
 		modifier_string(sym->ctype.modifiers), show_ident(sym->ident),
-- 
2.28.0

