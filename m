Return-Path: <SRS0=D4es=BS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63028C433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439A020716
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS/wQlqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHHQMD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQMC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:12:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7CCC061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:12:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g19so5140482ejc.9
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gGvYsYI7pAIHGRHTOtfrbaAjnfrDtx4Jcwk5RW42xw=;
        b=CS/wQlqDwKom+AMhzrJN3Aw3Iy15pY6vtUrypWeSM+my1pSdJRqjvyZNvUFOQRmHBT
         VGQq0d0yBjazwiDaZM1hGpaKayg/vJrWeddBGZclB7U6FbfeMDWOjm1rUp2mVjd8srY0
         fqAocssn+8o+W/w6hI30VTme54xg7g28+WnGO/D226P5PB60cERVN4pFUSBVNdlMMryQ
         dJYTEIvjBGsxQm3JCsg1ArYn6q93aBl1K+h30FgcsEC+6jS0j/8CBTGqMwFbGf1lMfRh
         nrInG2dQm9fOIAM9sA2Jy131NHCzu7kLrPDvJ2FFyfv6KIUzPSikhQZt4rnQq5Gve+TM
         JEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gGvYsYI7pAIHGRHTOtfrbaAjnfrDtx4Jcwk5RW42xw=;
        b=kizas+ZpK/zm0LBNlLordfWCKgOrcvppJHNaYsi+1WCIhx1VAD3eFgpMVZhB5e8bxC
         kMDI1zUzT5bDBOdeIhiSvD1l7iDtP7OU4J7Rtvou7gbpnNs6r8MNRW8cS+wSWapneg+W
         uTht5JohxWQo4DypWEmW1oqJoJ7j+R99WDr6z6KjJYdbuzUSrAVucSCd/rouKzvlh3QA
         +dTmTTOOLQH1LdfPnMu2mBInw0QperY5x20LNFfwQnzM/DZFjrCv+M+LwNHPnsE81ehE
         QhFCFnEmAwXCn73UWp6jborIfOs6dIGk14RKc9ohJtl8RQgKPhI72myPcrqN7eGHkti5
         Ge/Q==
X-Gm-Message-State: AOAM530U/WUgTeUcm+kLlPGlgY0cLxLOM7Vwo0tsF1GfwWUgIjjf8VIS
        as2fMbA6M4APJyWDlL4a7IWLWDyw
X-Google-Smtp-Source: ABdhPJybCAxMq7oimlOwMnDuIjzmzMxzWGXVY8SlsJbLzkDYDxrNWnZLLQsTl9ae11b28tsh/srDqg==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr15066500ejp.509.1596903120783;
        Sat, 08 Aug 2020 09:12:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:12:00 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] wstring: call is_string_type() only when needed
Date:   Sat,  8 Aug 2020 18:11:43 +0200
Message-Id: <20200808161143.28272-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
References: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Just a tiny code reorganization to call is_string_type()
only where & when needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 8d09c560e7fe..d2cf1c0ae3f8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2764,7 +2764,6 @@ static struct expression *handle_scalar(struct expression *e, int nested)
 static int handle_initializer(struct expression **ep, int nested,
 		int class, struct symbol *ctype, unsigned long mods)
 {
-	int is_string = is_string_type(ctype);
 	struct expression *e = *ep, *p;
 	struct symbol *type;
 
@@ -2798,7 +2797,7 @@ static int handle_initializer(struct expression **ep, int nested,
 	 * pathologies, so we don't need anything fancy here.
 	 */
 	if (e->type == EXPR_INITIALIZER) {
-		if (is_string) {
+		if (is_string_type(ctype)) {
 			struct expression *v = NULL;
 			int count = 0;
 
@@ -2819,7 +2818,7 @@ static int handle_initializer(struct expression **ep, int nested,
 	/* string */
 	if (is_string_literal(&e)) {
 		/* either we are doing array of char, or we'll have to dig in */
-		if (is_string) {
+		if (is_string_type(ctype)) {
 			*ep = e;
 			goto String;
 		}
-- 
2.28.0

