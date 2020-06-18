From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] support builtin macros & __has_feature()
Date: Thu, 18 Jun 2020 22:47:11 +0200
Message-ID: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRUtf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 16:49:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D9C06174E
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mb16so7883376ejb.4
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:34 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series adds:
* support for builtin macros with arguments
* support for __has_feature() & __has_extension()

Luc Van Oostenryck (5):
  pre-process: add testcases for __has_feature() & __has_extension()
  pre-process: rename 'expander' into 'expand_simple'
  pre-process: add support for builtin macros
  pre-process: add support for __has_feature() & __has_extension()
  pre-process: make __has_{attribute,builtin}() true builtin macros

 ident-list.h                          |   6 +-
 lib.c                                 |   2 -
 pre-process.c                         | 180 ++++++++++++++++++--------
 symbol.h                              |   4 +-
 validation/preprocessor/has-feature.c |  20 +++
 5 files changed, 151 insertions(+), 61 deletions(-)
 create mode 100644 validation/preprocessor/has-feature.c

-- 
2.27.0
