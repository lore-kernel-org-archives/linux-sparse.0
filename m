Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81030C4363A
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8C222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbeGSw5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438676AbgJTVKj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438673AbgJTVKi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D8C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x1so220799eds.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sse68jbrGJSujT8XS3t6wSowCCrrsJQHL8oeiyDQ5/Q=;
        b=rbeGSw5e1K3Gh8FNnoyzhPbg0RdaBa/HLPW/C4wH+TlF9064U8iQYLM8cVxiUGCdhl
         g2OIC8HQWyfGWZSZ9ndC+ABD+X8DBnQghq9wDE6kB3Iv/zToCDD40bXtyjsGSDIhrBka
         GjPLdZFmTvs54x5QkAaZ6pIo4uRDhI6U5PFA8z2BuUX8mhX6HWAwEaUBlyJapWFNLPZr
         NmFvJdI45BBFVKL7l04mI/4pbZ7yPaxNcN5fEPVBWN6YhqbnNAEySuYy5SGsInz7NDhq
         yZwlhk6THU3PDRzUgtDrgemILs4yU26WshIMZ779qD3lsu5x1RChgHfCUjYTxIpWJNac
         6Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sse68jbrGJSujT8XS3t6wSowCCrrsJQHL8oeiyDQ5/Q=;
        b=LgOVR49lxSM8NfPysAibLeLfOvfM5O4oCUyQtKm3F6nWcmIWpfkuRVi9ZSTP1GaCSs
         IeDqZa6BUHdNoxORHvZrc4NwwxbTVd/+gL4uoQTXZvTKfsHDvSYjmaULaN1Y7rdjdtup
         uewPIPCiLD2ERLHGyYuwERugLOEOylNDpIVraZk2HIAEJHIyqZQkXqXjSTvLOlgdwsGr
         kzcgok4jUsanxbtxHyV+0Tqu2hgeyTPh1PzcaCQ1NUTzgXdqAE5Pg1Hi6dSxJjRL6n3k
         9Eu8lVcSVaP5SqK91JawIVNXxSUyabPzhtti7Vv1sg3wiLZ1BXWLH2Oo1KVHL1WM99fL
         Zmxw==
X-Gm-Message-State: AOAM533ghQJgbdr12R5JtkBMEF1wejDlnzrE+rjds4ivcXLYDCUY0v2X
        K+0jMkPZLDLOhJLVHjV2MMblaZG3GEE=
X-Google-Smtp-Source: ABdhPJxilUpAfygkJiWGgBV39g7UXW3rsGylBUjoFwvG2q4FsPvZ5B8tarkw+zaiKskvlOrmJNbMvg==
X-Received: by 2002:a05:6402:293:: with SMTP id l19mr4810576edv.227.1603228236290;
        Tue, 20 Oct 2020 14:10:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/22] sub: simplify (x - -y) --> (x + y)
Date:   Tue, 20 Oct 2020 23:10:13 +0200
Message-Id: <20201020211021.82394-15-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 16 +++++++++++++++-
 validation/optim/simplify-sub-neg.c |  1 -
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index 929a177631e5..fa7e1679d7ac 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1358,6 +1358,20 @@ static int simplify_associative_binop(struct instruction *insn)
 	return REPEAT_CSE;
 }
 
+static int simplify_sub(struct instruction *insn)
+{
+	pseudo_t src2 = insn->src2;
+	struct instruction *def;
+
+	switch (DEF_OPCODE(def, src2)) {
+	case OP_NEG:				// (x - -y) --> (x + y)
+		insn->opcode = OP_ADD;
+		return replace_pseudo(insn, &insn->src2, def->src);
+	}
+
+	return 0;
+}
+
 static int simplify_constant_unop(struct instruction *insn)
 {
 	long long val = insn->src1->value;
@@ -1818,8 +1832,8 @@ int simplify_instruction(struct instruction *insn)
 	}
 
 	switch (insn->opcode) {
+	case OP_SUB: return simplify_sub(insn);
 	case OP_ADD:
-	case OP_SUB:
 	case OP_MUL:
 	case OP_AND:
 	case OP_OR:
diff --git a/validation/optim/simplify-sub-neg.c b/validation/optim/simplify-sub-neg.c
index b6fcc2baabec..49be847cca7d 100644
--- a/validation/optim/simplify-sub-neg.c
+++ b/validation/optim/simplify-sub-neg.c
@@ -3,7 +3,6 @@ int sub_neg(int x, int y) { return x - -y; }
 /*
  * check-name: simplify-sub-neg
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: add\\..*%arg., %arg.
-- 
2.28.0

