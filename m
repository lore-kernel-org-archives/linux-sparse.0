From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] cleanup prototype
Date: Tue, 19 Sep 2017 05:08:38 +0200
Message-ID: <20170919030840.12525-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34346 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdISDIp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 23:08:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id k20so1403761wre.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 20:08:44 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains two patches removing unneeded prototypes.


The series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git cleanup-prototype

----------------------------------------------------------------
Luc Van Oostenryck (2):
      remove prototype extern int is_ptr_type()
      remove prototype for unexistant examine_simple_symbol_type()

 symbol.h | 2 --
 1 file changed, 2 deletions(-)
