Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E5C4320A
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CD3604D7
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhG2VVG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233875AbhG2VVF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134F360C51;
        Thu, 29 Jul 2021 21:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627593661;
        bh=lwAflT8ZAz82FXuGW5gsz56Te+TxRn5vvlU6pKuDLFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mG74apM+1lglfFd7FQZ9zSsOowZ+/kgeXntTI6/DO/Pl3vw2APwD0bPC9qmINfEFC
         hJcXXYZ4KKitLl288I6eBM/9LFVq5BD7rtIjaAPJs67ZSL1fyLQ714R19kWXIySt7j
         AwXvpgPnY/fAOFOtwk3Xj+LmfmfhIqyWFcxwG1u9Mat3NciUP4KEsZiyRmQyqz2ZtS
         61SpYTZdzZhhBc5K+eoq7jwCo+4CbMXh4UouJZ6/MkgwS2SQSeUEQtdArfdQX26sZ0
         9tNMZ3dt+o1SszkQQl0F4CTijRKghaDU18+4/3tZ44w1PEbVE2BrbN+yoRzzZbvhx0
         5daCIJeKw9Lcw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] scheck: ignore OP_NOP & friends
Date:   Thu, 29 Jul 2021 23:20:51 +0200
Message-Id: <20210729212054.34327-3-lucvoo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729212054.34327-1-lucvoo@kernel.org>
References: <20210729212054.34327-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some instructions have no effects and so can just be ignored here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scheck.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scheck.c b/scheck.c
index c830f56a0985..d3ebddd6c2f5 100644
--- a/scheck.c
+++ b/scheck.c
@@ -313,6 +313,11 @@ static bool check_function(struct entrypoint *ep)
 				break;
 			case OP_RET:
 				goto out;
+			case OP_INLINED_CALL:
+			case OP_DEATHNOTE:
+			case OP_NOP:
+			case OP_CONTEXT:
+				continue;
 			default:
 				fprintf(stderr, "unsupported insn: %s\n", show_instruction(insn));
 				goto out;
-- 
2.32.0

