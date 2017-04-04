From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] dump macros definitions
Date: Tue,  4 Apr 2017 23:49:49 +0200
Message-ID: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35605 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbdDDVuK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so8024949wmb.2
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add support for GCC's -dD.

This implementation is quite straightforward:
- record all macro's name
- dump the tokens corresponding to each macros
  without argument expansion.

This series is available at:
	git://github.com/lucvoo/sparse.git dump-macros
based on commit:
	14964df5373292af78b29529d4fc7e1a26b67a97 (sparse-next @ 2017-03-31)
up to commit:
	9a01ec7d42d6013ead12cb111b1a1879d0c856ab


Luc Van Oostenryck (6):
  define ident_list
  teach sparse how to dump macro definitions
  teach sparse how to handle -dD flag
  let -dD report macro defintions
  let -dD report #undef too
  fix -dD for never-defined #undef

 lib.c                                       | 21 ++++++++++
 lib.h                                       |  9 +++++
 pre-process.c                               | 61 ++++++++++++++++++++++++++++-
 validation/empty-file                       |  0
 validation/preprocessor/dump-macros-empty.c |  7 ++++
 validation/preprocessor/dump-macros-multi.c |  7 ++++
 validation/preprocessor/dump-macros.c       | 23 +++++++++++
 7 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 validation/empty-file
 create mode 100644 validation/preprocessor/dump-macros-empty.c
 create mode 100644 validation/preprocessor/dump-macros-multi.c
 create mode 100644 validation/preprocessor/dump-macros.c


-- Luc Van Oostenryck
