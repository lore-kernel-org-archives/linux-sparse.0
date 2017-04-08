From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/6] fix bitfield initializers
Date: Sat,  8 Apr 2017 23:18:55 +0200
Message-ID: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35004 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdDHVTJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Apr 2017 17:19:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so3604087wmi.2
        for <linux-sparse@vger.kernel.org>; Sat, 08 Apr 2017 14:19:08 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix two bugs related
to the initialization of bitfields:
- bad shift & mask
- no implicit zeroing

One notable change is the removal of bit_offset & bit_size
from struct access_data.

Change since v1:
- fix typo in handle_switch_fdump()
- also remove struct access_data:alignment
- also remove struct access_data:origval

This series is available at:
        git://github.com/lucvoo/sparse.git fix-bitfield-init-v2
based on commit:
        14964df5373292af78b29529d4fc7e1a26b67a97 (sparse-next @ 2017-03-31)
up to commit:
	fc981fe285c37ee297e93ef1cc8725caac75f9b3

Luc Van Oostenryck (6):
  add support for a new flag: -fdump-linearize[=only]
  remove bit_size & bit_offset from struct access_data
  add test case for linearize_initializer() of bitfields
  fix implicit zero initializer.
  remove alignment from struct access_data
  remove origval from struct access_data

 lib.c                                   |  23 +++++++
 lib.h                                   |   2 +
 linearize.c                             |  46 +++++++++-----
 sparse.1                                |   7 +++
 validation/linear/bitfield-init-mask.c  |  27 +++++++++
 validation/linear/bitfield-init-zero.c  | 102 ++++++++++++++++++++++++++++++++
 validation/linear/struct-init-full.c    |  28 +++++++++
 validation/linear/struct-init-partial.c |  41 +++++++++++++
 8 files changed, 260 insertions(+), 16 deletions(-)
 create mode 100644 validation/linear/bitfield-init-mask.c
 create mode 100644 validation/linear/bitfield-init-zero.c
 create mode 100644 validation/linear/struct-init-full.c
 create mode 100644 validation/linear/struct-init-partial.c

-- 
2.12.0

