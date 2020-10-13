Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CBC2BB1B
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70E9206E5
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7A2prti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgJNJXh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbgJNJWy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA1C05BD3B
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so1167060edb.12
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbAirURmOvj5zygsmPy4YHXzK62TeOuUF2v2C5vMZyY=;
        b=G7A2prtiO0pPNSyAF8aKelZ87o7z0S/49Aum3U/wMNFbzbrKazKxeKLs+0q0EkRAXc
         MbBNsMaw1ZXcksTm76/eyebNroDKn42sKrX3pUZ/Mln80GEWR67i8mtYrOBWL65+/vOc
         mK8UNCcHrpPuYKu0XkqrCntJqajcp1/Ms/XzVqotoi20xMQC9nYcH/ESwQ+wrPbe1XX9
         LLgmPsn8Zv4/DBk3TYKb/M09VGv5YV1NivCPrpk+tkW2I/tzmDr7+V0EewtmghP50PZY
         p5xeI2k3IsErsjZN4or6U/pBaFNMYuY1X4WD2BmfyxCs8vWnixl4SqjqK/dNYmfrotLW
         lokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbAirURmOvj5zygsmPy4YHXzK62TeOuUF2v2C5vMZyY=;
        b=Qou+Uf9gumrDhPqn+hnY2IB0wtAvu1h962dOKzJVNk6hhQGlEFm0RxZngQLQwbgUlv
         m7apQb1yfTEomo+C6rOIlFPlfpFgXw7GLvVWHdCG9OIs2ygq9dWm94goSIFYCm0pVrqB
         G8NWuT0AVXCbla313Wo5wdIkDc8qzOoaOjvxGQS0TmZNWEbwxnafWR7ohzvQ5KfWmoj+
         LIO3hz/dFUavF2XUOWHDZwZQj1luE+C4TnMclA2/jp8DMvgD2C9ySQvhZozD3yFcFeo/
         NZpavh1OKCQFf4fdC/XtUCQxdPohR9G3AevRSGFVpdaXZqj+pH1SRrwcDLbsChMFI+sE
         nj1Q==
X-Gm-Message-State: AOAM530OtdHUvCM6vO9i3slmhsWruYK9mwtuH9EBNei9qtIFU94rnvlv
        v8S8BHCW0NXj5CjLkzD3atuB8/XiNjI=
X-Google-Smtp-Source: ABdhPJyOloJ4ZO9fHoxRRVsB+BGF3Fm13ZTPCPGgzUfWc6D3miZZFJhUmXD6+crWI1GxT6zmNDL6OA==
X-Received: by 2002:a50:ab86:: with SMTP id u6mr2185205edc.158.1602631364234;
        Tue, 13 Oct 2020 16:22:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/13] format-check: merge 'fmt_string' & 'string'
Date:   Wed, 14 Oct 2020 01:22:22 +0200
Message-Id: <20201013232231.10349-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Those are 2 variables for the same things. Merge them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index fd5a9ed821e1..99a36c8eef5f 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -524,7 +524,7 @@ void verify_format_attribute(struct symbol *fn, struct expression_list *args)
 	struct format_state state = { };
 	struct expression *expr;
 	struct expression *init;
-	const char *fmt_string;
+	const char *string;
 
 	if (!fn || !Wformat)
 		return;
@@ -540,16 +540,15 @@ void verify_format_attribute(struct symbol *fn, struct expression_list *args)
 	init = expr->symbol->initializer;
 	if (!init || init->type != EXPR_STRING)
 		return;			// not a string
-	fmt_string = init->string->data;
+	string = init->string->data;
 
 	state.expr = expr;
 	state.first = fn->ctype.format.first;
 	state.arg_index = fn->ctype.format.first;
 
-	if (!fmt_string) {
+	if (!string) {
 		warning(expr->pos, "not a format string?");
 	} else {
-		const char *string = fmt_string;
 		int fail = 0;
 
 		while (string[0]) {
-- 
2.28.0

