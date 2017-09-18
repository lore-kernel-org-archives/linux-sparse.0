From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] extra fixes for LLVM
Date: Mon, 18 Sep 2017 11:30:09 +0200
Message-ID: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38029 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754938AbdIRJaZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 05:30:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so272738wmd.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 02:30:24 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a few more fixes for sparse-llvm.


This series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git llvm-fixes-extras

----------------------------------------------------------------
Luc Van Oostenryck (5):
      llvm: warn instead of assert on global inits
      llvm: gracefully catch impossible type/value
      llvm: add support for float initializer
      llvm: give names easier to debug
      llvm: only compare void pointers

 sparse-llvm.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)
