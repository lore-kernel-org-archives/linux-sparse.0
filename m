From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] fix bitfield initiallizers
Date: Fri,  7 Apr 2017 01:00:25 +0200
Message-ID: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33057 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdDFXAg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 19:00:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id g19so15333410wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 16:00:36 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix two bugs related
to the initialization of bitfields:
- bad shift & mask
- no implicit zeroing

One notable change is the removal of bit_offset & bit_size
from struct access_data.


This series is available at:
	git://github.com/lucvoo/sparse.git fix-bitfield-init
based on commit:
	14964df5373292af78b29529d4fc7e1a26b67a97 (sparse-next @ 2017-03-31)
up to commit:
	6e778f937073d96934c6240b5d47a76b0d592e27


Luc Van Oostenryck (4):
  add support for a new flag: -fdump-linearize[=only]
  remove bit_size & bit_offset from struct access_data
  add test case for linearize_initializer() of bitfields
  fix implicit zero initializer.

 lib.c                                   |  22 +++++++
 lib.h                                   |   2 +
 linearize.c                             |  36 +++++++----
 sparse.1                                |   7 +++
 validation/linear/bitfield-init-mask.c  |  27 +++++++++
 validation/linear/bitfield-init-zero.c  | 102 ++++++++++++++++++++++++++++++++
 validation/linear/struct-init-full.c    |  28 +++++++++
 validation/linear/struct-init-partial.c |  41 +++++++++++++
 8 files changed, 255 insertions(+), 10 deletions(-)
 create mode 100644 validation/linear/bitfield-init-mask.c
 create mode 100644 validation/linear/bitfield-init-zero.c
 create mode 100644 validation/linear/struct-init-full.c
 create mode 100644 validation/linear/struct-init-partial.c

-- Luc Van Oostenryck
