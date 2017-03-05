From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 0/6] more validation of C99 for-loop initializers
Date: Sun,  5 Mar 2017 20:21:46 +0100
Message-ID: <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35677 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdCETWl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 14:22:41 -0500
Received: by mail-wr0-f196.google.com with SMTP id u108so15327557wrb.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 11:21:59 -0800 (PST)
In-Reply-To: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie adds scope & storage validations of C99-style for-loop
initializers.

Patch 1 replaces the current indirect test by a direct one
Patch 2-3 add test cases for the scope & storage
Patch 4-5 add missing storage validation
Patch 6 reorder default validation with the c99-for-loop one

Changes since v1:
- better log message for patch 1, thanks to Ramsay Jones

Changes since v2:
- patches 1-3 are unchanged.
- do not use 'NULL' for the default method
- limit changes to parse.c, leaving external_declaration() untouched
- use a more generic and exact name for the method
- move a check to default_process_decl()

Changes since v3:
- patches 1-3 are unchanged.
- focus the role of the method on validation
- use again 'NULL', meaning that no additional validation is needed
- remove the wrapper as it's not not needed anymore
- get around with the poor naming


Luc Van Oostenryck (6):
  replace test for c99 for-loop initializers
  add test case for scope of C99 for-loop declarations
  add test cases for storage of c99 for-loop declarations
  add an optional validation method to external_declaration()
  check the storage of C99 for-loop initializers
  move 'extern with initializer' validation after the validate method

 lib.c                          |  2 +-
 parse.c                        | 30 +++++++++++++++++++++++-------
 parse.h                        |  3 ++-
 validation/c99-for-loop-decl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 validation/c99-for-loop.c      | 36 ++++++++++++------------------------
 5 files changed, 78 insertions(+), 33 deletions(-)
 create mode 100644 validation/c99-for-loop-decl.c

-- 
2.11.1

