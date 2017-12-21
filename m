From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix function calls via pointers
Date: Thu, 21 Dec 2017 01:06:39 +0100
Message-ID: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42841 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755811AbdLUAIs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:08:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id b199so13048017wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:08:47 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a fix for the linearization of
function calls via function pointers.

Luc Van Oostenryck (3):
  add testcases for the linearization of calls
  simplify linearize_call_expression()
  fix linearize (*fun)()

 linearize.c                              | 21 ++++--------
 validation/builtin-arith.c               | 52 +++++++++++++++++++++++++++++
 validation/function-pointer-type.c       |  9 +++++
 validation/linear/call-basic.c           | 57 ++++++++++++++++++++++++++++++++
 validation/linear/call-builtin.c         | 14 ++++++++
 validation/linear/call-casted-pointer.c  | 31 +++++++++++++++++
 validation/linear/call-complex-pointer.c | 32 ++++++++++++++++++
 validation/linear/call-direct.c          | 14 ++++++++
 validation/linear/call-indirect.c        | 13 ++++++++
 validation/linear/call-inline.c          | 15 +++++++++
 validation/optim/call-complex-pointer.c  | 13 ++++++++
 validation/sizeof-builtin.c              | 15 +++++++++
 validation/sizeof-function.c             | 50 ++++++++++++++++++++++++++++
 13 files changed, 321 insertions(+), 15 deletions(-)
 create mode 100644 validation/builtin-arith.c
 create mode 100644 validation/function-pointer-type.c
 create mode 100644 validation/linear/call-basic.c
 create mode 100644 validation/linear/call-builtin.c
 create mode 100644 validation/linear/call-casted-pointer.c
 create mode 100644 validation/linear/call-complex-pointer.c
 create mode 100644 validation/linear/call-direct.c
 create mode 100644 validation/linear/call-indirect.c
 create mode 100644 validation/linear/call-inline.c
 create mode 100644 validation/optim/call-complex-pointer.c
 create mode 100644 validation/sizeof-builtin.c
 create mode 100644 validation/sizeof-function.c

-- 
2.15.0

