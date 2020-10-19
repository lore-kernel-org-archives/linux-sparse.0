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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161B5C433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18612225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCW/4DxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgJSQMm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgJSQMm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFDC0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so14706105ejg.9
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzbwhgM1b2KZznlK+JCIHyQBOKMQ8o5rvF04A7Pc4Js=;
        b=XCW/4DxZzWvUgbbU6WFuAUMVdZlJIpstAtfctBZ8p2NW5v6cQG37IMgXiOR8kBc2u2
         XEkr+SGmcxNcw5BOWMJvv3X8xPWxmJN4aaDIQjpqf6wQpYni96+fobGuhainHhF2SZHS
         vcPSOoOfU9UienfsgLvr08iWVh2BrdMR4MLzUdRqzY3h5Xge/UsZt3w0U8O6Q2nTbx9+
         rYxkeD3sE3ciYf4CNN8WcQaQSeDs6CLp7xWaJ27SpzOCJUUlfcJf6RrtXpLeSw45Kfob
         WorV1I6tVZOn4Y5LMPhowo7b228HCKAWcd4LZZNUpIE1A855eOnPbtIWHq9L4B9j3NiD
         ca7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzbwhgM1b2KZznlK+JCIHyQBOKMQ8o5rvF04A7Pc4Js=;
        b=p/WEa7IbOOw6CPpUuNV1uYt/STIFWZkAzlrX7LiMyxwrlnEwK3CRIJjXu4q3RzT6Kz
         ppFa9QyA7TpMeZOxG4x0WB5Az84CPTeHKA02xCoHgyPl0UHtwv5FwlbPqZC9q2DljvaY
         jAuS7k0nGrQnzaGuLMBU2P7dPwqDss/CnzKc4tZHDypMGY/3BFdJH6DEr6inXqfoSOqg
         odB47WWcoFVCgI+SVyT1DT7EROB+qmsoT+JuDx5w+RTcLsUQ/wxXOyU72PQpvE9tvOiN
         LwO+VXIflrYaUCDk2cgySxn+YVxgEYBmFCs09n67G5k9cdRK3iQeF4ZZ0j1tKmiulWoa
         V6bQ==
X-Gm-Message-State: AOAM533ZZ/RvEUilhwDTTjHjgHWxeFwKFUGvvwqwc8a/9/adFH+WwhNw
        ObFMn/Vbun83mw70jKztXDr/5JyZTjk=
X-Google-Smtp-Source: ABdhPJwTADxhm9nBS53gzQGkV0zTKbMCBtmrSVUYvmkBbQ7eYqGp2fKhp75J6ZWdfqJMay1tAzbnDw==
X-Received: by 2002:a17:906:fa99:: with SMTP id lt25mr556923ejb.511.1603123960550;
        Mon, 19 Oct 2020 09:12:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 07/12] builtin: add predefines for __ATOMIC_RELAXED & friends
Date:   Mon, 19 Oct 2020 18:12:21 +0200
Message-Id: <20201019161226.97429-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The __atomic_*() builtins take an int argument to specify the
desired memory ordering. The different admissible values are
predefined by the compiler, so do that too for Sparse.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/predefine.c b/predefine.c
index f898cdfa39b8..98e38a04579d 100644
--- a/predefine.c
+++ b/predefine.c
@@ -179,6 +179,13 @@ void predefined_macros(void)
 	if (arch_target->has_int128)
 		predefined_sizeof("INT128", "", 128);
 
+	predefine("__ATOMIC_RELAXED", 0, "0");
+	predefine("__ATOMIC_CONSUME", 0, "1");
+	predefine("__ATOMIC_ACQUIRE", 0, "3");
+	predefine("__ATOMIC_RELEASE", 0, "4");
+	predefine("__ATOMIC_ACQ_REL", 0, "7");
+	predefine("__ATOMIC_SEQ_CST", 0, "8");
+
 	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
 	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
 	predefine("__ORDER_PDP_ENDIAN__", 1, "3412");
-- 
2.28.0

