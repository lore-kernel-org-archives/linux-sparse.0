From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] predefine: fix multi-token predefine
Date: Sun,  5 Jul 2020 15:11:44 +0200
Message-ID: <20200705131146.26439-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENLv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:11:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683EC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:11:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so32207739edy.7
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:11:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function predefine() and its variants are only valid
if they define a single-token value but predefine_min()
will produce a multi-token value if the type is signed.
    
This series contains a fix and a tescase for this.


Luc Van Oostenryck (2):
  predefine: add testcase for multi-token predefines
  predefine: fix multi-token predefine

 predefine.c                            | 2 +-
 validation/preprocessor/predef-token.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 validation/preprocessor/predef-token.c


base-commit: 88c90bb192663bfc2dc54782c316e39e6fe26e1d
-- 
2.27.0
