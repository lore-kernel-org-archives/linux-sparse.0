From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 00/14] testsuite improvements
Date: Mon, 13 Feb 2017 00:28:50 +0100
Message-ID: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36029 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBLX3L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so16525725wmd.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:10 -0800 (PST)
In-Reply-To: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie aimes to improve the test suite in two ways:
1) make effective use of the 'known-to-fail' tag
2) check the presence or absence of some patterns in the output file

The patches are organised like this:
- patches 1 & 3 are cleanup some tests
- patch 4 adds a test case for -Wenum-mismatch
- patch 2 & 6 make effective use of the 'known-to-fail' tag
- patches 5 & 8 check the presence or absence of the patterns
- patch 9 adds some self checking 
- patch 10 lets check the number of times a pattern occurs
- patch 11: somehow correct a message from the testsuite
- patches 12-14: make the testsuite quieter regarding the 'known-to-fail'

Changes since V1
- none, it's only a consolidation of two sub-series
- add some selfchecking (patch 9)

Luc Van Oostenryck (14):
  testsuite: give a proper name to the 'binary-constant' test
  testsuite: make tests known to fail effectively fail
  testsuite: simplify the ioc-typecheck case
  testsuite: add a simple test for -Wenum-mismatch
  testsuite: add tag to ignore the output/error
  testsuite: report as error tests known to fail but which succeed
  allow to launch the test suite from the project root dir
  testsuite: check patterns presence or absence in output
  testsuite: add some selfchecking
  testsuite: check the nbr of times a pattern should be present
  testsuite: use 'error' instead of 'info' for successful tests known to fail
  testsuite: get 'check-known-to-fail' earlier
  testsuite: allow quieter error reporting
  testsuite: quieter error reporting for 'known-to-fail'

 Documentation/test-suite          |  20 +++++++
 validation/badtype1.c             |   4 ++
 validation/binary-constant.c      |   2 +-
 validation/enum-mismatch.c        |  19 ++++++
 validation/ioc-typecheck.c        |  12 +---
 validation/struct-ns2.c           |   6 ++
 validation/test-suite             | 119 ++++++++++++++++++++++++++++++++++----
 validation/testsuite-selfcheck1.c |  10 ++++
 validation/testsuite-selfcheck2.c |  10 ++++
 validation/testsuite-selfcheck3.c |  10 ++++
 10 files changed, 192 insertions(+), 20 deletions(-)
 create mode 100644 validation/enum-mismatch.c
 create mode 100644 validation/testsuite-selfcheck1.c
 create mode 100644 validation/testsuite-selfcheck2.c
 create mode 100644 validation/testsuite-selfcheck3.c

-- 
2.11.0

