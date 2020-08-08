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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2187C433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86F220748
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vB/eR1Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHHQjs (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQjr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:39:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A552C061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:39:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c2so3431459edx.8
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NlxKNkqY6b8QSGh5aoEKtRZ1RaoEBHDMbomYJjM+NQ=;
        b=vB/eR1FaJELtsiHWPhgaswpKRtBEJZrAtJXUbFuzcFQv4mq/cH2RalTSyto1R9MHfD
         UuvITFxds1o+araSOiE+MDkjC0n3Bvx7o7QzktJHAyVSf+W9QlU1CrkEUEaBYJmQNTfu
         5N9W7BE7Lf7BVPiPRBxnS2/X/jPLRhDsFkUD8awwEyhTFgaTVBdZogAa/Y3CvozTAdkQ
         5DjHcMZ4Q36jYTvAUaCI2sOiSOJVaWTvdvxYfOD8397RfQiEWbILky5V+wch3CirBnaw
         8VeMgrmAqobANVx5+ljwN1RNU7ml4/HBK8Y2pd8KtvKgboYoArCegluMzLn92x1wHcud
         ZjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NlxKNkqY6b8QSGh5aoEKtRZ1RaoEBHDMbomYJjM+NQ=;
        b=dZcXj1eB+XGJBtKKAzcStF6w639E0HFC0nFzbaxQ2x/n7xr75Lytv2i3uFQGqsmvmJ
         UzVs6USA13LYpEk8gDFOnpLEcq9vnVaaZh7MHhfxush1F7DPsYrpOcmnTtIsW24d1fsa
         UF+2CA/X5ZwmulFeSmU3nwDsH2etotemiaegZ38cuzJpzcxIKry6QaKs9lTNb7DNTIE4
         ohbCbDMcv1yuT63LJTY12ZnMKNsg3yy0IXj63o5hc5FRsU2U/k20vi96N69Z0WRuf0Tz
         AM/Mgac6m2dBT858wl4KtO6KJmemo/Rdm9fGj7SaJK7xsufGHWtdvHQwNlFg+W02SKNu
         YuQg==
X-Gm-Message-State: AOAM5311SdDOBinQy8fhjq4XsdUwq/CyJfMAF+MnkbgmIuYbRDeMlDl3
        vtejQWC7WKM6+rbXDkU3vmtCEghb
X-Google-Smtp-Source: ABdhPJw9+0CKQKJt8pe9U6+zoEyhAx/pSnE+0IRt/EfqBKd9w89q6iKbLH/BlUwmCoUThcvDeV8fpQ==
X-Received: by 2002:aa7:c70b:: with SMTP id i11mr13648420edq.272.1596904785307;
        Sat, 08 Aug 2020 09:39:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id o14sm8209760edi.27.2020.08.08.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:39:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] delay 'empty character constant' warning to phase 5
Date:   Sat,  8 Aug 2020 18:39:41 +0200
Message-Id: <20200808163941.28752-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A subset of C syntax regarding character constants is:
	char-constant:
		' c-char-sequence '
	c-char-sequence:
		char
		c-char-sequence char

In short, when tokenized, a character constant must have at least
one character between the quotes. Consequently, sparse will
issue an error on empty character constants (unlike GCC).

However, sparse issues the error during tokenization (phase 3),
before preprocessing directives are handled (phase 4).
This means that code like:
	#if 0
	... ''
	#endif
will throw an error although the corresponding code is discarded.

Fix this by
1) silently accept empty char constants during tokenization
2) issue the diagnostic only when escape sequences are handled.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 char.c                                        |  5 +++++
 tokenize.c                                    |  7 +------
 validation/empty-char-constant.c              |  9 +++++++++
 validation/preprocessor/empty-char-constant.c | 13 +++++++++++++
 4 files changed, 28 insertions(+), 6 deletions(-)
 create mode 100644 validation/empty-char-constant.c
 create mode 100644 validation/preprocessor/empty-char-constant.c

diff --git a/char.c b/char.c
index f26b2a806696..730ae3f5d8ca 100644
--- a/char.c
+++ b/char.c
@@ -76,6 +76,11 @@ void get_char_constant(struct token *token, unsigned long long *val)
 	case TOKEN_WIDE_CHAR:
 		p = token->string->data;
 		end = p + token->string->length - 1;
+		if (end == p) {
+			sparse_error(token->pos, "empty character constant");
+			*val = 0;
+			return;
+		}
 		break;
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
 		end = p + type - TOKEN_CHAR;
diff --git a/tokenize.c b/tokenize.c
index c5ba6e6bbf5a..a7b6625bd2db 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -619,12 +619,7 @@ static int eat_string(int next, stream_t *stream, enum token_type type)
 		warning(stream_pos(stream), "string too long (%d bytes, %d bytes max)", len, MAX_STRING);
 		len = MAX_STRING;
 	}
-	if (delim == '\'' && len <= 4) {
-		if (len == 0) {
-			sparse_error(stream_pos(stream),
-				"empty character constant");
-			return nextchar(stream);
-		}
+	if (delim == '\'' && len && len <= 4) {
 		token_type(token) = type + len;
 		memset(buffer + len, '\0', 4 - len);
 		memcpy(token->embedded, buffer, 4);
diff --git a/validation/empty-char-constant.c b/validation/empty-char-constant.c
new file mode 100644
index 000000000000..f674037aae36
--- /dev/null
+++ b/validation/empty-char-constant.c
@@ -0,0 +1,9 @@
+static int a = '';
+
+/*
+ * check-name: empty-char-constant
+ *
+ * check-error-start
+empty-char-constant.c:1:16: error: empty character constant
+ * check-error-end
+ */
diff --git a/validation/preprocessor/empty-char-constant.c b/validation/preprocessor/empty-char-constant.c
new file mode 100644
index 000000000000..2c2481598884
--- /dev/null
+++ b/validation/preprocessor/empty-char-constant.c
@@ -0,0 +1,13 @@
+#if 0
+	''
+#endif
+
+/*
+ * check-name: empty-char-constant
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ */
-- 
2.28.0

