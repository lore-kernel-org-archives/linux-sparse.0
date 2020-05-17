From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] documentation related updates
Date: Mon, 18 May 2020 01:27:16 +0200
Message-ID: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgEQX1Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:27:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B19C061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so9712370wrn.6
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:24 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Fix the doc generation with recent version of Sphinx,
fix the warnings in the doc generation and update the TODO.

Luc Van Oostenryck (3):
  doc: do not use obsolete sphinx.ext.autodoc.AutodocReporter
  doc: fix the warnings when building the doc
  doc: remove done item from the TODO

 Documentation/TODO.md              | 12 +++++------
 Documentation/nocast-vs-bitwise.md | 34 ++++++++++++++++--------------
 Documentation/sphinx/cdoc.py       | 10 ++++-----
 3 files changed, 28 insertions(+), 28 deletions(-)


base-commit: b8fad4bcd02210912de8cbdefcd77e9ca743a575
-- 
2.26.2
