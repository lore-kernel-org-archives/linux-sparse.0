Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAA1C4363A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A332621D47
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEOehP1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464753AbgJWP6n (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464749AbgJWP6n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 11:58:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0FC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 08:58:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v19so2018921edx.9
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfMlB4S3mZiPHLyKn6AtszlGedoms3PEwvRoA6Jy1wQ=;
        b=eEOehP1m94ltgmfavsDQ81DSAV4ylne8hVRZgyqARz6dgGltIBewWTUGvGaia8rzgz
         0Iq4nC4VSuqMWeDtBV6k31p6V4+OCiDZADbNQZOKilPfxO+etent3XCQVvKn4oMCtDjy
         Xp/hO/VheanC94rVJYU0o+G/fzWzRcwNjx6AnKnq03zsraaiRlW6HZ99hpZ++VRZGJS1
         /rsUSSfr+XxvvhD88b93s+vrLO0+XyLv//nwvS5lYs0YqN7Q6PauVrWuXlgFz/FpURKy
         o+jcLO4HRmpecu9W92g7vFJul0QNDoAVWAq00Ua1tl+eTQQZ0HzuB44iAMAGALJumrzJ
         bLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfMlB4S3mZiPHLyKn6AtszlGedoms3PEwvRoA6Jy1wQ=;
        b=hTzb+NT//bS6ozKETK9Mvbey44awX9L6xUUq3SyNEyQNNUkgqOlVqwrMPdiwUzEAui
         uiaJ0retx6Y1eJspAladPypvWNxvMAmMQ+JfkdMY4A80ishWYnjDwV8J/yMga+DVQszY
         UPnoOWTzbvBx0015nK9XleJMOELTKdys+I8HDVDKPPM++WQaBviAExTGodrrcYtmQDQQ
         DyJPBVxCqf9qlzednNRWr9PsHjv9YoYS8g8vnmY0gN+7CFpCTcaQIO9m6Z/DTDDIgY7R
         N/UC6Xv4FFC8tgsDc1q4wHVfclaOb61pCWFqJHuFxy8ny2oFL6EM+e9Kksb8QaxkCsEP
         KdZA==
X-Gm-Message-State: AOAM531DC/EmWNE5SfXnrpycFGPiDmWypTVam/qDGy7qCW69kONOM1o7
        DOwgGXtO1nwiYe/XjrM0glr1xCKnXIk=
X-Google-Smtp-Source: ABdhPJz22w4UiaSFvZhsO7uTbxgVlC8WLwYKQMNZsymTwOwV4i3RTceLvJ2PjQ+atBIRApkx6b3G+w==
X-Received: by 2002:a05:6402:1a52:: with SMTP id bf18mr2909825edb.125.1603468720021;
        Fri, 23 Oct 2020 08:58:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id y3sm1062569ejk.92.2020.10.23.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:58:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] canonicalize unsigned compares against 0 or 1
Date:   Fri, 23 Oct 2020 17:58:32 +0200
Message-Id: <20201023155832.57237-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023155832.57237-1-luc.vanoostenryck@gmail.com>
References: <20201023155832.57237-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some unsigned compares against 0 or 1 are equivalent to testing
equality with 0 (x <= 0, x > 0, x < 1, x >= 1).

Canonicalize them to this later, more common form.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 20 ++++++++++++++++++++
 validation/optim/set-uimm0.c |  6 +++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 4441b27c7546..96cd73a0a61a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1176,11 +1176,31 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_SET_B:
 		if (!value) {			// (x < 0) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
+		} else if (value == 1) {	// (x < 1) --> (x == 0)
+			insn->src2 = value_pseudo(0);
+			insn->opcode = OP_SET_EQ;
+			return REPEAT_CSE;
 		}
 		break;
 	case OP_SET_AE:
 		if (!value) {			// (x >= 0) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
+		} else if (value == 1) {	// (x >= 1) --> (x != 0)
+			insn->src2 = value_pseudo(0);
+			insn->opcode = OP_SET_NE;
+			return REPEAT_CSE;
+		}
+		break;
+	case OP_SET_BE:
+		if (!value) {			// (x <= 0) --> (x == 0)
+			insn->opcode = OP_SET_EQ;
+			return REPEAT_CSE;
+		}
+		break;
+	case OP_SET_A:
+		if (!value) {			// (x > 0) --> (x != 0)
+			insn->opcode = OP_SET_NE;
+			return REPEAT_CSE;
 		}
 		break;
 	}
diff --git a/validation/optim/set-uimm0.c b/validation/optim/set-uimm0.c
index 1f62358ff0fb..ded8fc827223 100644
--- a/validation/optim/set-uimm0.c
+++ b/validation/optim/set-uimm0.c
@@ -1,10 +1,14 @@
 static _Bool setlt0(unsigned int a) { return (a <   0u) == 0; }
 static _Bool setge0(unsigned int a) { return (a >=  0u) == 1; }
+static _Bool setle0(unsigned int a) { return (a <=  0u) == (a == 0); }
+static _Bool setgt0(unsigned int a) { return (a >   0u) == (a != 0); }
+static _Bool setlt1(unsigned int a) { return (a <   1u) == (a == 0); }
+static _Bool setge1(unsigned int a) { return (a >=  1u) == (a != 0); }
 
 /*
  * check-name: set-uimm0
  * check-command: test-linearize $file
  *
  * check-output-ignore
- * check-output-pattern(2): ret\\.1 *\\$1
+ * check-output-pattern(6): ret\\.1 *\\$1
  */
-- 
2.28.0

