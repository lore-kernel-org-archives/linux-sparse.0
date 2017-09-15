From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/28] testsuite improvements
Date: Fri, 15 Sep 2017 09:13:30 +0200
Message-ID: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33043 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdIOHQH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so1975199wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:06 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains diverse small improvements to
the testsuite.


The series is also available for review in the git repository at:
  git://github.com/lucvoo/sparse.git testsuite-clean

----------------------------------------------------------------
Luc Van Oostenryck (28):
      testsuite: 'echo -n' may not be interpreted as '-n'
      testsuite: allow to test a few cases at once
      testsuite: move verbose() & error()
      testsuite: better message for pattern nbr checking
      testsuite: better message for pattern absence/presence
      testsuite: saner checking of pattern occurences
      testsuite: clearer result summary
      testsuite: check error messages first
      testsuite: saner handling of 'must_fail'
      testsuite: allow to parse several options
      testsuite: add support for -q|--quiet
      testsuite: add support for -a|--abort
      testsuite: get options from env too
      testsuite: allow --format & --single
      testsuite: remove useless selftest
      testsuite: remove useless test-be.c
      testsuite: extract disable()
      testsuite: simplify documentation
      testsuite: allow arch-specific tests
      testsuite: save screen real estate
      testsuite: add a blank line before format
      testsuite: 'quiet' must be initialized earlier
      testsuite: move up arg_file()
      testsuite: make do_format() more self-contained
      testsuite: format: saner defaults handling
      testsuite: format: strip .c from default name
      testsuite: add support for 'format -f'
      testsuite: add support for 'format -l'

 Documentation/test-suite          |  35 +++--
 validation/test-be.c              |  46 ------
 validation/test-suite             | 286 ++++++++++++++++++++++++++++++--------
 validation/testsuite-selfcheck1.c |  10 --
 validation/testsuite-selfcheck2.c |  10 --
 validation/testsuite-selfcheck3.c |  10 --
 6 files changed, 249 insertions(+), 148 deletions(-)
 delete mode 100644 validation/test-be.c
 delete mode 100644 validation/testsuite-selfcheck1.c
 delete mode 100644 validation/testsuite-selfcheck2.c
 delete mode 100644 validation/testsuite-selfcheck3.c
