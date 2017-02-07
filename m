From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/5] more simplification of constant multiplicative ops
Date: Tue,  7 Feb 2017 20:00:23 +0100
Message-ID: <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34100 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755381AbdBGTAl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 14:00:41 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so30042473wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 11:00:40 -0800 (PST)
In-Reply-To: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie add a few more simplification of multiplicative operators
(multiplication, division & modulo) with constants 1 or -1.
Only simplifications that doesn't depend on undefined behavior are done.

Changes since v1:
- no functional changes
- remove unneeded case + break in patch 2

Luc Van Oostenryck (5):
  move OP_MUL simplification in a separate function
  simplify '(x / 1)' to 'x'
  simplify '(x * -1)' to '-x'
  simplify '(x / -1)' to '-x' (but only for signed division)
  simplify '(x % 1)' into '0'

 simplify.c                          | 36 ++++++++++++++++++++++++++++++++++++
 validation/optim/muldiv-by-one.c    | 19 +++++++++++++++++++
 validation/optim/muldiv-by-zero.c   | 13 +++++++++++++
 validation/optim/muldiv-minus-one.c | 15 +++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 validation/optim/muldiv-by-one.c
 create mode 100644 validation/optim/muldiv-by-zero.c
 create mode 100644 validation/optim/muldiv-minus-one.c

-- 
2.11.0

