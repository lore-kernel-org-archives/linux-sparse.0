From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 0/5] fix list corruption with recursive remove_usage()
Date: Fri,  4 Aug 2017 23:53:16 +0200
Message-ID: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36537 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdHDVx2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:53:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id d40so7041012wma.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:53:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to avoid list corruption that may happen
with pseudo-users when deleting one while doing nested ptrlist walking.
This can occurs with mutually recursive calls:
        remove_usage() -> kill_instruction() -> remove_usage() ...

Changes since v2:
- replace the local tests against null list elements
  by one done directly by the list iteration macros
  
The series is also available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-nested-pseudo-users-deletion-v3

for you to fetch changes up to 4e2f74793baa52c127653efaedaacb0b52b8f884:

  mark pseudo users as deleted instead of removing them (2017-08-04 23:50:12 +0200)

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
