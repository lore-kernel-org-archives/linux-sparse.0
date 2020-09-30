Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD01C47428
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481642076B
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R15aPmUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgI3XSw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbgI3XSo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF9C0613D0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so3545280wrn.13
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbQLmC8gdfb42znA/sMTP6J8RyOXPvyy0YjXSQYAby4=;
        b=R15aPmUy38g/FD2VE3+a6+vTrVqLWPlMPzMpVD9P5rN3iyaFjV/Zg2rr4lNleNaR5+
         21slKeEf5lHNjIPd6uMEzNhkl9tv6B54H9M0W2AZUo0KS2w4WO6mDl5d6wWCQ6wT7gi9
         GlKYceD6EqHcBF8kdQnWU5fS0GoZhd8/Uw81eCASRLm/RQr9A+KM1wcLnFyLN5Dg0uJT
         wRiGYjNHl84HvcucmmhmRVxCxyQYCjHG/gTKvvYGU7nuFfly1Ml+lAYLetYcn8LmJEra
         FIFOIfiYQRoOtT1ls7lrQ6BhwNEuj0RMBOemmSiyeqAoY20DWd6sTdUSF8NC23R7Spat
         taEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbQLmC8gdfb42znA/sMTP6J8RyOXPvyy0YjXSQYAby4=;
        b=sokEM9F6JlqfxLFpnItNPBntgA6TLtjJleORilPCa2znCxZMRRT8XdO4u3X/uvJJ0U
         ttO1UQXs2J8bhbAc97cWH31Vnfdv9bAtqBRmhP8NW7RrU0s6S+766ke1JMwKhaPHKHdX
         k/fI77Of2I+gN2NON4wtDcqJrfGQrTOXt3Aly0SmZ4xc+pKTlxxiG/LjkAWhJGW0F+sK
         M7VVbk/0zcZnvpzvE/8OkhmYYej839n5lYLOzwGNXCNhSwzoiUdwywbaa0HJkb0gEbDB
         ysD0kPVnca4j6l7Mnf/wA/gaj6MuyN9HxnJa/uFa9mMkJKyx7DQR/1+ZVQkVvDSIdiFt
         WfJw==
X-Gm-Message-State: AOAM5329HTKrTPbQVMXoS366cJ+p7xQqpS6gI8l9Cj9ENYdI4CNCyZCV
        9KuiFbc16Tunb4UkAeND9GaHApJhfEo=
X-Google-Smtp-Source: ABdhPJw2srdzacWoHTdo94QPt7wo0rHJpxaMp4G9bCj3bvzWRbx42K4mNvV3R5iYUHbe31yDHeNHJQ==
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr5418177wrt.211.1601507922566;
        Wed, 30 Sep 2020 16:18:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/13] flex-array: warn an arrays containing a flexible array
Date:   Thu,  1 Oct 2020 01:18:26 +0200
Message-Id: <20200930231828.66751-12-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

An array of some aggregate type containing, possibly recursively,
a flexible array is pretty non-sensical. So, add an option
-Wflexible-array-array to warn on such usage.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c                     | 2 ++
 options.h                     | 1 +
 sparse.1                      | 7 +++++++
 symbol.c                      | 2 ++
 validation/flex-array-array.c | 1 -
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/options.c b/options.c
index ce88fbf6ed61..a8129ac1e952 100644
--- a/options.c
+++ b/options.c
@@ -100,6 +100,7 @@ int Wdesignated_init = 1;
 int Wdo_while = 0;
 int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
+int Wflexible_array_array = 1;
 int Wflexible_array_sizeof = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
@@ -841,6 +842,7 @@ static const struct flag warnings[] = {
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "external-function-has-definition", &Wexternal_function_has_definition },
+	{ "flexible-array-array", &Wflexible_array_array },
 	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
diff --git a/options.h b/options.h
index feb351a36c9e..7bcf925b6912 100644
--- a/options.h
+++ b/options.h
@@ -99,6 +99,7 @@ extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
+extern int Wflexible_array_array;
 extern int Wflexible_array_sizeof;
 extern int Wimplicit_int;
 extern int Winit_cstring;
diff --git a/sparse.1 b/sparse.1
index 5f98df33a231..c1a74153c618 100644
--- a/sparse.1
+++ b/sparse.1
@@ -257,6 +257,13 @@ Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-external\-function\-has\-definition\fR.
 .
 .TP
+.B -Wflexible-array-array
+Warn about arrays of structures containing a flexible array.
+
+Sparse issues these warnings by default. To turn them off, use
+\fB-Wno-flexible-array-array\fR.
+.
+.TP
 .B -Wflexible-array-sizeof
 Warn about using the sizeof operator on a structure containing a flexible array,
 possibly recursively.
diff --git a/symbol.c b/symbol.c
index bffdc135ba69..02b9066e966a 100644
--- a/symbol.c
+++ b/symbol.c
@@ -267,6 +267,8 @@ static struct symbol * examine_array_type(struct symbol *sym)
 			bit_size = -1;
 		}
 	}
+	if (has_flexible_array(base_type) && Wflexible_array_array)
+		warning(sym->pos, "array of flexible structures");
 	alignment = base_type->ctype.alignment;
 	if (!sym->ctype.alignment)
 		sym->ctype.alignment = alignment;
diff --git a/validation/flex-array-array.c b/validation/flex-array-array.c
index bda80d7a0a20..921a0698bb28 100644
--- a/validation/flex-array-array.c
+++ b/validation/flex-array-array.c
@@ -8,7 +8,6 @@ static struct s a[2];
 /*
  * check-name: flex-array-array
  * check-command: sparse -Wflexible-array-array $file
- * check-known-to-fail
  *
  * check-error-start
 flex-array-array.c:6:18: warning: array of flexible structures
-- 
2.28.0

