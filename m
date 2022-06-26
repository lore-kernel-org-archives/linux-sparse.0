Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C7C43334
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 13:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiFZNIA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiFZNH7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 09:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C662AC
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 06:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60497B80D86
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 13:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DD2C34114;
        Sun, 26 Jun 2022 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656248875;
        bh=Hd1xS2MH/amct6yN3twVmk6BT1KQEhkY/pXXdyu/sZk=;
        h=From:To:Cc:Subject:Date:From;
        b=fppIyWk7ckbi1SFRikiEtMZ6Tgyra6r0JWktelaBF6VdJ//PJJW8IkkknTK0VCbTu
         B+KcOg6oMQ4veerTQFwNFqz35eBUSJoOuxrlr+0HaaZ0z/YwzaP0VeRtH6Ltn7GUeu
         tAIcqySzo3DPNWDaJEa7B48ydaI6X040ntLCvFb23uHfsQhhF9hRdtjBdD5H621au/
         5jjbAFdX0DMuCCOQztzWns9Wo8f5YRteU+AGh9YrHpxxsiP1/bflJh+XM5Z6lhDInz
         Hwcgeb/Z8IGTZV3Z4WP77XSB3D7LRkxNlGMNKr2zXnOkPTg3WKBndOfQHR5x6eWbMe
         Aq/WLVuj8+H2A==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] cleanup related to inlining of variadic functions
Date:   Sun, 26 Jun 2022 15:07:42 +0200
Message-Id: <20220626130748.74163-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse's tree-inline contains or needs some special handling
if the inlined function is variadic.
This series contains some cleanup related to these.

Luc Van Oostenryck (6):
  inline: add testcases for inlining of variadics
  inline: comment about creating node of node on variadics
  inline: declaration of the variadic vars is useless
  inline: avoid needless intermediate vars
  inline: allocate statement after guards
  inline: free symbol list after use

 inline.c                            | 23 +++++++++++++----------
 validation/inline-early/variadic0.c | 13 +++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)
 create mode 100644 validation/inline-early/variadic0.c

-- 
2.36.1

