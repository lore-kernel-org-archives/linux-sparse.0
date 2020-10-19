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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8FC433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88078222B9
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwfGD8E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgJSQMo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbgJSQMo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90AC0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so14711048ejg.1
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBIQahuootBfc+53j4kb8jBk2e2ASbGt0urdB684sQ4=;
        b=SwfGD8E0igTlEvETMIQo0cuHDn6uE861ZzNL8xBkboPEXe1aaEtmIJxYZAg2uBctz4
         xzwlhAycywACBpOBAvXKpN5GPWDwJdKAgV7rBQBUAV0Ap75YXk4JTMp6yAHlFVjoPdNj
         olZsv1mTZQEViD89hnN7GXOpJFsnUDY+nbLc6oob9OPz7RSNfgIUIHxAq92e6dsmJ1vw
         KHngGw9PUgFTcWKXFMNEP8jG0I5j2dkKqJBtfXnDOIHx7sUhvRWM5FI3A41tFZo1KnNb
         iZ5y/sq4pR7watN8VedSdOoi1so0danVepvF3swePbqQILRYF6Y/pusxNJkNmUcMX3xM
         SF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBIQahuootBfc+53j4kb8jBk2e2ASbGt0urdB684sQ4=;
        b=HuB3FBbflq4mLO1o7ARl9/z+v+I0RJ7d8Gvgu8mjEx1U2Vpgj5bSGzLlVS+K46iiPJ
         O87d7V8GDnXua0p1MZosRLBz0LYyWzRdbt23dNqzid3RglwgARDk/Wl5YM73ThsJ9hPM
         zs2lePkunysLwRu3NqR3BWow9copSAYYov4F56+zjIZEUNu0F6vHcEN4YJDNtaBolXk1
         BPfBNemyoibEs5G05KM3Ftv+0NmCkFG1mf7Hjnhuyx4L3kXCi2/AUg3hso91xyalIGn+
         fwsMlLmGTypPR1gT4X1izfwoFJaPUtPAsLOF4aRBIkPe7jxhGTW5cbpOQ53GRbMZOk63
         X20Q==
X-Gm-Message-State: AOAM530H9iF+PlutMGum/rPDTRo98glrhnNIkg2biTeziDmo2eKb/Zaj
        joT6OYPyYBICicfAflgBHWxI0/LXrsw=
X-Google-Smtp-Source: ABdhPJzxF3eTdMS7BWQGhodFBNg5NR05Hq/jqssyZBrml5KOH6E5ngd0mdaF7OB2b3WilQ0iBby+ww==
X-Received: by 2002:a17:906:a1d8:: with SMTP id bx24mr593709ejb.161.1603123962224;
        Mon, 19 Oct 2020 09:12:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 09/12] builtin: add support for others generic atomic builtins
Date:   Mon, 19 Oct 2020 18:12:23 +0200
Message-Id: <20201019161226.97429-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reuse the generic method for all these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin.c b/builtin.c
index 6573c1deb686..1a95018c7699 100644
--- a/builtin.c
+++ b/builtin.c
@@ -409,6 +409,8 @@ static int eval_atomic_common(struct expression *expr)
 			t = ptrtype;
 		} else if (is_dynamic_type(t)) {
 			t = ctype;
+		} else if (t == &ptr_ctype) {
+			t = ptrtype;
 		}
 		add_ptr_list(&types, t);
 		NEXT_PTR_LIST(t);
@@ -481,14 +483,22 @@ static const struct builtin_fn builtins_common[] = {
 #define vol_ptr		&volatile_ptr_ctype
 	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_compare_exchange", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_compare_exchange_n", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &dyntype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_exchange", &void_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_exchange_n", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_add", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_and", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_nand",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_or",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_sub", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_xor", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_load", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_load_n", NULL, 0, { vol_ptr, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_nand_fetch",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_or_fetch",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_store", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_store_n", &void_ctype, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_sub_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_xor_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
-- 
2.28.0

