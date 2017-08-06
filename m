From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: SCC: a sparse based compiler backend
Date: Sun,  6 Aug 2017 23:01:52 +0200
Message-ID: <20170806210152.11002-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36713 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdHFVCA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 17:02:00 -0400
Received: by mail-wm0-f51.google.com with SMTP id t201so54716667wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 14:01:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since it seems to be an interest on the subject, here is a
small compiler, or more exactly, a partial compiler backend.

Acessing symbols is very limited though and there is nothing
done yet for register allocation (and even less scheduling).

It can currently generate code for ARM & ARM64 and can easily
be adapted for other RISC arch. Code for x86 would need more work.

I don't feel the need to patchbomb the ML so here is the URL:
  git://github.com/lucvoo/sparse.git codegen

-- Luc
