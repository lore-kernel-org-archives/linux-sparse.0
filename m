Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E5C43334
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Jun 2022 23:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiFFXqx (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFFXqx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Jun 2022 19:46:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7034C03AF
        for <linux-sparse@vger.kernel.org>; Mon,  6 Jun 2022 16:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E777CE1BFE
        for <linux-sparse@vger.kernel.org>; Mon,  6 Jun 2022 23:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4118C385A9;
        Mon,  6 Jun 2022 23:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654559208;
        bh=y9HP4P531TueWSM57Kq0oaU3FhCmycrqELU4rhQkPW8=;
        h=From:To:Cc:Subject:Date:From;
        b=p/hjir+TXJuTFiX/iTaiZHLfx7naBuBjWk1CI4mJuBLjRDVUWh4n1J8yzpsGcFWPk
         +Ixt3ltg5DlEURCzQInN1d5506ijmpZL3P0zKNvCwOpchLw4tTCBzY5YFpoLSt3wNt
         yjDICsdypqAZ8QaNbbZH2HLWKogNCX/hupRtkHt8u1aXZpO7tJaJxwIESmf9r5oxwD
         jFbGpL2/bv+TC6ympmkuDWPjWqqjIa6S/WFyIx7zScz02X298YkogP9/eUtzd+GcFt
         GUPnLQ8SHeyiuifA66gGEXWp2vvp1wIhS3zQe9coWVF0sGwD4y8MZQsyW32zEcBUu8
         DrE6i2ffaI8Iw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cgcc: do not die on '-x assembler'
Date:   Tue,  7 Jun 2022 01:46:36 +0200
Message-Id: <20220606234636.34972-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently cgcc will die if the option '-x' is used with any argument
other than 'c'.

It makes sense since sparse can only handle C files but it can be
useful in a project to simply use something like:
	make CC=cgcc

So, instead of die()ing, avoid calling sparse if such '-x' option
is used, like already done by default for non .c files.

Original-patch-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/cgcc b/cgcc
index 733cadfa5dfe..618ba08a7b03 100755
--- a/cgcc
+++ b/cgcc
@@ -42,11 +42,10 @@ while (@ARGV) {
 	$nargs = 1;
     }
 
-    # Ignore the extension if '-x c' is given.
+    # We don't want to run the checker on non-C files.
     if ($_ eq '-x') {
 	die ("$0: missing argument for $_") if !@ARGV;
-	die ("$0: invalid argument for $_") if $ARGV[0] ne 'c';
-	$do_check = 1;
+	$do_check = ($ARGV[0] eq 'c');
 	$nargs = 1;
     }
 
-- 
2.36.1

