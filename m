Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A1C388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C8A20885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2CZPYm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgKHBVd (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBVd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:21:33 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2DC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:21:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o23so7242834ejn.11
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl8oH1QkLHvtjj1QocWRnIRwLfAaT8UGP3+Efz8Kz1k=;
        b=n2CZPYm0SfcxbGoBzD2MGOjGC6tAosrd+un0aJc2JErVdgF/9GDPkDYiEGO4tlJG4t
         ++21o4w9wfs44GROYridPKzjORD0VKOdwePbsEgmNwM6v7mLSS4dY0D0PRJW0SylHaGC
         WBg37A58TJHhpJ49hGB5R4nh1l6yIhi/pn5ztZo3QIsLUACtf4h1j1XZfAdXDrwWmD0o
         lw1Q/YHwTFZF6BjbhM5ran4QLMHwNJ2A11lTyJc+viTYqszUVgRETMsZK0+7s/GXMKHy
         164rTLYIT4LfjHyqgIb6UNYFWBJwiqn1DOMAg58kYljm4WU4gG2jw4fRANvb84dPCpl0
         WfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl8oH1QkLHvtjj1QocWRnIRwLfAaT8UGP3+Efz8Kz1k=;
        b=QRJAAsVyTn71ANuN3TaxwdfQIJ7ZpLXvhtp/TwaYmAopzQ73ndvErtBRJ3F8lOL4tQ
         92sJL+i6zM+0unFiv5gW7dmD8FdcL+8FTgGe8ayC4BX2IWYOuiRHEIXbxsfbXghgrF6y
         87kcCuDTtBpOz1N9LF9U9ZxV3GZBEG2fzaFkFtZoCQXUCYa3WyQ80rqkqSG6h3VXwAf8
         PEhZV3arlBruPCzGJNwOxSrXw19KP/HdD3Tn4gO5PCSpah8MVixm+Ia1eunSA6rvy50J
         Yb9PB7wEPCFgqaU2Mc7I/qtEyW4lCaWVaQJmbVvzBSANr+SKo6C2yWl0HELff5TWKKIO
         MPnw==
X-Gm-Message-State: AOAM533rDnQywQ096QtMAhnL91TBgDlaMpVgCHHRcCMzNf3Z428gFhjQ
        l+99SQ4oZiisJmoixXllBbXRyLeTz2s=
X-Google-Smtp-Source: ABdhPJxLF58CWac2FeqvdwwmGDluVHbXOFCotwcdie066v4d41fpWHRbOCwJ8edBPojjxxnf9LuShw==
X-Received: by 2002:a17:907:6ef:: with SMTP id yh15mr8595759ejb.506.1604798491628;
        Sat, 07 Nov 2020 17:21:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id u25sm4511426eje.99.2020.11.07.17.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:21:31 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/16] cmp: simplify sext(x) cmps {SMAX,SMIN}
Date:   Sun,  8 Nov 2020 02:21:22 +0100
Message-Id: <20201108012126.94339-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
 <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A signed compare of a sign-extended value against a constant
outside of the original range is statically known.

Simplify to the corresponding 0/1.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 14 ++++++++++++++
 validation/optim/cmp-sext-simm.c |  1 -
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 1cb5275b7a73..a59918697762 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1148,6 +1148,20 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			insn->src2 = value_pseudo(zero_extend(value, osize));
 			return replace_pseudo(insn, &insn->src1, def->src);
 		}
+		switch (insn->opcode) {
+		case OP_SET_LT: case OP_SET_LE:
+			if (value >= sign_bit(osize))
+				return replace_with_value(insn, 1);
+			else
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_GE: case OP_SET_GT:
+			if (value >= sign_bit(osize))
+				return replace_with_value(insn, 0);
+			else
+				return replace_with_value(insn, 1);
+			break;
+		}
 		break;
 	case OP_ZEXT:
 		osize = def->orig_type->bit_size;
diff --git a/validation/optim/cmp-sext-simm.c b/validation/optim/cmp-sext-simm.c
index c2099a6b8876..a8b2a8f9feff 100644
--- a/validation/optim/cmp-sext-simm.c
+++ b/validation/optim/cmp-sext-simm.c
@@ -23,7 +23,6 @@ static int ge_lt1(int x) { return (sext(x) >= (NEG - 1)) == 0; }
 /*
  * check-name: cmp-sext-simm
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

