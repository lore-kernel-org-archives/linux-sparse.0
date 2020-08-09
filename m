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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E226C433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16135206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGf/B7/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHIORn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHIORl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 10:17:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2EEC061786
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 07:17:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so2484142ejs.8
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyH1x57reXpzJnCyTr9Yv867+dI1WVPFqwezGVLbo+8=;
        b=BGf/B7/AijCL6iPLZWWeexhCf1qcxKPulMTS3M+KqsOMj68gyWOW2++NKHjPh8L9wn
         4IF25Fgk03KmZ7gzK+o+8SUqHFeZOM5qPq4OAtULsoizRETFwf1HSXJvNVnHr5SnZh5e
         IFHVuv7r4sE9eiyRSC9xcKn82Eh0zhQoFV47Tx3dksvbPGKETe/rXPX7qwY9R7dUH024
         ehRu8aZADr/PZsV949dDVvpT/4QXDScm2TKvA5PSMjgYm68B1krGZUgWBu3nZCxt9osS
         q2oC/jpPNOeyDkp4NDBFGvCNi+TsLJHBQdt4feN1TyDP29cQ0YpX1Ba9Jqp6+W9p8ucR
         IfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyH1x57reXpzJnCyTr9Yv867+dI1WVPFqwezGVLbo+8=;
        b=W0mxe8uVtuBGLiJl0Arv6adImHlJyZx8ImYA1h2LLQVyZk1t1U5TeXEiSYGH3qlDRk
         xxfeG5g0vfPuub+LviwJyoVoqyead66pEYKSF4jFsqwoNvQjWI1/f8iVr/iDuUxnhZYM
         WbiGo7x3T1wGpWnOkOupLac7UP4Pw6ll9VP6KF35F3XmsqEn0Doj5sSQPFg2GPHRJmbr
         c6Ta8PXynTz+yK2Ryw68h4eKDLqhtquNaA4G2mGyl6/Sha1cL8MWoLAqWjiQz0pqXmTi
         340msXTHel4C2eFQ/2ciicwBYTFMAE85FEIuQLfCrfJ6vgjBZDApQ2OWT0WAo8hTHhhq
         2jKQ==
X-Gm-Message-State: AOAM5309Mtur20G84BzdygGylpsqM2vwbGqEtMLLA4dqFmVhcyBCI9WM
        isGfDiLDQiDz0Cu75xOcZEWsB2iR
X-Google-Smtp-Source: ABdhPJzwnP5pJOQ+EisOvjhB6akqNgqdmAcGYZF4NiQX+/1OJXJRTnO6kmZuzWPuC7ge5yJNF+Qn/A==
X-Received: by 2002:a17:906:3790:: with SMTP id n16mr17595543ejc.256.1596982659931;
        Sun, 09 Aug 2020 07:17:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:788a:816d:ff27:8087])
        by smtp.gmail.com with ESMTPSA id p1sm9917956edu.11.2020.08.09.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:17:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] doc: remove link "edit on github"
Date:   Sun,  9 Aug 2020 16:17:30 +0200
Message-Id: <20200809141731.32433-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
References: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

since the development isn't done on github, the link "edit on github"
is useless and confusing.

So remove this link (but leave the one "View page source" as it's
sometimes quite handy).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/templates/breadcrumbs.html | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/templates/breadcrumbs.html b/Documentation/templates/breadcrumbs.html
new file mode 100644
index 000000000000..4f22fa9a8163
--- /dev/null
+++ b/Documentation/templates/breadcrumbs.html
@@ -0,0 +1,11 @@
+{%- extends "sphinx_rtd_theme/breadcrumbs.html" %}
+
+{% block breadcrumbs_aside %}
+  {% if hasdoc(pagename) %}
+    <li class="wy-breadcrumbs-aside">
+    {% if show_source and has_source and sourcename %}
+      <a href="{{ pathto('_sources/' + sourcename, true)|e }}" rel="nofollow"> {{ _('View page source') }}</a>
+    {% endif %}
+    </li>
+  {% endif %}
+{% endblock %}
-- 
2.28.0

