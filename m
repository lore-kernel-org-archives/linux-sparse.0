From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] improve handling of function attributes
Date: Mon, 18 May 2020 01:31:16 +0200
Message-ID: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXb2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6DC061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so9705729wrt.9
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Small improvements in the handling of function attributes as
a preparatory step for more functional changes.


Luc Van Oostenryck (6):
  attribute: sort the table of modifier names
  attribute: add helper apply_mod() and use it
  attribute: allow some attribute to be present multiple times
  attribute: add support for unused
  attribute: separate modifiers into type/declaration
  attribute: teach sparse about attribute((gnu_inline))

 parse.c                      | 34 +++++++++++++++++++++-------------
 show-parse.c                 | 28 +++++++++++++++-------------
 symbol.h                     | 11 ++++++++---
 validation/cond_expr2.c      |  2 +-
 validation/function-redecl.c |  6 +++---
 5 files changed, 48 insertions(+), 33 deletions(-)


base-commit: b8fad4bcd02210912de8cbdefcd77e9ca743a575
-- 
2.26.2
