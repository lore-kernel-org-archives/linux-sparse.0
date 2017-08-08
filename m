From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] fix list corruption with recursive remove_usage()
Date: Tue,  8 Aug 2017 03:04:22 +0200
Message-ID: <20170808010422.88647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34621 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdHHBE3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:04:29 -0400
Received: by mail-wm0-f42.google.com with SMTP id t138so2737755wmt.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:04:28 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Chris,
Please pull these patches for replacement of the ones
currently on sparse-next.
It's ones to avoid list corruption that may happen with
pseudo-users when deleting one while doing nested ptrlist walking.

The code is unchanged since the last submit and is the same as
the one currently on sparse-next.

Thanks,
Luc

----------------------------------------------------------------
The following changes since commit 0c4c998690e5e31696404fa518022865fd9232d2:

  fix crash with sym->bb_target == NULL (2017-07-31 22:21:59 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git for-chris

for you to fetch changes up to bddf7d1e4ed81c3def7c6de2796a5489ca678399:

  mark pseudo users as deleted instead of removing them (2017-08-05 00:14:02 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (5):
      ptrlist: add a counter for the number of removed elemnets
      ptrlist: adjust ptr_list_size for the new ->rm field
      ptrlist: add MARK_CURRENT_DELETED
      ptrlist: avoid iteration on NULL entries
      mark pseudo users as deleted instead of removing them

 ptrlist.c  |  2 +-
 ptrlist.h  | 15 ++++++++++++++-
 simplify.c |  5 +++--
 3 files changed, 18 insertions(+), 4 deletions(-)
