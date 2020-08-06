Return-Path: <SRS0=443P=BQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF48C433DF
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3E12177B
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQh3dD/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHFTaS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHFTaO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Aug 2020 15:30:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77663C061575
        for <linux-sparse@vger.kernel.org>; Thu,  6 Aug 2020 12:30:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so28929544ejb.11
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2020 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZslePevwSmioJ7GTGkmCwPvlwBj/kAAW6kWIRI8ZTk=;
        b=GQh3dD/5LqmaYzs6lkapESGRmMJJ5KVVz23noeqy/W31PIy1/C62ByH2zXDCGakYVe
         kzQNhT7EZHqdAXCZSwu30Za/zp0rQgckgWGLdpVFy4XAiXroswYlqKCz5UzU7xGlCth3
         bgl9KuJardK7ysu0/EfTfpvk2fbb9UgRBwgct6JI0sdsddg4BgXw7U63cNkO9oDweWLp
         q8lZvTf71cp5uITSTd/p9hfm9tkyzODCrlY1KbUMsa0dpavp2elwEAbSWvHbsOc2OEPr
         tyolKoD5n9vgYy53BCr7jaRcKStQ2FkF3Fd53GKTlOrnCVfGw6qtRQwShXK45dy6THN3
         3zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZslePevwSmioJ7GTGkmCwPvlwBj/kAAW6kWIRI8ZTk=;
        b=P61yiXFprRrAdu4ePjn21W2j0Juf59zgA7ziD3jc3qqg0Xow1wTzNw7g4oj424YwqO
         l+wFH1fpZWwAujCANgE8Nv98lZNV+qolBaZPtHPQA9S6jRFJBMUM2fKaMjB580sTF7ZR
         mGimOdcDysT4NqPdaZOQv9bqtfZDHteGCAL4bapD3TT83h9Lqtmic/Xnnk7/cOMYQmGm
         t3dE5UjIKszvhyRb/tPqV9Km4XjTbOY/WDgKI8r31TZJZyCyLJhPkYLIGeR2hhvDPbDf
         gfdh/ocXrZY7lpkMyGzw/VqfF0AUBZRg/FUdqtVhN+abhYpHokMx/JypJs+eYhda7mNq
         JQVg==
X-Gm-Message-State: AOAM530zxvosQCUBZvD+me9soLJrjWFhdbzbAvt0++/X+sbT/OiUlNZC
        hA0aGUwbylfbiWMSSgcZMz7DS6W9
X-Google-Smtp-Source: ABdhPJwubURbdx6vHtU86xAb8D76vAJsZYwZka9XE3M3VZd+VC4YigTdeZgBs2cG8mgTZgFS+TWNuw==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr5738581ejc.351.1596742212687;
        Thu, 06 Aug 2020 12:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id t19sm4055972edw.63.2020.08.06.12.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:30:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] shift-assign: add more testcases for bogus linearization
Date:   Thu,  6 Aug 2020 21:30:00 +0200
Message-Id: <20200806193003.10144-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The usual conversions must not be applied to shifts.
This causes problems for shift-assigns.

So, add testcases for all combinations of size and signedness.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/shift-assign1.c | 320 ++++++++++++++++++++++++++++++
 validation/linear/shift-assign2.c |  54 +++++
 2 files changed, 374 insertions(+)

diff --git a/validation/linear/shift-assign1.c b/validation/linear/shift-assign1.c
new file mode 100644
index 000000000000..9b3137bb2d04
--- /dev/null
+++ b/validation/linear/shift-assign1.c
@@ -0,0 +1,320 @@
+typedef  __INT16_TYPE__ s16;
+typedef  __INT32_TYPE__ s32;
+typedef  __INT64_TYPE__ s64;
+typedef __UINT16_TYPE__ u16;
+typedef __UINT32_TYPE__ u32;
+typedef __UINT64_TYPE__ u64;
+
+s16 s16s16(s16 a, s16 b) { a >>= b; return a; }
+s16 s16s32(s16 a, s32 b) { a >>= b; return a; }
+s16 s16s64(s16 a, s64 b) { a >>= b; return a; }
+s16 s16u16(s16 a, u16 b) { a >>= b; return a; }
+s16 s16u32(s16 a, u32 b) { a >>= b; return a; }
+s16 s16u64(s16 a, u64 b) { a >>= b; return a; }
+s32 s32s16(s32 a, s16 b) { a >>= b; return a; }
+s32 s32s32(s32 a, s32 b) { a >>= b; return a; }
+s32 s32s64(s32 a, s64 b) { a >>= b; return a; }
+s32 s32u16(s32 a, u16 b) { a >>= b; return a; }
+s32 s32u32(s32 a, u32 b) { a >>= b; return a; }
+s32 s32u64(s32 a, u64 b) { a >>= b; return a; }
+s64 s64s16(s64 a, s16 b);
+s64 s64s32(s64 a, s32 b);
+s64 s64s64(s64 a, s64 b) { a >>= b; return a; }
+s64 s64u16(s64 a, u16 b) { a >>= b; return a; }
+s64 s64u32(s64 a, u32 b) { a >>= b; return a; }
+s64 s64u64(s64 a, u64 b) { a >>= b; return a; }
+u16 u16s16(u16 a, s16 b) { a >>= b; return a; }
+u16 u16s32(u16 a, s32 b) { a >>= b; return a; }
+u16 u16s64(u16 a, s64 b) { a >>= b; return a; }
+u16 u16u16(u16 a, u16 b) { a >>= b; return a; }
+u16 u16u32(u16 a, u32 b) { a >>= b; return a; }
+u16 u16u64(u16 a, u64 b) { a >>= b; return a; }
+u32 u32s16(u32 a, s16 b) { a >>= b; return a; }
+u32 u32s32(u32 a, s32 b) { a >>= b; return a; }
+u32 u32s64(u32 a, s64 b) { a >>= b; return a; }
+u32 u32u16(u32 a, u16 b) { a >>= b; return a; }
+u32 u32u32(u32 a, u32 b) { a >>= b; return a; }
+u32 u32u64(u32 a, u64 b) { a >>= b; return a; }
+u64 u64s16(u64 a, s16 b);
+u64 u64s32(u64 a, s32 b);
+u64 u64s64(u64 a, s64 b) { a >>= b; return a; }
+u64 u64u16(u64 a, u16 b) { a >>= b; return a; }
+u64 u64u32(u64 a, u32 b) { a >>= b; return a; }
+u64 u64u64(u64 a, u64 b) { a >>= b; return a; }
+
+/*
+ * check-name: shift-assign1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+s16s16:
+.L0:
+	<entry-point>
+	sext.32     %r2 <- (16) %arg2
+	sext.32     %r4 <- (16) %arg1
+	asr.32      %r5 <- %r4, %r2
+	trunc.16    %r6 <- (32) %r5
+	ret.16      %r6
+
+
+s16s32:
+.L2:
+	<entry-point>
+	sext.32     %r11 <- (16) %arg1
+	asr.32      %r12 <- %r11, %arg2
+	trunc.16    %r13 <- (32) %r12
+	ret.16      %r13
+
+
+s16s64:
+.L4:
+	<entry-point>
+	trunc.32    %r17 <- (64) %arg2
+	sext.32     %r19 <- (16) %arg1
+	asr.32      %r20 <- %r19, %r17
+	trunc.16    %r21 <- (32) %r20
+	ret.16      %r21
+
+
+s16u16:
+.L6:
+	<entry-point>
+	zext.32     %r25 <- (16) %arg2
+	sext.32     %r27 <- (16) %arg1
+	asr.32      %r28 <- %r27, %r25
+	trunc.16    %r29 <- (32) %r28
+	ret.16      %r29
+
+
+s16u32:
+.L8:
+	<entry-point>
+	sext.32     %r34 <- (16) %arg1
+	asr.32      %r35 <- %r34, %arg2
+	trunc.16    %r36 <- (32) %r35
+	ret.16      %r36
+
+
+s16u64:
+.L10:
+	<entry-point>
+	trunc.32    %r40 <- (64) %arg2
+	sext.32     %r42 <- (16) %arg1
+	asr.32      %r43 <- %r42, %r40
+	trunc.16    %r44 <- (32) %r43
+	ret.16      %r44
+
+
+s32s16:
+.L12:
+	<entry-point>
+	sext.32     %r48 <- (16) %arg2
+	asr.32      %r50 <- %arg1, %r48
+	ret.32      %r50
+
+
+s32s32:
+.L14:
+	<entry-point>
+	asr.32      %r55 <- %arg1, %arg2
+	ret.32      %r55
+
+
+s32s64:
+.L16:
+	<entry-point>
+	trunc.32    %r59 <- (64) %arg2
+	asr.32      %r61 <- %arg1, %r59
+	ret.32      %r61
+
+
+s32u16:
+.L18:
+	<entry-point>
+	zext.32     %r65 <- (16) %arg2
+	asr.32      %r67 <- %arg1, %r65
+	ret.32      %r67
+
+
+s32u32:
+.L20:
+	<entry-point>
+	asr.32      %r72 <- %arg1, %arg2
+	ret.32      %r72
+
+
+s32u64:
+.L22:
+	<entry-point>
+	trunc.32    %r76 <- (64) %arg2
+	asr.32      %r78 <- %arg1, %r76
+	ret.32      %r78
+
+
+s64s64:
+.L24:
+	<entry-point>
+	asr.64      %r83 <- %arg1, %arg2
+	ret.64      %r83
+
+
+s64u16:
+.L26:
+	<entry-point>
+	zext.64     %r88 <- (16) %arg2
+	asr.64      %r90 <- %arg1, %r88
+	ret.64      %r90
+
+
+s64u32:
+.L28:
+	<entry-point>
+	zext.64     %r94 <- (32) %arg2
+	asr.64      %r96 <- %arg1, %r94
+	ret.64      %r96
+
+
+s64u64:
+.L30:
+	<entry-point>
+	asr.64      %r101 <- %arg1, %arg2
+	ret.64      %r101
+
+
+u16s16:
+.L32:
+	<entry-point>
+	sext.32     %r105 <- (16) %arg2
+	zext.32     %r107 <- (16) %arg1
+	asr.32      %r108 <- %r107, %r105
+	trunc.16    %r109 <- (32) %r108
+	ret.16      %r109
+
+
+u16s32:
+.L34:
+	<entry-point>
+	zext.32     %r114 <- (16) %arg1
+	asr.32      %r115 <- %r114, %arg2
+	trunc.16    %r116 <- (32) %r115
+	ret.16      %r116
+
+
+u16s64:
+.L36:
+	<entry-point>
+	trunc.32    %r120 <- (64) %arg2
+	zext.32     %r122 <- (16) %arg1
+	asr.32      %r123 <- %r122, %r120
+	trunc.16    %r124 <- (32) %r123
+	ret.16      %r124
+
+
+u16u16:
+.L38:
+	<entry-point>
+	zext.32     %r128 <- (16) %arg2
+	zext.32     %r130 <- (16) %arg1
+	asr.32      %r131 <- %r130, %r128
+	trunc.16    %r132 <- (32) %r131
+	ret.16      %r132
+
+
+u16u32:
+.L40:
+	<entry-point>
+	zext.32     %r137 <- (16) %arg1
+	asr.32      %r138 <- %r137, %arg2
+	trunc.16    %r139 <- (32) %r138
+	ret.16      %r139
+
+
+u16u64:
+.L42:
+	<entry-point>
+	trunc.32    %r143 <- (64) %arg2
+	zext.32     %r145 <- (16) %arg1
+	asr.32      %r146 <- %r145, %r143
+	trunc.16    %r147 <- (32) %r146
+	ret.16      %r147
+
+
+u32s16:
+.L44:
+	<entry-point>
+	sext.32     %r151 <- (16) %arg2
+	lsr.32      %r153 <- %arg1, %r151
+	ret.32      %r153
+
+
+u32s32:
+.L46:
+	<entry-point>
+	lsr.32      %r158 <- %arg1, %arg2
+	ret.32      %r158
+
+
+u32s64:
+.L48:
+	<entry-point>
+	trunc.32    %r162 <- (64) %arg2
+	lsr.32      %r164 <- %arg1, %r162
+	ret.32      %r164
+
+
+u32u16:
+.L50:
+	<entry-point>
+	zext.32     %r168 <- (16) %arg2
+	lsr.32      %r170 <- %arg1, %r168
+	ret.32      %r170
+
+
+u32u32:
+.L52:
+	<entry-point>
+	lsr.32      %r175 <- %arg1, %arg2
+	ret.32      %r175
+
+
+u32u64:
+.L54:
+	<entry-point>
+	trunc.32    %r179 <- (64) %arg2
+	lsr.32      %r181 <- %arg1, %r179
+	ret.32      %r181
+
+
+u64s64:
+.L56:
+	<entry-point>
+	lsr.64      %r186 <- %arg1, %arg2
+	ret.64      %r186
+
+
+u64u16:
+.L58:
+	<entry-point>
+	zext.64     %r191 <- (16) %arg2
+	lsr.64      %r193 <- %arg1, %r191
+	ret.64      %r193
+
+
+u64u32:
+.L60:
+	<entry-point>
+	zext.64     %r197 <- (32) %arg2
+	lsr.64      %r199 <- %arg1, %r197
+	ret.64      %r199
+
+
+u64u64:
+.L62:
+	<entry-point>
+	lsr.64      %r204 <- %arg1, %arg2
+	ret.64      %r204
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/shift-assign2.c b/validation/linear/shift-assign2.c
new file mode 100644
index 000000000000..30d74376478e
--- /dev/null
+++ b/validation/linear/shift-assign2.c
@@ -0,0 +1,54 @@
+typedef  __INT16_TYPE__ s16;
+typedef  __INT32_TYPE__ s32;
+typedef  __INT64_TYPE__ s64;
+typedef __UINT16_TYPE__ u16;
+typedef __UINT32_TYPE__ u32;
+typedef __UINT64_TYPE__ u64;
+
+s64 s64s16(s64 a, s16 b) { a >>= b; return a; }
+s64 s64s32(s64 a, s32 b) { a >>= b; return a; }
+u64 u64s16(u64 a, s16 b) { a >>= b; return a; }
+u64 u64s32(u64 a, s32 b) { a >>= b; return a; }
+
+/*
+ * check-name: shift-assign2
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+s64s16:
+.L0:
+	<entry-point>
+	sext.32     %r2 <- (16) %arg2
+	zext.64     %r3 <- (32) %r2
+	asr.64      %r5 <- %arg1, %r3
+	ret.64      %r5
+
+
+s64s32:
+.L2:
+	<entry-point>
+	zext.64     %r9 <- (32) %arg2
+	asr.64      %r11 <- %arg1, %r9
+	ret.64      %r11
+
+
+u64s16:
+.L4:
+	<entry-point>
+	sext.32     %r15 <- (16) %arg2
+	zext.64     %r16 <- (32) %r15
+	lsr.64      %r18 <- %arg1, %r16
+	ret.64      %r18
+
+
+u64s32:
+.L6:
+	<entry-point>
+	zext.64     %r22 <- (32) %arg2
+	lsr.64      %r24 <- %arg1, %r22
+	ret.64      %r24
+
+
+ * check-output-end
+ */
-- 
2.28.0

