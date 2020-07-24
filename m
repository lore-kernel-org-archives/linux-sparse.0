Return-Path: <SRS0=YII+=BD=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC8C433DF
	for <linux-sparse@archiver.kernel.org>; Fri, 24 Jul 2020 22:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC42206EB
	for <linux-sparse@archiver.kernel.org>; Fri, 24 Jul 2020 22:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0E1ygYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXW1D (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXW1D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Jul 2020 18:27:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DADC0619D3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Jul 2020 15:27:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id v18so3108969ejb.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Jul 2020 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/dAwspncFYiXZU7uD65Gs6na/HtgSP7/OpDgPZwMbo=;
        b=V0E1ygYJYmBo5O/RxH1NVtsNHwUJ2tiKsXWDoiZqcnAHwUMO7lOWwBuI3dYAIaOJTY
         nxm507LUclMS0h5Yop5bK3cSWwhvrwF/soIo6OBYhW6dwVDKwQ190cf2Otm79UsOumiI
         j+/lu+W7Sr4+ibsatZjwVBrQanAW5qSbQKxXAbn1DPG4UcY7pAd1x6uJ9S4Nzh3MsNcX
         E+LEvfXt7cP5oOjoAAC8KUE14vKfN2I4LDiTqIKPdTSPmHX2yMts0604MCgkx+fkYotv
         S8tK/Y4cFigXI9zNwGWvK2qJ1HVsESmgF5Ji/jdApsV/FSahG5fZasT8xfo5qG87fPaw
         Jqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/dAwspncFYiXZU7uD65Gs6na/HtgSP7/OpDgPZwMbo=;
        b=O/msXnkw947uM09N7iPMpM03Vk0zZ8yc9OVIKcSbpV5TLmqSWGErb/uifgWCVlz/gg
         7kSjOQ1c5wf/VRw1vbdwjHll1muVX8rTYOowWbgTjX74ld25zlHzOiLFhVAcxSRHkXQA
         RnDBjmI0s7jNDzahOyDZjfREyPHhZhbFIKn+E/dtOOeNVlD7nCoDvOeweNtq2GVQT3QT
         OdPTc8uaHmT4N5+XMP3NADKIbiEroabuYEWWCecDs4moDlTo842oc+zRXOXohtIIuRLz
         ehO3c7AP5k45gJfzmT2wsvaBahN2BGFLOOoQyvViUujTnW6okmZV+voPlgrGNGSaVxej
         nz+w==
X-Gm-Message-State: AOAM531yXMwX1e+3O9xFGY+lxtcD/IflbHhIg5Yb9XXWfhEGqUtKOvQw
        fjngJJfyBlq/2Om7h2QNJ1QmLYVK
X-Google-Smtp-Source: ABdhPJx+glPUXBy+FKUM+9aF24lTyjWzi/wcSry6RxYDFGPwowQjBWLzojeAEueqULhGZeAReax1HA==
X-Received: by 2002:a17:906:53d4:: with SMTP id p20mr11105486ejo.472.1595629621516;
        Fri, 24 Jul 2020 15:27:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:c8e2:c87d:48c2:d0ac])
        by smtp.gmail.com with ESMTPSA id m20sm1491140ejk.90.2020.07.24.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 15:27:00 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] generic: fix missing inlining of generic expression
Date:   Sat, 25 Jul 2020 00:26:54 +0200
Message-Id: <20200724222654.43141-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Inlining in sparse works slightly differently than what my
mental model is: the body is only evaluated after the inline
expansion. IOW, an inline function is not evaluated until it
is effectively inlined. That's fine but it means that generic
expressions also need to be handled during the inlining.

However, since the body of inline functions is evaluated just
after inline expansion, so (recursively) copying the expression
and its type - expression map is quite useless here.

So, just copy the expression itself and its control expression
to 'isolate' them from evaluation, evaluate it and then just
copy the selected expression.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 inline.c                    |  8 ++++++++
 validation/inline-generic.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

This patch is also available for testing on sparse-dev repo:
 git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git gen-crash

diff --git a/inline.c b/inline.c
index a959728013f1..eceef8ba0443 100644
--- a/inline.c
+++ b/inline.c
@@ -274,6 +274,14 @@ static struct expression * copy_expression(struct expression *expr)
 		}
 		break;
 	}
+	case EXPR_GENERIC:
+		expr = dup_expression(expr);
+		expr->control = copy_expression(expr->control);
+		if (!evaluate_expression(expr))
+			return NULL;
+		expr = copy_expression(expr);
+		break;
+
 	default:
 		warning(expr->pos, "trying to copy expression type %d", expr->type);
 	}
diff --git a/validation/inline-generic.c b/validation/inline-generic.c
new file mode 100644
index 000000000000..1f05c07904b5
--- /dev/null
+++ b/validation/inline-generic.c
@@ -0,0 +1,10 @@
+extern int a, b;
+inline int c(void) { return a++; }
+inline int e(int d) { return 0; }
+inline unsigned f(void) { return e(_Generic(b, int: c())); }
+static int g(void) { return f(); }
+static int h(void) { return f(); }
+
+/*
+ * check-name: inline-generic
+ */
-- 
2.27.0

