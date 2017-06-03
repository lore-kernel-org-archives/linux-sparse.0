From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] normalize pseudos numbering
Date: Sat,  3 Jun 2017 09:34:13 +0200
Message-ID: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33651 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdFCHe1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 03:34:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so22053716wmh.0
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 00:34:26 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add a phase of renumbering
of all pseudos so that the pseudos' name are much less
dependent on linearization and optimization details
and thus make the output of test-linearize much more suited
for the test cases.

Luc Van Oostenryck (3):
  rename 'struct warning' to 'struct flag'
  let handle_simple_switch() handle an array of flags
  allow to normalize the pseudos

 Makefile         |   1 +
 lib.c            |  42 ++++++++++++--------
 lib.h            |   1 +
 linearize.h      |   1 +
 norm-pseudo.c    | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-linearize.c |   2 +
 test-unssa.c     |   2 +
 7 files changed, 149 insertions(+), 17 deletions(-)
 create mode 100644 norm-pseudo.c

-- 
2.13.0

