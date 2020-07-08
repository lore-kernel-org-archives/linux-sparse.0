Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B96C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1C620720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfZpvlzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGHXmE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgGHXmE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99981C08C5C1
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so382316edb.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6qSerHAot6Iga27ezvBn9aESRi0lcSfGwZpY7M7ubw=;
        b=KfZpvlzbacjYjr5+6U81gq7Epud6q6In6TM1d7qcYtrQWZFii9tvB/7JAk7jF96EYr
         b/y1b2wJAzZGYGido78Lb/Eoq6jg/n+Aa3ueaJWYBEjh9HFPDm0daGj7CYOdoHp/sq4o
         B8eMPnd7WvSV0cdOXgeaYwh5ARGRxfZA64PAHOUhRKS02dOg0HvSsTYh/zxcR1mKmit2
         RDyVHk5VXe/XhzUAy+Edmw/wmmuAm57RsyLtAn5Rw7qjtk2nmRtRpmp/dMcOFl/AY/H8
         r8YOG1gygfdk0QxGmdGJgoRVKBQwmRyID2Q14gm1JY3qSQAJE7/X/HddXeB9yHnvs4mQ
         Yjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6qSerHAot6Iga27ezvBn9aESRi0lcSfGwZpY7M7ubw=;
        b=dklsGJrLF8h5s6GXPqG2zvmIduo+w8yjtcGo1Qae9zIlz33TjvHL+SsHBQrNL1mHyv
         +0YO04kFASGML8EC5swIitBcXbxTHj0s1nTavDndfUgIrRrF7dZEEt5nsqDWDBHiETzY
         ge3M3vkHgvMy562uXZmo1mrSkM2n8bwUMRx2+i/jB2xAcDzJ4RxI+fMX1OKg+wwS8Hwb
         +pGyOlG/tnMVQKuu63qqjzcNpV3uaPyHA7Qgr3xiI7fxcKHvSHJXbFKy2F+VblzvsulS
         3cy5YbITq8A4seoNTiAhr2ecqqOWb9xje8tviwU+tFyimj1rDJb4OOrqZIecAYnAFtpm
         zb6A==
X-Gm-Message-State: AOAM532YpTVF6dxlaoSh1WAI+q2pN82Ze5HLJennsz+ghT4cBaAOwP94
        ObK4RFRP0QfFEMunYzGK4SYttK0J
X-Google-Smtp-Source: ABdhPJxKIVkalVSO0lwgKKZ373IcYNXZUDcV9G21pUnzgFRcYIOD+BFhMJN+xTPRri/7s4PQSzLxjQ==
X-Received: by 2002:aa7:c305:: with SMTP id l5mr65051441edq.163.1594251720628;
        Wed, 08 Jul 2020 16:42:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:42:00 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] predefine: no __unix__ for Darwin
Date:   Thu,  9 Jul 2020 01:41:46 +0200
Message-Id: <20200708234151.57845-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Darwin, '__unix__' & '__unix' doesn't seem to be predefined.
Don't ask me why.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/predefine.c b/predefine.c
index 0e9f73eb2340..7583b1afc32e 100644
--- a/predefine.c
+++ b/predefine.c
@@ -210,7 +210,7 @@ void predefined_macros(void)
 	if (arch_target->predefine)
 		arch_target->predefine(arch_target);
 
-	if (arch_os >= OS_UNIX) {
+	if (arch_os >= OS_UNIX && arch_os != OS_DARWIN) {
 		predefine("__unix__", 1, "1");
 		predefine("__unix", 1, "1");
 		predefine_nostd("unix");
-- 
2.27.0

