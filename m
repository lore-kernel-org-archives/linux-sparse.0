Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E201C433ED
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502716135C
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbhDLVVs (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbhDLVVq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A9C061756
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx20so15631041edb.12
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7viAuovfFnmrqFKiDenn6AEET5zy1s11tBohzUeWfCk=;
        b=icAnPDIYN1u4XLPGHYYFSQhfOWXUSlSwMHFkOrHWXV+v04MXGmgGdhCYPfvAvBn3Xj
         gOTgI0ggI7xunZ8aqFVogt2AFftNlPW6o5/0MzC6veKoowsmPF/D12eXOPdo93HubMNT
         NeezVsq9Vg9O33/Kp1vr96u60L8u2FemstwfMWWqGj6IBgno+GhkwX1aEsL85DwIO5el
         Af/V0B/yQ5jL/rACxX/0B8DrWyEK27iY6WS2/zreHLjhRs/zFa15ZQ6jJqSePO5lhGU4
         lYifreWgRNaJHCEINd/dklXEM2SNjX+HkMYYI9mFNyyOVotKFPQUPBLDQ2YAPlgp11bo
         jXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7viAuovfFnmrqFKiDenn6AEET5zy1s11tBohzUeWfCk=;
        b=ABGhciwRXwHLCWHyyJLPM4TMIz5SIKCJeNrVk27UJXyHR5936PYhBnlEPQ88jUHa9P
         iYlAsOGTXdTml97KBXWWBwNHmYHUUJJlNwsU57Iqenm033n8Zcet+NXUgpwLSkhRc5Bj
         9Fk+1mqEk7YPGHOnr0uH6cj+S+QENP/xeVw0KSCwnqR9y9dl1X8i+/5f/+DU626BvD0u
         xbK5QjwpVcTI6tphrJ/pVGhZDoOqGPHio75Bu6VYdVeGK0qrdsli4xU/3Q7XCbv0pIg9
         zZeVrw4R1Ztn3Iice+Y5RH7WsqTTPstFWTLyIgbU/v/HnXdOUwFjDOujCh/jjYaP8u79
         m8Ww==
X-Gm-Message-State: AOAM530yQ91i+vDOgChS5c9i/eAyUjWgQ3X0aDQLUJ6comeyBblLfmqm
        pqPvWMyoWJcxn1dhxi4Tv6dIydK+Hn4=
X-Google-Smtp-Source: ABdhPJzX4QQalnrVO18slVdgZbpji7CJ8Y4OpLGZxr9okFXIR7QPdz72u+sjXSshyZtqnGCf7NANuQ==
X-Received: by 2002:aa7:db9a:: with SMTP id u26mr30764537edt.292.1618262486189;
        Mon, 12 Apr 2021 14:21:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 6/8] scheck: allow multiple assertions
Date:   Mon, 12 Apr 2021 23:21:09 +0200
Message-Id: <20210412212111.29186-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

With the SMT solver used here, by default, once an expression is
checked it's kinda consumed by the process and can't be reused
anymore for another check.

So, enable the incremental mode: it allows to call boolecter_sat()
several times.

Note: Another would be, of course, to just AND together all assertions
      and just check this but then we would lost the finer grained
      diagnostic in case of failure.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scheck.c               | 5 +++--
 validation/scheck/ok.c | 4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/scheck.c b/scheck.c
index c64e865136c5..efa5c1c3247b 100644
--- a/scheck.c
+++ b/scheck.c
@@ -252,6 +252,7 @@ static bool check_function(struct entrypoint *ep)
 	int rc = 0;
 
 	boolector_set_opt(btor, BTOR_OPT_MODEL_GEN, 1);
+	boolector_set_opt(btor, BTOR_OPT_INCREMENTAL, 1);
 
 	FOR_EACH_PTR(ep->bbs, bb) {
 		struct instruction *insn;
@@ -274,8 +275,8 @@ static bool check_function(struct entrypoint *ep)
 				ternop(btor, insn);
 				break;
 			case OP_CALL:
-				rc = check_call(btor, insn);
-				goto out;
+				rc &= check_call(btor, insn);
+				break;
 			case OP_RET:
 				goto out;
 			default:
diff --git a/validation/scheck/ok.c b/validation/scheck/ok.c
index 76c04c4f6870..f4a0daabfe9a 100644
--- a/validation/scheck/ok.c
+++ b/validation/scheck/ok.c
@@ -1,10 +1,6 @@
 static void ok(int x)
 {
 	__assert((~x) == (~0 - x));	// true but not simplified yet
-}
-
-static void also_ok(int x)
-{
 	__assert_eq(~x, ~0 - x);
 }
 
-- 
2.31.1

