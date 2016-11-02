From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] tests & testsuite small improvements
Date: Wed,  2 Nov 2016 22:45:04 +0100
Message-ID: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36535 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757385AbcKBVrV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 17:47:21 -0400
Received: by mail-wm0-f51.google.com with SMTP id p190so296133588wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 14:47:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie aims to improve a bit the testsuite,
especially the exactitude about what is reported.

The patches are independent of each others.

Luc Van Oostenryck (5):
  testsuite: give a proper name to the 'binary-constant' test
  testsuite: make tests known to fail effectively fail
  testsuite: report as error tests known to fail but which succeed
  testsuite: simplify the ioc-typecheck case
  testsuite: add a simple test for -Wenum-mismatch

 validation/badtype1.c        |  4 ++++
 validation/binary-constant.c |  2 +-
 validation/enum-mismatch.c   | 19 +++++++++++++++++++
 validation/ioc-typecheck.c   | 12 +++---------
 validation/struct-ns2.c      |  6 ++++++
 validation/test-suite        | 17 ++++++++++++++---
 6 files changed, 47 insertions(+), 13 deletions(-)
 create mode 100644 validation/enum-mismatch.c

-- 
2.10.1

