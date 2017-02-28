From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 0/7] more validation of C99 for-loop initializers
Date: Tue, 28 Feb 2017 11:03:56 +0100
Message-ID: <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34484 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdB1KGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 05:06:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id m70so1507177wma.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 02:06:11 -0800 (PST)
In-Reply-To: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie adds scope & storage validations of C99-style for-loop
initializers.

Patch 1 replaces the current indirect test by a direct one
Patch 2-3 add test cases for the scope & storage
Patch 4-5 add missing storage validation
Patch 6-7 move some checks into default_process_decl().

Changes since v1:
- better log message for patch 1, thanks to Ramsay Jones

Changes since v2:
- patches 1-3 are unchanged.
- do not use 'NULL' for the default method
- limit changes to parse.c, leaving external_declaration() untouched
- use a more generic and exact name for the method
- move a check to default_process_decl()


Luc Van Oostenryck (7):
  replace test for c99 for-loop initializers
  add test case for scope of C99 for-loop declarations
  add test cases for storage of c99 for-loop declarations
  add a method to external_declaration()
  check the storage of C99 for-loop initializers
  make process_decl() aware of the presence of an initializer
  move check extern with initializer to default_process_decl()

 parse.c                        | 54 ++++++++++++++++++++++++++++++++----------
 validation/c99-for-loop-decl.c | 40 +++++++++++++++++++++++++++++++
 validation/c99-for-loop.c      | 36 ++++++++++------------------
 3 files changed, 94 insertions(+), 36 deletions(-)
 create mode 100644 validation/c99-for-loop-decl.c

-- 
2.11.1

