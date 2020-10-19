Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40290C433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A0A2225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuHhPqCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgJSQMh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgJSQMh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E2C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ce10so14717942ejc.5
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bme2c4zWU+1p4vw3BAkOHr93X6SQcXKxu5llH7gC5Yg=;
        b=LuHhPqCCUxVOHZpfLPvdLb51c+4gwLu+V1j1qj6K8Iziwa0Djr1XQOEwaXjg4A3pAu
         pPCvKaKPSV1+U3mEpl5qSwGZyS+b5x4RvjoVrecB0KbOsIeE02sNI/pt1j4hhGwoaMKo
         bb6uDF3+Gm4lMWEuaa6mhg9lS1E3a4Zer+BZHHoMxvlscX4O28n0SIsbQTC1jh0gtofB
         RNJgrBe+PIH74m9PF1J01/om1jGQmPhebBg0KTaZAW6cSX2N7c3k8FGCGRsUt8KUEnZt
         VtlT0ShA4bu9tZIHIqEVwbp7tObomZOGgGB+A7FRWi0+KKwyyUoDHEHqMs2VmYfJVtPi
         jDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bme2c4zWU+1p4vw3BAkOHr93X6SQcXKxu5llH7gC5Yg=;
        b=Y+XoCW0jpyzoVQgrjnn3nhruyNELS1sbJcQ6vMvXaB3asTSnbRBovWXvZEI64bpooN
         y0HTUMmfIAmUsqaQgVZK7cR4BdrZv2gyCmIF/aOEBRubRf6xZs36gYcmXQn7EmSrbS0W
         WUZX0ioq3iMHDFVJXu+6V4Df9R+eAQQcr6EuIfcRszMq1ZbAFncz0KjNYVanrhWttmUh
         i2GbhzrBtbr8lT36+hQYFEGx/yEjqsZuadEcKDX6WSGCTEeaGp6XdJv2n1nHBot8Q1Fe
         4/dtA/C5/Wjq6WJKpOTujkOZ3WdheTphmTAlNSpv140M1cqFO8m/CqLk7hhUWlVVSBr5
         NNAw==
X-Gm-Message-State: AOAM531M6ZlNyUT/oFNAzukL3M9vFaiFQpVCFNH+ppcuKxYzK/QY+Lyu
        SmTqZZb0egGnS9GfOaCUDwN7VhCXrrE=
X-Google-Smtp-Source: ABdhPJza1xoUEkhXHRc+THycMu4ATelKGQ/pUfC+a/kKG1xxb3Z0rnzCxTRQ6iZhbyNZsBu4zDM6cA==
X-Received: by 2002:a17:906:7f8c:: with SMTP id f12mr684348ejr.8.1603123955637;
        Mon, 19 Oct 2020 09:12:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 01/12] builtin: add generic .args method
Date:   Mon, 19 Oct 2020 18:12:15 +0200
Message-Id: <20201019161226.97429-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The arity of builtin functions can be retrieved from their prototype.
So, create a generic .args method, doing the evaluation of all
arguments present in the prototype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin.c b/builtin.c
index 26b612dc401b..0d4cb12cca22 100644
--- a/builtin.c
+++ b/builtin.c
@@ -83,6 +83,13 @@ error:
 	return 0;
 }
 
+static int args_prototype(struct expression *expr)
+{
+	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
+	int n = symbol_list_size(fntype->arguments);
+	return eval_args(expr, n);
+}
+
 static int args_triadic(struct expression *expr)
 {
 	return eval_args(expr, 3);
-- 
2.28.0

