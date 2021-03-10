Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2FBC43331
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B23364FC3
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhCJWLP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhCJWLG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA0C061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ci14so41810198ejc.7
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CslCwwl1gY0nUwzFdQ+AlQKchoWTYgXm2OAEpGum/h8=;
        b=CCx4X/cdBnC43HNa2rBrLDB/hWu/XNovBa/Q6Z+CUiy0audtvkEPYFtnWoH0UI++8I
         U9B8xmY5lt19Rj9s0t/4O/8b7JCW+4kmIBlkztr6ZYwY3iUtw1ziACmKZk7CehRIdSon
         t/IkmAqhsKFk32fazFWtxM+SL6X/L54WPS2WfLUGCuXN31I5IFI7uys6FncqakKuaEuH
         EpR27BBUbBJZbnd3TmbgYD4R0io7kSyn3xkoAK2pbD8HEUqmFCcpuwafjuD9xQGjEgli
         zQoWji2cBXHidQUVBlOenbJgHZKUfD8XpuzojKa6YD4JL1CkEwEK3jgjVJzjJDayoQJ6
         5phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CslCwwl1gY0nUwzFdQ+AlQKchoWTYgXm2OAEpGum/h8=;
        b=To5+QvCAWE96SrjaPJ+RnI4FD5wKTPwN6xr/Y2z+DK26jydn2Vp6J9VnqrmL/rjUwJ
         d0qKjiYuQJzWL3xlwh9rAJEjAUF9IKV4itDn8tfXLBpQm5UE+VDTc36CShN4x5Nh804A
         8FC0xO0/d30DsEHnju+y5zrk/5d/3mPTRgyrYU+uUxadt84qs//Z7+Pi+6fAw5P0eiKd
         Ctob23Dj7DXTJuxv2s1PzzE61Vb9HGBDWe6mF32Dm3fxoFOMC3TcZnvovD7EFf4QJ8bc
         hiNCuptb+gn1SZu4jyZezINbAWkmItgXaqUEfPS3vqhzHMWcmH2st4EUAP+M5dUwcHMA
         meKQ==
X-Gm-Message-State: AOAM531xl60texfeecbA4gkLbsisR2SjzqaH0ObhMmTFfGxo4Q/Kvmfl
        0bEGHLxMGyWP6x1KHYtzOP3w8PtjNjU=
X-Google-Smtp-Source: ABdhPJypEDH1O+FN7FWZO22WogjgBhVQLZK7Ppkn0Sez7qQ1VQCEZ5fIndDT/gRXOfozl0Rsox4OXQ==
X-Received: by 2002:a17:906:6817:: with SMTP id k23mr89079ejr.6.1615414264641;
        Wed, 10 Mar 2021 14:11:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:04 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] simplify (x & M) {==,!=} C
Date:   Wed, 10 Mar 2021 22:49:47 +0100
Message-Id: <20210310214950.84192-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 8 ++++++++
 validation/optim/cmpe-and0.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 6c11018ea3bf..b46e08c3b79a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1263,6 +1263,14 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			break;
 		bits = def->src2->value;
 		switch (insn->opcode) {
+		case OP_SET_EQ:
+			if ((value & bits) != value)
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_NE:
+			if ((value & bits) != value)
+				return replace_with_value(insn, 1);
+			break;
 		case OP_SET_LE:
 			value = sign_extend(value, def->size);
 			if (bits & sign_bit(def->size))
diff --git a/validation/optim/cmpe-and0.c b/validation/optim/cmpe-and0.c
index 7db608365568..75af77528f61 100644
--- a/validation/optim/cmpe-and0.c
+++ b/validation/optim/cmpe-and0.c
@@ -4,7 +4,6 @@ int cmpe_and_ne(int a) { return ((a & 0xff00) != 0xff01) + 0; }
 /*
  * check-name: cmpe-and0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

