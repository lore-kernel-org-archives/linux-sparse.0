Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F140BC433E1
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABCE2089D
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1EJVXk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGMWdO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMWdM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557FC061794
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:12 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so15182778edq.8
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQiz0ASjsBVuIOoE0wH4IpqkK54hYmwGtI5sZyqcPy8=;
        b=Z1EJVXk6HhFwGKlR2IdfQKtnXm9NwEolTvYn+qGFg/pxS0iT477GPwiIINEScZTDSh
         n9IoIjCsyt0fhSLWxlFrR/d60htp4pOrWFyIgQFgrCfo/1SkmeD7wvuNSHrTi+t2CO31
         iVC/YDFUSsVxYtX0ejhrb0tXMvk9SLo9upMMij5ZcdL+mRhyE1voR2N0/n/BZanEJPlt
         q2dfLN9+XRu7hHPrIxiw52jH8BykvBQvdob/U5VwXl1f5BxS0Qzn/KDpFLVlIykLdhxr
         0ML1umzd+JGTKltYseNGYCorMZw4ryhSKMUGyPe7uEu7nDS+bu7Q8EmyzFNSyKpIe5ev
         LCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQiz0ASjsBVuIOoE0wH4IpqkK54hYmwGtI5sZyqcPy8=;
        b=ms1nHnc2Czs6TIBAGYioBbYABlWKtIGAmOpB6dUqhy1olYJQjnc0mQtWokwqWJ93ft
         3vJ95glEqFh3C3J+WEuq2gHGAPylXFYPcVHkAyXAJGaJeFL7RmJSJYcaCWH724TIrD5p
         WyuCyC/EN7BsBF3SARcWOLVkD625IAls8dh8xITCCpXvndlQCGxICXIv5eEFSD2ILTKH
         E5ENovklw1AfSLRD65i5XB4ENQu0xC8I1vmIlAbR9uyy4L7domugS1WH4TAhRiZ/afOD
         mgtyLM3VcvirDFjrnxM3I54zAphLNFXRYUKAgFZhC4O5vyDhOeOykktI4STutLuYNvCq
         ACiA==
X-Gm-Message-State: AOAM533FE+0x03sl7dhaLltZkY632F1pV5kUYqiPOhhcCZGpajqsUhZ0
        dLCEQTJPX49cu6KQFtqEL7ukEebP
X-Google-Smtp-Source: ABdhPJzjXPJbEwxKhRIJgprMc5oul4wcUyUl43CVh0NzMEVot7ECEsUpKkQwJMleBSDPzGCIaKrcfw==
X-Received: by 2002:aa7:c80f:: with SMTP id a15mr1466258edt.299.1594679590542;
        Mon, 13 Jul 2020 15:33:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] ppc: add predefines __LONGDOUBLE128 & __LONG_DOUBLE_128__
Date:   Tue, 14 Jul 2020 00:32:57 +0200
Message-Id: <20200713223304.83666-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On powerpc, if long double is 128-bit width, then
'__LONGDOUBLE128' & '__LONG_DOUBLE_128__' should be defined.

So do this in the target specific file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-ppc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target-ppc.c b/target-ppc.c
index c0d6068f436a..dede8917cbd6 100644
--- a/target-ppc.c
+++ b/target-ppc.c
@@ -14,6 +14,10 @@ static void predefine_ppc(const struct target *self)
 	predefine("_ARCH_PPC", 1, "1");
 	if (arch_big_endian)
 		predefine("_BIG_ENDIAN", 1, "1");
+	if (ldouble_ctype.bit_size == 128) {
+		predefine("__LONGDOUBLE128", 1, "1");
+		predefine("__LONG_DOUBLE_128__", 1, "1");
+	}
 }
 
 static const char *asm_constraint_ppc(struct asm_operand *op, int c, const char *str)
-- 
2.27.0

