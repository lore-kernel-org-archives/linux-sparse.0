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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF788C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7881422276
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTI/w675"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgJSQMq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbgJSQMq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2346C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a3so14660092ejy.11
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6STfh1QtZTmwM7DfFK1cWkmVmSNUlE4JxjQqf1gcvI=;
        b=RTI/w675h5+5OP9KHOT2azo6lYSsHDybUa5wzhvMta+14CzEvN6aXso14RylJNZtoj
         x7GGiJ4dlpaWCrSJXZatoUgRcKvgwcsox1PAWFMqziMTTDOt/vAkZCpcXyDSpu5ub8ht
         29xY4Xq87CaawVVcpfWSfbUcynaOHQ/Y2FZV0sygWlhCf434sM8IPm16QupXP1zNI+Mw
         FnBz4Zpqn6ZnjahPotiPY+bBw8X/EBoT2PxlP99Z+S9dVeXZUREzQ1N5VQnq8uh9h2Kf
         XITrRQ3LVjJclswiZH4+GPzIrS7qM6A+vv4u/QQ8DKHCgsdw/b2zpYggBRypBDKuCvJV
         ZJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6STfh1QtZTmwM7DfFK1cWkmVmSNUlE4JxjQqf1gcvI=;
        b=VvyhTgw0+KWUHtVfV7VVX2nczKuihdo+jOGKAmBpWb35huOqFbb9C7N8GBa00yCHl5
         VIhP4KmtOFMqTP8AH42NBhrW6/pWJy2fbeJCMQn75deH3m9419rssStiyujR3YBVsq+N
         5yoUt/V1hsZrBZX6DwnEwz5J6LoLfd7HscS+j0lLRvX2B6ElNYvnnLVe48uWc6QFr433
         /OYeZPM24N/Nt0Vk2Fh33TcWKFV70puQfHqvnOWOQJnTQE0yMpgdJXFQt6IqtY1Bj7JL
         vscJw8aBPy8trex3nNsq3ijeSK7+YZYTPNRqyvLD8tiPO+0nLtw/FTcGs0eCL6eHZcvN
         EBwQ==
X-Gm-Message-State: AOAM533s3+t4f/d3VjRZVomkhBpSF/PmhdCP2f8aUTcerfuNZEbVB/ff
        haQthtv5OH3vrEZQ7MUwsUTGD2b+PZw=
X-Google-Smtp-Source: ABdhPJwJ1Dc0AubGZ1ENuyKoBt5k0ouh1lr6I3I2o3B0kppT/uwo37dHwXsrRcrS90nNnkJBNDGg9w==
X-Received: by 2002:a17:906:a149:: with SMTP id bu9mr602027ejb.115.1603123963005;
        Mon, 19 Oct 2020 09:12:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 10/12] builtin: add builtin type: [volatile] pointer to bool
Date:   Mon, 19 Oct 2020 18:12:24 +0200
Message-Id: <20201019161226.97429-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This builtin type is needed for __atomic_clear()'s prototype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 3 +++
 symbol.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/symbol.c b/symbol.c
index ec514eb45df4..5d4f078b3444 100644
--- a/symbol.c
+++ b/symbol.c
@@ -806,6 +806,7 @@ struct symbol	const_void_ctype, const_char_ctype;
 struct symbol	const_ptr_ctype, const_string_ctype;
 struct symbol	const_wchar_ctype, const_wstring_ctype;
 struct symbol	volatile_void_ctype, volatile_ptr_ctype;
+struct symbol	volatile_bool_ctype, volatile_bool_ptr_ctype;
 
 struct symbol	zero_int;
 
@@ -912,6 +913,8 @@ static const struct ctype_declare {
 	{ &const_wchar_ctype,  T_CONST(&int_ctype, NULL, NULL) },
 	{ &volatile_void_ctype,T_NODE(MOD_VOLATILE, &void_ctype, NULL, NULL) },
 	{ &volatile_ptr_ctype, T_PTR(&volatile_void_ctype) },
+	{ &volatile_bool_ctype,T_NODE(MOD_VOLATILE, &bool_ctype, NULL, NULL) },
+	{ &volatile_bool_ptr_ctype, T_PTR(&volatile_bool_ctype) },
 	{ NULL, }
 };
 
diff --git a/symbol.h b/symbol.h
index 97c608e84704..5c5a7f12affa 100644
--- a/symbol.h
+++ b/symbol.h
@@ -311,6 +311,7 @@ extern struct symbol	const_void_ctype, const_char_ctype;
 extern struct symbol	const_ptr_ctype, const_string_ctype;
 extern struct symbol	const_wchar_ctype, const_wstring_ctype;
 extern struct symbol	volatile_void_ctype, volatile_ptr_ctype;
+extern struct symbol	volatile_bool_ctype, volatile_bool_ptr_ctype;
 
 /* Special internal symbols */
 extern struct symbol	zero_int;
-- 
2.28.0

