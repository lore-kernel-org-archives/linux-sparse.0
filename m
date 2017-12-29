From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] teach sparse about -funsigned-char & friends
Date: Fri, 29 Dec 2017 22:46:23 +0100
Message-ID: <20171229214625.41368-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35121 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdL2Vqd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 29 Dec 2017 16:46:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id a79so10856344wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 29 Dec 2017 13:46:32 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a change allowing to change the signedness
of plain chars.

This series is available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git funsigned-char

Luc Van Oostenryck (2):
  let handle_switches() also handle reverse logic
  add support for '-f[no-][un]signed-char'

 lib.c                      |  5 +++++
 lib.h                      |  1 +
 sparse.1                   |  5 +++++
 symbol.c                   |  6 ++++++
 validation/char-signed.c   |  9 +++++++++
 validation/char-unsigned.c | 11 +++++++++++
 6 files changed, 37 insertions(+)
 create mode 100644 validation/char-signed.c
 create mode 100644 validation/char-unsigned.c

-- 
2.15.0

