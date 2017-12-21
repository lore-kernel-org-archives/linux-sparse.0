From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] multiple dereference in function calls
Date: Thu, 21 Dec 2017 01:19:12 +0100
Message-ID: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46457 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755846AbdLUAVY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:21:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so13051865wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:21:23 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In most situations of function type is implicitly
converted to the corresponding pointer.
This pointer can be dereferenced but the implicit
conversion will make it to immediatly decay back
to a pointer. In consequence, in a function call
the function designator can be preceded by an unlimited
number of deref operator ('*').

This series makes it effective.

Luc Van Oostenryck (3):
  add testcases for multiple deref of calls
  avoid unneeded alloc on error path
  dereference of a function is a no-op

 evaluate.c                         | 6 +++++-
 validation/function-pointer-type.c | 3 +++
 validation/linear/call-builtin.c   | 5 ++++-
 validation/linear/call-direct.c    | 5 ++++-
 validation/linear/call-indirect.c  | 4 +++-
 validation/linear/call-inline.c    | 5 ++++-
 validation/sizeof-function.c       | 1 -
 7 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.15.0

