Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76675C5519F
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3747F206D9
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8aFEsF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgKNJqX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 14 Nov 2020 04:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgKNJqX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 14 Nov 2020 04:46:23 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB20C0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 01:46:22 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so17394607ejm.0
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 01:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FA/hKoCDw1kyjHdjmVPcqeKfj2V8+QrYL9SmRN29fiY=;
        b=u8aFEsF9fdzeUKTw0OJZ9R+JUZTTyo+wvEId/cfqNpi6au+ao2clfy4DL0dcLvnzqh
         JqK5KtaFRn8jV5lF70xN+zuwUhJduEbASdAFCjEj1EY8na4mScCDyh5i84CvbbNT/m64
         XoqVXjVts6UO8ejhCXL2cUQtKnikRqVSnIJQMulNED4rXKIYP2fDjN8OSfUrHZRMdX7I
         ENLLkw+pCVQR5VTndwACyaHxaXAGg1TEqU6wUlqyFtnlmIkPopGVpQ1LnDlPScDvtkED
         VIs0RFaKrIBdWRPp1LIVmzxpRAvvFZHqdTdoyEj6SQ6vt3EUAQxV1/KRoYNbn3oRl6+2
         0xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FA/hKoCDw1kyjHdjmVPcqeKfj2V8+QrYL9SmRN29fiY=;
        b=H89sJG7lKk3nei0pUMx6zxtgn5DrnxgKSEDhQQcrzFoBEvYBpZtv4B/lDIKK+Sxrx8
         RaQJKTtmB045OF1URGH7JxZLLo0c4+l2rEWSTSB0qHbqeDRZKS7o0zZk/bbSgaiukid9
         QrqYyfcMDMGOG0yVra4HCxNDgvxj/R6DOB5mJgFAXFB4lkZGGCRtwRgEZHpet9DlqbBS
         Sb1VtTfnrDfuHdgcwJUcDF2SbZcXrYWTXcy8FYqtAl5N4jPSNCSSjqF4mzZYml0kGuxC
         +XFVnpQUNc3Dtw91sMrrLjrpvZSPFnJzoTGgUhG9o2P1qLo/tEE20N85yCzxvBoX9hJx
         p6Hg==
X-Gm-Message-State: AOAM530YTlDAS6Hu1skgIsc6EKWpi1zLPGbh5It6GXuxyDla3yTqSzfn
        ayjwOhOddTPrSU/HkBQC1VLsvfW2I6g=
X-Google-Smtp-Source: ABdhPJxUTW2iJTmyVW3zCbEcF8aT4xBQO3bRLf0FrL9ZLPd8euJKOX3rwkB5pgJ6ypf02HslXimfKQ==
X-Received: by 2002:a17:906:81da:: with SMTP id e26mr5861767ejx.491.1605347181118;
        Sat, 14 Nov 2020 01:46:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8ee:663e:d7a3:b425])
        by smtp.gmail.com with ESMTPSA id n7sm6435063edb.34.2020.11.14.01.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 01:46:20 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add missing REPEAT_CFG_CLEANUP
Date:   Sat, 14 Nov 2020 10:46:17 +0100
Message-Id: <20201114094617.60593-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

simplify_branch() & insert_branch() convert a conditional branch
into an unconditional one, removing a child which may then
become unreachable.

However, these function doesn't set REPEAT_CFG_CLEANUP and the
unreachable child may not be removed.

Fix this by setting the missing REPEAT_CFG_CLEANUP in these functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 1 +
 simplify.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index ab91113d00eb..5d800b7f4006 100644
--- a/linearize.c
+++ b/linearize.c
@@ -726,6 +726,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 		remove_parent(child, bb);
 	} END_FOR_EACH_PTR(child);
 	PACK_PTR_LIST(&bb->children);
+	repeat_phase |= REPEAT_CFG_CLEANUP;
 }
 	
 
diff --git a/simplify.c b/simplify.c
index e58fb6cf3941..a0e23d6de01f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2048,7 +2048,7 @@ static int simplify_branch(struct instruction *insn)
 		kill_use(&insn->cond);
 		insn->cond = NULL;
 		insn->opcode = OP_BR;
-		return REPEAT_CSE;
+		return REPEAT_CSE|REPEAT_CFG_CLEANUP;
 	}
 
 	/* Conditional on a SETNE $0 or SETEQ $0 */
-- 
2.29.2

