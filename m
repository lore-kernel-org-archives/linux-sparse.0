From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC] sparse SSA construction
Date: Sun,  6 Aug 2017 22:26:51 +0200
Message-ID: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38438 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdHFU1A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 16:27:00 -0400
Received: by mail-wm0-f42.google.com with SMTP id m85so54526156wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 13:26:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since it seems to be some interest on the subject and
to avoid duplicated work, here is a rewrite of sparse's
construction of the SSA form.

It's not using one of the classical algorithm but is
using something newer, simpler and often faster.
It's main advantage beyond the simplicity is that you don't
need to first build the whole CFG & linearized code to
to directly throw it away (or heavily transform it) as
it builds the SSA form directly during the linearization.

It's not finished code but it's working well (and is
effectively a bit faster and use less memory).
What's interesting for sparse now is that:
- the phi-noes are correctly placed
- uninitialized variables can be handled much more easily.

I don't feel it's needed to patchbomb the ML for the moment
so I'll only give the URL to the repo:

  git://github.com/lucvoo/sparse.git sssa
