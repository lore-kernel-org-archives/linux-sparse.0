Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB2C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jun 2022 00:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiFNARq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiFNARo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jun 2022 20:17:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5132253A
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jun 2022 17:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3303B8167B
        for <linux-sparse@vger.kernel.org>; Tue, 14 Jun 2022 00:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A55C34114;
        Tue, 14 Jun 2022 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655165859;
        bh=A1dIgaKzESVI+B4DJt6QIN6fbPEVYNPzRIsvg9IjdyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHSu2h4XldpgJEJe28kFmcXke5jFLXRyAcPSovE3rjQxZTT6vJ++B3ad9XK0BbzKA
         5dlaD+aNu0RVioe3PDimOmI85Ef6ylkGpb7jyv0uU3/Z/MLi3UeIiJ1RVpGE9XcnUF
         O9sqDehD54N/SgZ+XUolYIBZ92Gh/GMy+hl67lQVD7NptWqtksE51kkILTRM6Rom3U
         hOtZ7u+j/NKdfxApDkKAo5SS3kq3I0ksNWoTLuZqfu3GAB4k8m8ypWGi758tMieXdS
         iUPt4tmKNvTLSqQzGYt5wX49rn7m1i4J0cR/6qVqwRASZ37Tx646qM1Ga+G7NqYKjB
         LahQqcB/CBRGQ==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] predefine __ATOMIC_ACQUIRE & friends as weak
Date:   Tue, 14 Jun 2022 02:17:25 +0200
Message-Id: <20220614001725.29431-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <33a053bc-1d81-49f4-0c8a-879a5519c433@infradead.org>
References: <33a053bc-1d81-49f4-0c8a-879a5519c433@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In kernel's arch/mips/Makefile the whole content of gcc's -dM is used
for CHECKFLAGS. This conflict with some macros also defined internally:
	builtin:1:9: warning: preprocessor token __ATOMIC_ACQUIRE redefined
	builtin:0:0: this was the original definition

Fix this by using a weak define for these macros.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/predefine.c b/predefine.c
index 98e38a04579d..5b0f0caf4c35 100644
--- a/predefine.c
+++ b/predefine.c
@@ -179,12 +179,12 @@ void predefined_macros(void)
 	if (arch_target->has_int128)
 		predefined_sizeof("INT128", "", 128);
 
-	predefine("__ATOMIC_RELAXED", 0, "0");
-	predefine("__ATOMIC_CONSUME", 0, "1");
-	predefine("__ATOMIC_ACQUIRE", 0, "3");
-	predefine("__ATOMIC_RELEASE", 0, "4");
-	predefine("__ATOMIC_ACQ_REL", 0, "7");
-	predefine("__ATOMIC_SEQ_CST", 0, "8");
+	predefine("__ATOMIC_RELAXED", 1, "0");
+	predefine("__ATOMIC_CONSUME", 1, "1");
+	predefine("__ATOMIC_ACQUIRE", 1, "3");
+	predefine("__ATOMIC_RELEASE", 1, "4");
+	predefine("__ATOMIC_ACQ_REL", 1, "7");
+	predefine("__ATOMIC_SEQ_CST", 1, "8");
 
 	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
 	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
-- 
2.36.1

