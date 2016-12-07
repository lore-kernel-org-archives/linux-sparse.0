From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] more simplification of constant multiplicative ops
Date: Wed,  7 Dec 2016 16:46:50 +0100
Message-ID: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34575 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbcLGPrF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 10:47:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so28663847wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 07:47:04 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie add a few more simplification of multiplicative operators
(multiplication, division & modulo) with constants 1 or -1.
Only simplifications that doesn't depend on undefined behavior are done.


Luc Van Oostenryck (5):
  move OP_MUL simplification in a separate function
  simplify '(x / 1)' to 'x'
  simplify '(x * -1)' to '-x'
  simplify '(x / -1)' to '-x' (but only for signed division)
  simplify '(x % 1)' into '0'

 simplify.c                          | 40 +++++++++++++++++++++++++++++++++++++
 validation/optim/muldiv-by-one.c    | 19 ++++++++++++++++++
 validation/optim/muldiv-by-zero.c   | 13 ++++++++++++
 validation/optim/muldiv-minus-one.c | 15 ++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 validation/optim/muldiv-by-one.c
 create mode 100644 validation/optim/muldiv-by-zero.c
 create mode 100644 validation/optim/muldiv-minus-one.c

