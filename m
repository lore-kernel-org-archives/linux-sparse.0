From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] fix test cases on 32bit
Date: Mon, 27 Mar 2017 16:19:13 +0200
Message-ID: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36257 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753482AbdC0OV4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 10:21:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id u1so13797341wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 07:21:44 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some of the test cases made some assumption about the size
of longs or pointers. This serie provides fixes for those.

Luc Van Oostenryck (5):
  fix test for cast to bool on 32bit machines
  predefine __INT_MAX__ and friends
  predefine __SIZEOF_INT__ & friends
  fix test validation/div.c
  do not depends on limits.h to test __CHAR_BIT__

 lib.c                                     | 33 ++++++++++++++++++++++++++-----
 validation/bool-cast-explicit.c           |  2 +-
 validation/bool-cast-implicit.c           |  2 +-
 validation/builtin_char_bit.c             |  7 -------
 validation/div.c                          | 22 +++++++++++----------
 validation/preprocessor/predef-char-bit.c | 16 +++++++++++++++
 validation/preprocessor/predef-max.c      | 18 +++++++++++++++++
 validation/preprocessor/predef-sizeof.c   | 25 +++++++++++++++++++++++
 8 files changed, 101 insertions(+), 24 deletions(-)
 delete mode 100644 validation/builtin_char_bit.c
 create mode 100644 validation/preprocessor/predef-char-bit.c
 create mode 100644 validation/preprocessor/predef-max.c
 create mode 100644 validation/preprocessor/predef-sizeof.c

-- 
2.12.0

