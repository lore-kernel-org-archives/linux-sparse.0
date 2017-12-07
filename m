From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] add missing degenerate() for logical-not
Date: Thu,  7 Dec 2017 18:16:10 +0100
Message-ID: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46647 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756742AbdLGRQc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Dec 2017 12:16:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so14421572wme.5
        for <linux-sparse@vger.kernel.org>; Thu, 07 Dec 2017 09:16:32 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix the evaluation of expressions
doing the (logical) negation of arrays or functions.
In this case, of course, the array or function must degenerate
into a pointer but it wasn't done. It doesn't make any
visible difference for the checker but the linearization
of such expressions was wrong.

Luc Van Oostenryck (3):
  add more testcases for using addresses in conditionals
  add testcases linearization of degenerated arrays/functions
  fix: add missing degenerate() for logical not

 evaluate.c                                         |   1 +
 .../{cond-address-array.c => Waddress-array.c}     |   9 +-
 ...cond-address-function.c => Waddress-function.c} |   7 +-
 validation/Waddress-weak.c                         |  25 +++++
 validation/Waddress.c                              | 110 +++++++++++++++++++++
 validation/linear/degen-array.c                    |  31 ++++++
 validation/linear/degen-function.c                 |  38 +++++++
 validation/linear/degen-log-not.c                  |  40 ++++++++
 8 files changed, 252 insertions(+), 9 deletions(-)
 rename validation/{cond-address-array.c => Waddress-array.c} (37%)
 rename validation/{cond-address-function.c => Waddress-function.c} (39%)
 create mode 100644 validation/Waddress-weak.c
 create mode 100644 validation/Waddress.c
 create mode 100644 validation/linear/degen-array.c
 create mode 100644 validation/linear/degen-function.c
 create mode 100644 validation/linear/degen-log-not.c

-- 
2.15.0

