Return-Path: <SRS0=D4es=BS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E140C433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A45420716
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nybDJ8XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHHQMB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgHHQMA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:12:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560DC061A27
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:12:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so3403606edk.6
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0YBbxB9z/tlOZGarQXmwSVJk5l+FnIa/DLNKdhToNQ=;
        b=nybDJ8XTY3lmqTerTTS+lRdDhAaJzYKm1DTkzsQSusrRTP3ZJZvhFDnilgDrtFs72O
         aLS2oQ1CvqpLiQI68NMwNeqt8Ajm/llBaqz/V+okCVg4SnFepdWFptcpqmgTlB4DGi7m
         BCTuVyJCRmsOmeke0b7h2qPZjdSpVSC0NghqeY0QXPSj7+AoKS10QSOptoU7wiTu0Wmc
         6vpgSQ6CzL8Y9vrfA1y2UBp7JWePc0kJs8EAUHNx8C9vZMPfjhiDQ9ZUyZNVbBRInDHa
         kxkbkh8N6gQK46kIjSXhAeDW5606QYI7f/4aCfj6x0yEVUmiQOxHsBA492A3D4B6XYCe
         fzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0YBbxB9z/tlOZGarQXmwSVJk5l+FnIa/DLNKdhToNQ=;
        b=CQfrMw+ikroPCptpwK028lXvF7QWbUrFpcsYe+/sGoIi1u1ZRIO1mn3MaucMU8ySly
         Jxm7UZ/Kb9ndO94x2IrT65BkTGpjF09kilOdOi1BfcLAQnCWN6zHG6eNQ9N86vL78YgH
         onJz6iuPpnbhpg7FGZ+OQbaNemY9xCRkK7O6Lq9j/d4qD0vDckC4BF+6y7i2mZ17PZCR
         dn0EvFIhqt6QhKtamDClI7F33HimE6nHwU9Z+pcL5D1xvlaDhv/HXFQDpC+7qIhSsdHE
         k5rwHNVywXhNkwtR14MTCjoRfPbSsy7MxUCsYLy0VF85Waqu/thqboxw48EgoKVwzbdp
         9HlA==
X-Gm-Message-State: AOAM53079/8IuLLk9icuqA5kAGmPsTZQsym39F/N0uGcriwqdiYzQ9cB
        eQ3FD1Jrh/cLcN9fP6C2FTgWio/Y
X-Google-Smtp-Source: ABdhPJxsZnQKN4p5rOo/kCBbPzOrJhu/pG1K+N4NLbpbHoUZtjLILtpLltuwh+5UxoLflPQJ2bNBtw==
X-Received: by 2002:a05:6402:1457:: with SMTP id d23mr13998316edx.149.1596903118840;
        Sat, 08 Aug 2020 09:11:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:11:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] wstring: add helper is_wchar_type()
Date:   Sat,  8 Aug 2020 18:11:41 +0200
Message-Id: <20200808161143.28272-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
References: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Like is_byte_type() but for wide chars.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/symbol.h b/symbol.h
index 8e7a286019c7..0e15f7bf6ba8 100644
--- a/symbol.h
+++ b/symbol.h
@@ -430,6 +430,13 @@ static inline int is_byte_type(struct symbol *type)
 	return type->bit_size == bits_in_char && type->type != SYM_BITFIELD;
 }
 
+static inline int is_wchar_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type == wchar_ctype;
+}
+
 static inline int is_void_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
-- 
2.28.0

