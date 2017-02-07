From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 0/5] more simplification of constant multiplicative ops
Date: Tue,  7 Feb 2017 21:50:23 +0100
Message-ID: <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=67iWdgssXLEQyX0Saoe8iCf17jDCh7PWwwpeAuEhVAQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36491 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbdBGUxS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:53:18 -0500
Received: by mail-wm0-f45.google.com with SMTP id c85so177708356wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:52:33 -0800 (PST)
In-Reply-To: <CANeU7Q=67iWdgssXLEQyX0Saoe8iCf17jDCh7PWwwpeAuEhVAQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie add a few more simplification of multiplicative operators
(multiplication, division & modulo) with constants 1 or -1.
Only simplifications that doesn't depend on undefined behavior are done.

Changes since v1:
- no functional changes
- remove unneeded case + break in patch 2

Changes since v2:
- fix copy-paste error in test case for OP_DIVS by -1
- add test case for OP_DIVU by -1
Both thanks to Rasmus Villemoes.


Luc Van Oostenryck (5):
  move OP_MUL simplification in a separate function
  simplify '(x / 1)' to 'x'
  simplify '(x * -1)' to '-x'
  simplify '(x / -1)' to '-x' (but only for signed division)
  simplify '(x % 1)' into '0'

 simplify.c                          | 36 ++++++++++++++++++++++++++++++++++++
 validation/optim/muldiv-by-one.c    | 19 +++++++++++++++++++
 validation/optim/muldiv-by-zero.c   | 13 +++++++++++++
 validation/optim/muldiv-minus-one.c | 18 ++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 validation/optim/muldiv-by-one.c
 create mode 100644 validation/optim/muldiv-by-zero.c
 create mode 100644 validation/optim/muldiv-minus-one.c

-- 
2.11.0

