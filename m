From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] normalize bb's label names for testing
Date: Mon, 21 Nov 2016 05:14:19 +0100
Message-ID: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:33361 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbcKUETx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Nov 2016 23:19:53 -0500
Received: by mail-wj0-f180.google.com with SMTP id xy5so21611613wjc.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Nov 2016 20:19:53 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These two patches solves the testing problem of the label names
as emitted by test-linearize and others being not comparable
between runs.

Luc Van Oostenryck (2):
  testsuite: allow commands to use pipes
  testsuite: add a script to normalize label names

 validation/normalize-bb        | 16 ++++++++++++++++
 validation/test-normalize-bb.c | 31 +++++++++++++++++++++++++++++++
 validation/test-pipe-cmd.c     | 13 +++++++++++++
 validation/test-suite          |  6 +++---
 4 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100755 validation/normalize-bb
 create mode 100644 validation/test-normalize-bb.c
 create mode 100644 validation/test-pipe-cmd.c

-- 
2.10.2

