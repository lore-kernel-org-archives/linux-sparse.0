From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] improve -m32/-m64
Date: Tue,  7 Feb 2017 21:04:21 +0100
Message-ID: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35860 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753893AbdBGUGc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:06:32 -0500
Received: by mail-wm0-f52.google.com with SMTP id c85so176265291wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:06:31 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series aims to make -m32/-m64 more useful and
to extend these flags to also support LLP64 model.

- patch 1 & 3 are quite straightforward.
- patch 2 is more code reorg/preparatory step
- patch 4 add support for LLP64 and is more a RFC

Luc Van Oostenryck (4):
  define __LP64__ & _LP64 if arch_m64 is enabled
  add an helper for common predefined macros
  define __LONG_MAX__ & __SIZEOF_POINTER__
  add support for LLP64 arch

 lib.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

-- 
2.11.0

