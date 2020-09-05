Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEC6C433E2
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0256E2074B
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBOlTF6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIELM3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIELMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 07:12:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0FC061244
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 04:12:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so10741417ejb.1
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=418VP1+1t5fc4HhZsGx+u9DZBLjOWfYxJXcHSQhE0bY=;
        b=tBOlTF6OOAh5jgOPtFUt/SXximaztvoIYruABcacBkqI1Y5qZGD8IEN8FgLSCHsAOU
         ZNfyt9sfzxmlIkFn5jHTFs80xYYrpRF5ykufBnwSKAPKjRFKXCAnYJj+wOSpr50zdyYs
         +8f+SJSA84uXMrrMXqOot8tkFrY2Ci++Tih1YRVvoXrEXsitWfTwdPA1nqWk+UE/eZT6
         u8sO3TQN1jACpv7oVCwOL5sO6gKS6ZFdnWyPL9v7dIckPuSyMP0dXLDM4YEATZxxYy0U
         S4DlEyKIiur5Or6PJ/HLM9DDq27053rpNeLVYiDisgF4mG1UdIUJT+DKWwS6g+ogtoIQ
         KuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=418VP1+1t5fc4HhZsGx+u9DZBLjOWfYxJXcHSQhE0bY=;
        b=pJDtzmB0/ZUGVC9AdWJS4NwP7z+mORxIMZ7c4O/eMo6PwPAmKk6zAgi8AwZ3xBRLK9
         /fEqlo21HEXMrVwzsWDoYQY9nTkTSK2/HGvejLYaz05yA1ySW1guqtPfH8TebYK0kPgc
         830bEesTWVotiNERQi2GaSjqbJhCjL+TVEOj978VHsYK9n6eOighSgjtwX08WKRdglq6
         7jNYbZp6ItfatlwFXWNVv5qyMzwTGyKMriU94BvDa2ymHFHcmilDNVMEbwJujlw6wFwb
         sxbK8OQvzGGeYfrbvRarQKZWnMJbIc5VfM/9K8u/PVoO1DEm2ccV5lrh+Br/Gbey6g9j
         r6+Q==
X-Gm-Message-State: AOAM530C+Eh84VedKZKE2qykeN/vd5KWCbbYNYjIXcRn/qOtlm16F2FT
        3T5a3U9Br7z4ExYEOs1VsM3qVUlH8d8=
X-Google-Smtp-Source: ABdhPJwO6h+fG9C41O5reX+0NEhoVDm6ZlLvG8ByccyQiDbE62nZpgiGQY7i8uuStKgoC2UtAVw5ZA==
X-Received: by 2002:a17:906:3053:: with SMTP id d19mr12510900ejd.190.1599304338714;
        Sat, 05 Sep 2020 04:12:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id u15sm8319506edj.69.2020.09.05.04.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:12:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] builtin: allow linearization to fail
Date:   Sat,  5 Sep 2020 13:12:09 +0200
Message-Id: <20200905111211.82199-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
References: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Allow the linearization of builtins to fail and continue with
the normal linearization of OP_CALLs. The motivation for this
is for the linearization of target specific builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1a2677713123..bf55045bcbce 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1513,8 +1513,11 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	fntype = fn->ctype;
 
 	// handle builtins
-	if (fntype->op && fntype->op->linearize)
-		return fntype->op->linearize(ep, expr);
+	if (fntype->op && fntype->op->linearize) {
+		retval = fntype->op->linearize(ep, expr);
+		if (retval)
+			return retval;
+	}
 
 	ctype = &fntype->ctype;
 	if (fntype->type == SYM_NODE)
-- 
2.28.0

