From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] return type's testcases
Date: Mon, 18 Sep 2017 16:10:54 +0200
Message-ID: <20170918141057.69745-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33156 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdIROLG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 10:11:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id m127so1034524wmm.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 07:11:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These are just a few patches adding or fixing some testcases about
return type.

These patches are also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git testcases-return-type

----------------------------------------------------------------
Luc Van Oostenryck (3):
      fix test case kill-phi-ttsb
      add test case for incomplete type
      add test case for bad return type

 validation/bad-return-type.c   | 19 +++++++++++++++++++
 validation/incomplete-struct.c | 23 +++++++++++++++++++++++
 validation/kill-phi-ttsbb.c    |  2 +-
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 validation/bad-return-type.c
 create mode 100644 validation/incomplete-struct.c
