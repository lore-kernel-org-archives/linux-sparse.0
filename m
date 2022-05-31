Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F225C433F5
	for <linux-sparse@archiver.kernel.org>; Tue, 31 May 2022 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiEaTcj (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 31 May 2022 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiEaTch (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 31 May 2022 15:32:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7E9AE70
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2022 12:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99E07B80FAB
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2022 19:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C588EC385A9;
        Tue, 31 May 2022 19:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654025552;
        bh=KubuojfE9WbxNdkQTr1j+vpUv+lfOHLNkxQrFMn93t0=;
        h=From:To:Cc:Subject:Date:From;
        b=Cd+WNlcudW5W/nB3PJtdlbkflEqajmLkzc4OGan5TJYImnEYQIhUzU1km5URM3D+t
         ri7SGBNkgd/fDjMF6/a2Cc1TPW2e8Xx6UDAGuSBGCNLtgcclUn+k/nGY+7pBDkMWse
         wojgDlginB5kgsf6xPBlUraoEIDdSMavpwK7G5lajOYr7RQAbTsSLev0Y0EUZCid9b
         F/SQCC2mrbObyaAkPVmbUBUOkFKdm9zEPgbAnSPoGHKc7aUMvvSdaEMsrSCKeP2CwU
         p1Mk1NLmBVuYmZgwZDqvDOgHetVlmhMiqnnbYSOCSsTtwI1jKw9R8UmgrAD4yfw9tO
         cEawTdrno764Q==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] improve cast_value()
Date:   Tue, 31 May 2022 21:32:24 +0200
Message-Id: <20220531193226.33399-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains 2 small improvements to the cast_value() function.

Luc Van Oostenryck (2):
  cast_value: assign the new type
  cast_value: remove error-prone redundant argument

 expand.c     | 10 +++++++---
 expression.c |  3 +--
 expression.h |  3 +--
 parse.c      |  3 +--
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.36.1

