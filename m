Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793CCC4363A
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5A62083B
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt5+4G2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJEXEI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEXEI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Oct 2020 19:04:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB1C0613A7
        for <linux-sparse@vger.kernel.org>; Mon,  5 Oct 2020 16:04:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so14599546ejy.11
        for <linux-sparse@vger.kernel.org>; Mon, 05 Oct 2020 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WQLI+70CXkEVuDhB0xHnSM+BDYBSWnUsTaVLreMZ38=;
        b=Rt5+4G2uoVJboeJghTuW7L7vywSVoxXkyyrI3PGWZtpmyttxLl433W4t/dNn4eHQBQ
         aUg2LG3Y+rzxuNc9cttFgIBBFNGfaE4LcADpGCn+5qRCX33GHJLSvEg7O8AGA70JRMVs
         p/tifF9s5YhBT/3huGuDSbk/x1/zGGPUEZgExqhpaM/S0dU8IWpSgoACpy3Bs++VWvLe
         w4G0816I/Jl80laYKSB0tIuntaRdwKX2V4LD6ikHGUWPESSkMx078D11aTpgu2G1Yncq
         zfcoSYLnuBwi+/xPWtOxbHDg8nfYdkGJ1B0QjVElYtgI9IaKbZ6kunw3ielzeiuSBAwg
         Az8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WQLI+70CXkEVuDhB0xHnSM+BDYBSWnUsTaVLreMZ38=;
        b=BMt4sqbD1kBG8kDJRjF/+ggg6Phx6InFvOo0P2S+ihEy2Q0HEyvHW5por/3dNMiv4f
         b8uFCXc6mJqy1h6TE4U2ffgenbQ5Y14ZN4AqaTxKJc68Hab/L9d5dHTjx8g+R9/TJ/7f
         oMlgSEbe52Gi6EIIinVx6ckpgqPxgUXel6S24n47gBDF8PZ1MPci2N8oaHmfnJLmhJIL
         Qwntp9y9dFLVq7jjaQlBU+IuC1m1V7CO+ekY+c9nOQYS7BUqOaQre43o9o8CWFCp3xkF
         icG4noy9kyER8n3A6y5U0/PDW+VBOmJYHRsNEf9YHlqFt76+uFNWMNwizkftAzF3buTd
         1qZg==
X-Gm-Message-State: AOAM531TZ24V8Ot+/pkYqiCY+0Mf/+YNKE9XZoTwlthxnf0Ww48Z38vs
        paXGVZFARPUOsGIVuKEB9OKHVhlQLaE=
X-Google-Smtp-Source: ABdhPJwoorjpMggYd2NUpqMRBOhWAlCtmDJqqmzXlxvxml7+l+AbDQBMUvvZ1EU2A20igOZKr3LdhA==
X-Received: by 2002:a17:906:39c8:: with SMTP id i8mr1948123eje.299.1601939046472;
        Mon, 05 Oct 2020 16:04:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:414e:4652:8edc:a08f])
        by smtp.gmail.com with ESMTPSA id r9sm673546ejc.102.2020.10.05.16.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:04:06 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] add builtin type pointer to bool: bool_ptr_ctype
Date:   Tue,  6 Oct 2020 01:03:58 +0200
Message-Id: <20201005230401.74777-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
References: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This builtin type is needed for __sync_bool_compare_and_swap()'s
prototype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 2 ++
 symbol.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/symbol.c b/symbol.c
index 7f0c85580f06..d91fd296dd32 100644
--- a/symbol.c
+++ b/symbol.c
@@ -782,6 +782,7 @@ struct symbol	bool_ctype, void_ctype, type_ctype,
 		incomplete_ctype, label_ctype, bad_ctype,
 		null_ctype;
 struct symbol	autotype_ctype;
+struct symbol	bool_ptr_ctype;
 struct symbol	int_ptr_ctype, uint_ptr_ctype;
 struct symbol	long_ptr_ctype, ulong_ptr_ctype;
 struct symbol	llong_ptr_ctype, ullong_ptr_ctype;
@@ -876,6 +877,7 @@ static const struct ctype_declare {
 	{ &null_ctype,         T_PTR(&void_ctype) },
 	{ &label_ctype,        T_PTR(&void_ctype) },
 	{ &lazy_ptr_ctype,     T_PTR(&void_ctype) },
+	{ &bool_ptr_ctype,     T_PTR(&bool_ctype) },
 	{ &int_ptr_ctype,      T_PTR(&int_ctype) },
 	{ &uint_ptr_ctype,     T_PTR(&uint_ctype) },
 	{ &long_ptr_ctype,     T_PTR(&long_ctype) },
diff --git a/symbol.h b/symbol.h
index a3ed95678ee5..47550e032589 100644
--- a/symbol.h
+++ b/symbol.h
@@ -298,6 +298,7 @@ extern struct symbol	bool_ctype, void_ctype, type_ctype,
 			incomplete_ctype, label_ctype, bad_ctype,
 			null_ctype;
 extern struct symbol	autotype_ctype;
+extern struct symbol	bool_ptr_ctype;
 extern struct symbol	int_ptr_ctype, uint_ptr_ctype;
 extern struct symbol	long_ptr_ctype, ulong_ptr_ctype;
 extern struct symbol	llong_ptr_ctype, ullong_ptr_ctype;
-- 
2.28.0

