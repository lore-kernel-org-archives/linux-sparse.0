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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6798C433E1
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9645820759
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG3gUe6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHHQMC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQMB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:12:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B2C061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:12:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so5142383ejx.12
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEbn7nCT3xSMtCxm5v/MUr79gulE23OQ0NZ7sa1vfi4=;
        b=oG3gUe6lf54D5Cbk19GjA4nYua/zJ8Nz1U7ExRr6j+EnpnMtfvUljg4QuBVXyelS1n
         p+rxRHsYyqJqz6nAs+Dc49M0/twUmlqT/iJmtFh+3Kv8mtM+60f3C8JfkC4Er1DkuX+w
         eaS0LVvy6Q5qm0qpK2qybRsg4tmLaNmplzlq7vws5KCMkV3euRQ+dyZYGkeKOhUkmKNZ
         AvBCmtMERDTccHAhbphnqRCmxsQzAVp76c9SvXJAw6jXE2Cuo8ySfv8K/dzmuwJhkjvs
         fuo2nLZ2hr51+PWMh+VutJLtvBSo4WSY7uADPGqfHpewh0qdcp9WwfUnBwEFex1vGwNI
         2bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEbn7nCT3xSMtCxm5v/MUr79gulE23OQ0NZ7sa1vfi4=;
        b=UBgWpnggFqF1KkQs/r6X3N7IlOu/mL7rIohNgF4ym/W7b3qd8m2cif8zXwAlwVtu4J
         fvNVC3buR8TP7VHAtK9bAakOphpy9d/SM3UkyuPOPvCyXQufeao42PkKsKEtJCayemKQ
         l2XDdItWLMcbCkiK8MRpD3uDn4qp6E72zCcF0Mc8AxdyRJDt9JaLWMc8Bb6mscGmRH/b
         i1N9rmAAeMxZhvlnRf0olI7EmdB0KiY09zM3m5FPt9y3xWnCHDX86gnpM0HvcUzftVks
         pyiitJ0Z4UyPhZkJupnwYw3i9cCQbuuVgnNeLTF2iwGE6vEAlfrOfR2mrzgRIxvpAlQv
         UP2g==
X-Gm-Message-State: AOAM532vtM4XJBMcu3x+ShB7/Y3S59uHgcLbnGFdIYqPVp2MdqARJDIA
        +cPzZrVqRMpBJb3rJy3GAVsXI53e
X-Google-Smtp-Source: ABdhPJwsdevOIgyeDJav55a8o0alSsTr9OINWJuI5XQjQ1GTor5cvoXZ3Y77B1R1MIXAISOW8EAVow==
X-Received: by 2002:a17:906:e0ce:: with SMTP id gl14mr15250273ejb.393.1596903119806;
        Sat, 08 Aug 2020 09:11:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:11:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] wstring: extend is_string_type() to also detect wide strings
Date:   Sat,  8 Aug 2020 18:11:42 +0200
Message-Id: <20200808161143.28272-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
References: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When evaluating initializers, it must be known if it is for a string
or not. But sparse doesn't known about wide strings.

Fix this by modifying is_string_type() to use is_wchar_type()
in addition of is_byte_type().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                | 5 ++++-
 validation/init-wstring.c | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index bbfa77c3a79d..8d09c560e7fe 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -406,7 +406,10 @@ static inline int is_string_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
 		type = type->ctype.base_type;
-	return type->type == SYM_ARRAY && is_byte_type(type->ctype.base_type);
+	if (type->type != SYM_ARRAY)
+		return 0;
+	type = type->ctype.base_type;
+	return is_byte_type(type) || is_wchar_type(type);
 }
 
 static struct symbol *bad_expr_type(struct expression *expr)
diff --git a/validation/init-wstring.c b/validation/init-wstring.c
index 846b6e2c3efd..d9ce3b3c883b 100644
--- a/validation/init-wstring.c
+++ b/validation/init-wstring.c
@@ -32,7 +32,6 @@ static const __WCHAR_TYPE__ ko2[2] = L"abc";
 /*
  * check-name: init-wstring
  * check-command: sparse -Winit-cstring $file
- * check-known-to-fail
  *
  * check-error-start
 init-wstring.c:29:38: warning: too long initializer-string for array of char(no space for nul char)
-- 
2.28.0

