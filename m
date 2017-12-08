From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/16] testsuite improvements
Date: Fri,  8 Dec 2017 14:14:39 +0100
Message-ID: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:44673 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdLHNPL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:11 -0500
Received: by mail-wm0-f54.google.com with SMTP id t8so3244521wmc.3
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:10 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a few fixes & improvements to the
testsuite; mainly:
- allow to run the testsuite on all the tests of a subdir
- teach 'format' to directly append to the testcase
- validate the 'check-...' tags

Luc Van Oostenryck (16):
  testsuite: make the '%.t' rule depends on PROGRAMS too
  testsuite: fix a few more incorrect check-commands
  testsuite: convert to the new pattern syntax
  testsuite: remove old ugly pattern syntax
  testsuite: move verbose/error() before get_tag_value()
  testsuite: add & use warning()
  testsuite: reset 'quiet' at the start of each testcase
  testsuite: fix invalid 'check-...' tags
  testsuite: validate the 'check-...' tags
  testsuite: early return in getopt loop
  testsuite: move do_test_suite out of the getopt loop
  testsuite: move no-arg out of the getopt loop
  testsuite: change do_usage text
  testsuite: allow to test only a subdir
  testsuite: default to shift in the getopt loop
  testsuite: add support for 'format -a'

 Makefile                          |   2 +-
 validation/cond-address.c         |   2 +-
 validation/cond-err-expand.c      |   2 +-
 validation/fp-ops.c               |   2 +-
 validation/fp2i-cast.c            |   2 +-
 validation/nested-declarator.c    |   4 +-
 validation/nested-declarator2.c   |   4 +-
 validation/optim/canonical-cmp.c  |   2 +-
 validation/optim/canonical-fcmp.c |   2 +-
 validation/option-parsing-00.c    |   2 +-
 validation/option-parsing-01.c    |   2 +-
 validation/reserved.c             |   4 +-
 validation/test-suite             | 149 +++++++++++++++++++-------------------
 validation/typedef_shadow.c       |   4 +-
 14 files changed, 92 insertions(+), 91 deletions(-)

-- 
2.15.0

