From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] cleanup of cclass[]
Date: Tue, 19 Sep 2017 04:55:58 +0200
Message-ID: <20170919025600.11900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34591 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdISC4J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:56:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so2544417wma.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:56:08 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains two small cleanup concerning the table
for character class used during tokenization.


The series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git cleanup-cclass

----------------------------------------------------------------
Luc Van Oostenryck (2):
      cclass: char is wide enough
      cclass: cleanup

 tokenize.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)
