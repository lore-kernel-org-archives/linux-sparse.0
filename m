From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] more validation of C99 for-loop initializers
Date: Sat, 18 Feb 2017 21:30:43 +0100
Message-ID: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35550 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdBRUaz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 15:30:55 -0500
Received: by mail-wr0-f194.google.com with SMTP id q39so8390200wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Feb 2017 12:30:55 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie adds some validations of C99-style for-loop
initializers: scope and storage.

Patch 1 replaces the current indirect test by a direct one
Patch 2 adds a test case for the scope
Patch 3 adds some test cases for storage.
Patch 4 is a preparatory patch for 5).
Patch 5 adds missing storage validation

Luc Van Oostenryck (5):
  replace test for c99 for-loop initializers
  add test case for scope of C99 for-loop declarations
  add test cases for storage of c99 for-loop declarations
  add a method to external_declaration()
  check the storage of C99 for-loop initializers

 lib.c                          |  2 +-
 parse.c                        | 37 ++++++++++++++++++++++++++++++-------
 parse.h                        |  3 ++-
 validation/c99-for-loop-decl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 validation/c99-for-loop.c      | 36 ++++++++++++------------------------
 5 files changed, 85 insertions(+), 33 deletions(-)
 create mode 100644 validation/c99-for-loop-decl.c

-- 
2.11.0

