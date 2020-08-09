Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE83C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC50C206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivaNQ3sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHIORn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIORl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 10:17:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF96C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 07:17:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so2484115ejs.8
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tihCaIaZ8hO8FrGKsGmEVleU+9e1Nh2kqy6MJhKG7B0=;
        b=ivaNQ3szIjcJwCQtSIPpQFimUWq15bm6Q+6zErXOQcYomcPHIVxKP2LHaWqfweTzkG
         JJojF4HevIAi43s0vS/PXO8DQQBNjumY7MRBByd4qhYSlyHXoDcW4CyOVV5LvVF1sBMa
         t+iFurLDDhPQsVUyYyNaKlSQIOfFJKXBsi9GnODhtV71MDZfvFO61lSZEqKQj5A1W5Gx
         71xcjnMaGfL75WiZhAxE6I734R+sb3r+fA6U6D8Ai2eXsWCQncyo2X8zcwIlsdItGS2L
         McjE46gfs/uVgXSlODh/BJ0gcS8KZQwniMaJN15l+y46UNX6Q8HPJJOokYLcauDiY6sl
         Ko/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tihCaIaZ8hO8FrGKsGmEVleU+9e1Nh2kqy6MJhKG7B0=;
        b=LzNJTvXT9XWF9zH9v4vq1NH/H+WkeTfVu0qMKKCsxZgkwDGRRrW0EPgiYpiIraretH
         M9ssC4awyrVX3mSBjRUY82HMgzxbzcvaCbfeUqft8mtL4DD1RykN04Ls9rPxeFOS5CfO
         JENG0AzShPQKz5YiSWv6/hem3cAREtbmjxYGbOBfIb3lmgvyhNIYFWU6Srx41qKNWomX
         PnLlWIeO8fRwraWnnvlg6srM4S7ym3K2TgaJ6+gC6hisR28eQUQbClymPMhY8UAvTTgT
         f4+QVWy+q1OdwoAbQSnTTiCEA7CIkXBVXcv2+8rb9jPrZ65cmq5Cx62f9L3ZbKknshZH
         PKqA==
X-Gm-Message-State: AOAM530NnLaFm4IpmA+tSKSGltXQZwOMyUGev97zMqBqdDDU+Ual5qDr
        PTQQv0AR5RUX9ka3BKbAQ7STRieU
X-Google-Smtp-Source: ABdhPJwTnh2ZL92U9IEH0XNcZ0E/Sknse7xQso6mTCsYXDCMNXrscOrW429HVOxZAtdKxqtFhMiwRg==
X-Received: by 2002:a17:906:9512:: with SMTP id u18mr15960602ejx.207.1596982658966;
        Sun, 09 Aug 2020 07:17:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:788a:816d:ff27:8087])
        by smtp.gmail.com with ESMTPSA id p1sm9917956edu.11.2020.08.09.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:17:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] doc: add index to the sidebar
Date:   Sun,  9 Aug 2020 16:17:29 +0200
Message-Id: <20200809141731.32433-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
References: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It's very useful to be able to access the index from the sidebar
but no change in the configuration seems to allow this. Trying
to abuse the toctree give the same result.

So, add it directly via the template system.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/templates/layout.html | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/templates/layout.html b/Documentation/templates/layout.html
new file mode 100644
index 000000000000..a2fe215fcef6
--- /dev/null
+++ b/Documentation/templates/layout.html
@@ -0,0 +1,8 @@
+{% extends "!layout.html" %}
+{% block menu %}
+    {{ super() }}
+    <p class="caption"><span class="caption-text">Index</span></p>
+    <ul>
+    <li class="toctree-l1"><a class="reference internal" href="{{ pathto('genindex') }}">Index</a></li>
+    </ul>
+{% endblock %}
-- 
2.28.0

