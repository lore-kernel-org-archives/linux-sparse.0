From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/7] fix function or array address in conditionals
Date: Wed, 22 Mar 2017 18:32:50 +0100
Message-ID: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33728 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVRdJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11so11635235wma.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:08 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

This serie fixes the evaluation of function or array used
in conditionals which were not degenerated as pointers.
It also teaches sparse to now give some warnings for such uses
as it's a probable sign of an error.

This serie can also be found on github as:
	https://github.com/lucvoo/sparse fix-cond-address


Luc Van Oostenryck (7):
  teach sparse about -Waddress
  add is_func_type()
  warn if testing the address of a function
  add is_array_type()
  warn if testing the address of an array
  fix evaluation of a function or array symbol in conditionals
  fix is_scalar_type()

 evaluate.c                         |  9 ++++++++-
 lib.c                              |  2 ++
 lib.h                              |  1 +
 symbol.h                           | 16 ++++++++++++++--
 validation/cond-address-array.c    | 26 ++++++++++++++++++++++++++
 validation/cond-address-function.c | 18 ++++++++++++++++++
 validation/cond-address.c          | 14 ++++++++++++++
 7 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 validation/cond-address-array.c
 create mode 100644 validation/cond-address-function.c
 create mode 100644 validation/cond-address.c

-- 
2.12.0

