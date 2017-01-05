From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] more testsuite improvements
Date: Thu,  5 Jan 2017 06:16:27 +0100
Message-ID: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34541 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759766AbdAEFT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Jan 2017 00:19:27 -0500
Received: by mail-wj0-f195.google.com with SMTP id qs7so40212380wjc.1
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 21:18:39 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie is a continuation of a similar previous sent in
November. It has three parts:
- patch 1: give a bit more flexibility when testing the test output,
  from test-linearize for example.
- patch 2: somehow correct a message from the testsuite
- patch 3-5: make the testsuite quieter regarding the 'known-to-fail'
  tests.


This serie can also be found as:
  git://github.com/lucvoo/sparse.git sent/testsuite2


Luc Van Oostenryck (5):
  testsuite: check the nbr of times a pattern should be present
  testsuite: use 'error' instead of 'info' for successful tests known to fail
  testsuite: get 'check-known-to-fail' earlier
  testsuite: allow quieter error reporting
  testsuite: quieter error reporting for 'known-to-fail'

 Documentation/test-suite |  4 ++++
 validation/test-suite    | 42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

