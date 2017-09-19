From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] expressions without a type
Date: Tue, 19 Sep 2017 04:13:30 +0200
Message-ID: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35694 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdISCNl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:13:41 -0400
Received: by mail-wr0-f196.google.com with SMTP id n64so1363585wrb.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:13:40 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a few patches dealing with expressions
without a type and improving the diagnostics related to them.


The series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git expr-notype

----------------------------------------------------------------
Luc Van Oostenryck (5):
      do not linearize expressions without a type
      add helper: valid_type()
      add helper: valid_expr_subtype()
      do not report bad types twice or more
      always evaluate both operands

 evaluate.c  | 38 ++++++++++++++++++++++++++++----------
 linearize.c |  2 +-
 symbol.h    |  5 +++++
 3 files changed, 34 insertions(+), 11 deletions(-)
