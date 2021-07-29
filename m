Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A7DC4338F
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC57360C51
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhG2VVD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233832AbhG2VVD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2058C60C51;
        Thu, 29 Jul 2021 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627593659;
        bh=6Xrqb1aGmcpoQBlM+9KEV0AoWvNnHMNs7Z+SR+Kyy/4=;
        h=From:To:Cc:Subject:Date:From;
        b=CVnPotWZ85GBcEANkcDOjVzQq7mSfd+QVbpzYYAfvhOVzDjPAMvlKbL0sE4+F+Aus
         quGH/KP/SY+JuCsFeOmwV/KU1RKPbBXq0vtOdkKAnoQNrezfSVGIBPFkiJWAEWf3sh
         Xn34AYEjlXZed2CoJh/Sxl8v0CQYRGL1cGfF/bjjNxPnNNVUHe2nBeFFvwOo1wKrFh
         XC838XHm+VzBqnfBppcAe9kkdEhVu/tqJ10gPID/gVaoNumQq3WJs3d3rAvZcC4KHQ
         NlXPsvLvc4tY/wC/iXyi9zXV6lJNFuhzp6HPwjb5ya6rNIVq4LpWxBu7VVhMtwRA0o
         zG14Loj3qnwsQ==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] small fixes for the symbolic checker
Date:   Thu, 29 Jul 2021 23:20:49 +0200
Message-Id: <20210729212054.34327-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a few fixes for the symbolic checker (which
can be used internally to validate some code transformations).

Luc Van Oostenryck (5):
  scheck: better diagnostic for unsupported instructions
  scheck: ignore OP_NOP & friends
  scheck: constants are untyped
  scheck: mkvar() with target or input type
  scheck: fix type of operands in casts

 scheck.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

-- 
2.32.0

