From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] Fixes for generic selection
Date: Fri, 19 Jun 2020 17:02:55 +0200
Message-ID: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391097AbgFSPEF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A9C06174E
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so10536273ejj.5
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains:
* the controlling expression must be lvalue-converted,
  array-to-pointer & function-to-pointer converted.
  These are the rules following the resolution of DR481
  and are also used for C17 (and are followed by both
  GCC & clang).
* validate the type of the associations.

These patches are available for testing & review at:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git fix-gensel


Note: A small inconsistency remains: a plain char
      will match a signed char or a unsigned char.

Luc Van Oostenryck (5):
  gensel: add testcases from DR481
  gensel: use temporary variable in generic selection
  gensel: controlling expression must be lvalue converted
  gensel: controlling expression must be pointer-converted
  gensel: validate the type of the associations

 evaluate.c                 | 33 ++++++++++++++++++++++++++++++---
 validation/generic-dr481.c | 17 +++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 validation/generic-dr481.c

-- 
2.27.0
