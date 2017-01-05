From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] add basic support for C11
Date: Thu,  5 Jan 2017 04:22:15 +0100
Message-ID: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35973 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967123AbdAEDXE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Jan 2017 22:23:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so94355586wma.3
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 19:22:27 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add support for the new C11 keywords:
_Thread_local, _Noreturn, _Alignof() & _Alignas().
Also accept '-std=c11' or '-std=gnu11' as option and
define the associated macros like '__STDC_VERSION__'.


This serie can also be found as:
  git://github.com/lucvoo/sparse.git sent/c11-basic


Luc Van Oostenryck (5):
  C11: teach sparse about '_Thread_local'
  C11: teach sparse about '_Noreturn'
  C11: teach sparse about '_Alignof()'
  C11: teach sparse about '_Alignas()'
  C11: teach sparse about '--std={c11,gnu11}'

 expression.c                  |  1 +
 ident-list.h                  |  1 +
 lib.c                         | 21 ++++++++++++++++
 parse.c                       | 58 +++++++++++++++++++++++++++++++++++++++++++
 validation/c11-alignas.c      | 40 +++++++++++++++++++++++++++++
 validation/c11-alignof.c      | 12 +++++++++
 validation/c11-noreturn.c     |  9 +++++++
 validation/c11-stdc-version.c | 11 ++++++++
 validation/c11-thread-local.c |  9 +++++++
 9 files changed, 162 insertions(+)
 create mode 100644 validation/c11-alignas.c
 create mode 100644 validation/c11-alignof.c
 create mode 100644 validation/c11-noreturn.c
 create mode 100644 validation/c11-stdc-version.c
 create mode 100644 validation/c11-thread-local.c
