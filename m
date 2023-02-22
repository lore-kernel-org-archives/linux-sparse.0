Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A6EC61DA4
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Feb 2023 15:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjBVPww (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjBVPwv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2023 10:52:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14B30EC
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2023 07:52:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07019B815DF
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2023 15:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E29C433D2;
        Wed, 22 Feb 2023 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677081166;
        bh=5V/y9UpdlUayX8JeD7FFJf0oVqJFb8oDNfLBpWVY8j0=;
        h=From:To:Cc:Subject:Date:From;
        b=jUpPTN4qy8KBeOGMyD/5D87sqkJGFb3x+secnhS0hD11cgFvVtuhKgfwPTTdTvGVF
         Y3gbTSYNpZfB2vqa8HvQ1PpTWukxWcc8CeTfKRa31LJMslFlt8LAKFcls2Afzxlq3O
         nzpNUdorQhV6krSjuGHYlt1Co2Aq/SRTqjnqx7eaftPBmF1QOdThKkMTZ9Nb1V5MBs
         ZO6Eft+AzqochmViBToapgGYYeIHA45m+Ym7uGumjA0lD38KhUAl8tqUKmXoZqzJ9j
         T2G7V8sIv8uokjbgqCzVsn6A+8gf7nCCtM3PaxHHcjJJVdyz0mEr04/tT4lSmuWNIE
         dS8tanLOTEhJw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     luc.vanoostenryck@gmail.com
Subject: [PATCH] linearize.c: fix potential buffer overrun
Date:   Wed, 22 Feb 2023 10:52:44 -0500
Message-Id: <20230222155244.133890-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The resulting string won't be nearly 64 bytes, but "buf" is only 16
bytes long here, and this causes FORTIFY_SOURCE to barf when given the
right options.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index d9aed61b361f..1db2d505a7d4 100644
--- a/linearize.c
+++ b/linearize.c
@@ -91,7 +91,7 @@ const char *show_label(struct basic_block *bb)
 
 	if (!bb)
 		return ".L???";
-	snprintf(buf, 64, ".L%u", bb->nr);
+	snprintf(buf, 16, ".L%u", bb->nr);
 	return buf;
 }
 
-- 
2.39.2

