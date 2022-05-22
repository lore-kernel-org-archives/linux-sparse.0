Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBFAC433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 22 May 2022 09:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiEVJIl (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 May 2022 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiEVJIk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 May 2022 05:08:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B5C344EB
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 02:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B540FB80ACC
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 09:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E371C385AA;
        Sun, 22 May 2022 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653210517;
        bh=SIwrnPhW6qRthktQesvifqy0O//sragZ3AjtjiRkqOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkR3I2daSdDkCnv6vDZe28V0Rrl+tPN2XwEo2cil2oLg9+MwcVGX9BfcdDjBazJXm
         iN2a23Uc4a0YSTsp7WTQkgsY2T+nLH2J1qaiF2PiQ8r4ZDBqtlE+MqisKu3dv5wL8K
         SLxqwIZTCkLhwfJlcPz/gXmsjRaEj4yiQg47QIxSUUxX7GSNww7AWWPTijyhtjLr3w
         s2rAdqw2U1VKGrASZryfWZ1fMMphP1dx4lCpjL4lvrbiu94mIpkX9BRq6+5I25RhjV
         EGmOxYlTD7GuTHfBPrIDf4lf5Q15FlSP9uiXC21nMdji2p6GK/rprRMTdZ3MgawmZ2
         V4GJYuFawtWwA==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] handle clang's option "-meabi gnu"
Date:   Sun, 22 May 2022 11:08:24 +0200
Message-Id: <20220522090824.11678-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAHk-=wit1MGUeFOycVt_qrk8TKBAAHf-9=ekqC=t0snMNpo29g@mail.gmail.com>
References: <CAHk-=wit1MGUeFOycVt_qrk8TKBAAHf-9=ekqC=t0snMNpo29g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Clang has an option "-meabi <arg>" which is used by the kernel for ARMv7.
This kind of option, taking a argument without a separating '=', can't
be ignored like most other options and must this be special-cased.

So, add the special case for this option and consume the argument if it's
one of the valid one.

Link: https://lore.kernel.org/r/20220331110118.vr4miyyytqlssjoi@pengutronix.de
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/options.c b/options.c
index 6704fc8d2c8d..0224c290d322 100644
--- a/options.c
+++ b/options.c
@@ -685,6 +685,19 @@ static const struct flag mflags[] = {
 
 static char **handle_switch_m(char *arg, char **next)
 {
+	if (!strcmp(arg, "meabi") && next[1] && next[1][0] != '-') {
+		// clang has such an option with syntax: -meabi <arg>
+		// It's used by the kernel for armv7.
+		// GCC has the same opion but with no argument.
+		// Parse it here to consume the possible argument.
+		static const char *valid[] = { "gnu", "4", "5", "default", NULL };
+		int i;
+		for (i = 0; valid[i]; i++) {
+			if (!strcmp(next[1], valid[i]))
+				return ++next;
+		}
+	}
+
 	if (!strcmp(arg, "multiarch-dir")) {
 		return handle_multiarch_dir(arg, next);
 	} else {
-- 
2.36.1

