From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix crash in ctags.c
Date: Tue,  2 Jan 2018 16:11:14 +0100
Message-ID: <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:47024 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeABPL2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Jan 2018 10:11:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so61973229wme.5
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jan 2018 07:11:27 -0800 (PST)
In-Reply-To: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: foobar <foobar@redchan.it>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains two patches fixing a null pointer
dereference in ctags.

Note: part of the problem here is that the ctags tools directly
      use global_scope->symbols and that the builtins are in
      the global scope. I think they should be in a separate
      scope, but it'll be another story.

These patches are available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git fix-ctags-crash
and soon will be pushed at:
  git://github.com/lucvoo/sparse.git     master

Luc Van Oostenryck (2):
  give a type to builtin functions
  ctags: avoid null deref

 builtin.c | 6 +++---
 ctags.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
