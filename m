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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E0C55178
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206BB20885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEpdwkKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgKHBTp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBTp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:45 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7AC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:45 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id s25so7254216ejy.6
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EEkqOZFf7NeoiiPS3rHxKAiCD0FxssLtu57iKfw4uY=;
        b=ZEpdwkKf/xYZiQ/9l1dQfnsKiCFlDzuDP+GKbdDCsFx1WgiUEj5SYa3uCji2sIjjjn
         VS76PLKGEGVrqMo/crEvk5Z9C/A161ttCl5am0tUKDxoHICodtjms5NjPvjw7hCKKMKu
         7ABAkKIH99ZOi5Iauna+7YxFRSEGD6A4DQRGXZfyIj6M8B7uQgruRe0vGxLE1jQCyCyr
         +fWTYgBSOtG4C1DtnfglF8he5JUjXkMygZhnuaqsz0JG4hxQF81VQosgjd3L8Fs/aC2T
         /e2m/iHWYtMi1wWOhli/ydOcx6yoYAgjbO2y0YvbQAYE/aLA1b92T1nZ6Io3YR4u6Hlw
         4fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EEkqOZFf7NeoiiPS3rHxKAiCD0FxssLtu57iKfw4uY=;
        b=sKuo4IbSyxMRQzf4K2KKXbVln91GXfVtFbKX14hqIFYfoNem2jWi7pn3QIaTIUiBRO
         Vlx0Z89UFd1qZLZdd5dpJ4GWH61CBazUfJGOEVXxtVUANSI3V8Nmbuj2CMQMKYDCJezd
         iA3GScvRn9Sj/IemiMj/2Y/LwvxHYgXgLQEpbopaNGkzzP9ZWwkXqsox89QBu7OwTv9k
         n3YSe3EER4F0tEzGr/Cs7fsQehqW/638bQdZqFklzrj1hkf2yANRR0m+gq2q/lKvlPHx
         tcN9dWxL+nE/65L9+jrsmJ8A8TPb2Bq1kVVlJFwpNFaHXfsr++oi1wciZIJWULHIf/lU
         TVQg==
X-Gm-Message-State: AOAM530EXjK6y9U9tU/JzEZo5pB4xs/WEFkNW/328avjFMFnYTNuHXhl
        Ni4L/EWQcopWS/iE0MeOPVsQOxnnG5I=
X-Google-Smtp-Source: ABdhPJz5NhuioIPGOTDrh/EF5nBndg+7UH6PkXAs2VfiFX0Ge4B9UGI8/CXNsaB8+Kfgt/kwOvTpXQ==
X-Received: by 2002:a17:906:5589:: with SMTP id y9mr773355ejp.412.1604798383799;
        Sat, 07 Nov 2020 17:19:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:43 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/16] cmp: adapt testcase for compares' canonicalization
Date:   Sun,  8 Nov 2020 02:19:31 +0100
Message-Id: <20201108011939.94252-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current testcase, because it's just checking test-linearize's
output as-is, is very sensitive to small simplification changes.

Fix this by changing the tests into equivalent tests and then just
checking that these tests return '1'. This allows to test only what
really matters for canonicalization and make these tests very robust.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-cmp.c | 125 ++++---------------------------
 1 file changed, 14 insertions(+), 111 deletions(-)

diff --git a/validation/optim/canonical-cmp.c b/validation/optim/canonical-cmp.c
index e0ca7db36368..9b930b1cbeaa 100644
--- a/validation/optim/canonical-cmp.c
+++ b/validation/optim/canonical-cmp.c
@@ -1,124 +1,27 @@
 typedef	  signed int	sint;
 typedef	unsigned int	uint;
 
-sint seq(sint p, sint a) { return (123 == p) ? a : 0; }
-sint sne(sint p, sint a) { return (123 != p) ? a : 0; }
+sint seq(sint p, sint a) { return (123 == p) == (p == 123); }
+sint sne(sint p, sint a) { return (123 != p) == (p != 123); }
 
-sint slt(sint p, sint a) { return (123 >  p) ? a : 0; }
-sint sle(sint p, sint a) { return (123 >= p) ? a : 0; }
-sint sge(sint p, sint a) { return (123 <= p) ? a : 0; }
-sint sgt(sint p, sint a) { return (123 <  p) ? a : 0; }
+sint slt(sint p, sint a) { return (123 >  p) == (p <  123); }
+sint sle(sint p, sint a) { return (123 >= p) == (p <= 123); }
+sint sge(sint p, sint a) { return (123 <= p) == (p >= 123); }
+sint sgt(sint p, sint a) { return (123 <  p) == (p >  123); }
 
-uint ueq(uint p, uint a) { return (123 == p) ? a : 0; }
-uint une(uint p, uint a) { return (123 != p) ? a : 0; }
+uint ueq(uint p, uint a) { return (123 == p) == (p == 123); }
+uint une(uint p, uint a) { return (123 != p) == (p != 123); }
 
-uint ubt(uint p, uint a) { return (123 >  p) ? a : 0; }
-uint ube(uint p, uint a) { return (123 >= p) ? a : 0; }
-uint uae(uint p, uint a) { return (123 <= p) ? a : 0; }
-uint uat(uint p, uint a) { return (123 <  p) ? a : 0; }
+uint ubt(uint p, uint a) { return (123 >  p) == (p <  123); }
+uint ube(uint p, uint a) { return (123 >= p) == (p <= 123); }
+uint uae(uint p, uint a) { return (123 <= p) == (p >= 123); }
+uint uat(uint p, uint a) { return (123 <  p) == (p >  123); }
 
 /*
  * check-name: canonical-cmp
+ * check-description: check that constants move rightside
  * check-command: test-linearize -Wno-decl $file
  *
+ * check-output-ignore
  * check-output-excludes: \\$123,
- *
- * check-output-start
-seq:
-.L0:
-	<entry-point>
-	seteq.32    %r3 <- %arg1, $123
-	select.32   %r4 <- %r3, %arg2, $0
-	ret.32      %r4
-
-
-sne:
-.L2:
-	<entry-point>
-	setne.32    %r8 <- %arg1, $123
-	select.32   %r9 <- %r8, %arg2, $0
-	ret.32      %r9
-
-
-slt:
-.L4:
-	<entry-point>
-	setlt.32    %r13 <- %arg1, $123
-	select.32   %r14 <- %r13, %arg2, $0
-	ret.32      %r14
-
-
-sle:
-.L6:
-	<entry-point>
-	setle.32    %r18 <- %arg1, $123
-	select.32   %r19 <- %r18, %arg2, $0
-	ret.32      %r19
-
-
-sge:
-.L8:
-	<entry-point>
-	setge.32    %r23 <- %arg1, $123
-	select.32   %r24 <- %r23, %arg2, $0
-	ret.32      %r24
-
-
-sgt:
-.L10:
-	<entry-point>
-	setgt.32    %r28 <- %arg1, $123
-	select.32   %r29 <- %r28, %arg2, $0
-	ret.32      %r29
-
-
-ueq:
-.L12:
-	<entry-point>
-	seteq.32    %r33 <- %arg1, $123
-	select.32   %r34 <- %r33, %arg2, $0
-	ret.32      %r34
-
-
-une:
-.L14:
-	<entry-point>
-	setne.32    %r38 <- %arg1, $123
-	select.32   %r39 <- %r38, %arg2, $0
-	ret.32      %r39
-
-
-ubt:
-.L16:
-	<entry-point>
-	setb.32     %r43 <- %arg1, $123
-	select.32   %r44 <- %r43, %arg2, $0
-	ret.32      %r44
-
-
-ube:
-.L18:
-	<entry-point>
-	setbe.32    %r48 <- %arg1, $123
-	select.32   %r49 <- %r48, %arg2, $0
-	ret.32      %r49
-
-
-uae:
-.L20:
-	<entry-point>
-	setae.32    %r53 <- %arg1, $123
-	select.32   %r54 <- %r53, %arg2, $0
-	ret.32      %r54
-
-
-uat:
-.L22:
-	<entry-point>
-	seta.32     %r58 <- %arg1, $123
-	select.32   %r59 <- %r58, %arg2, $0
-	ret.32      %r59
-
-
- * check-output-end
  */
-- 
2.29.2

