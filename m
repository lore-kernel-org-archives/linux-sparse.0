From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/4] chrisl master branch patches
Date: Sat, 11 Oct 2014 20:55:15 +0100
Message-ID: <54398B23.8080501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:46108 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751006AbaJKTz0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Oct 2014 15:55:26 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hi Chris,

I noticed, this afternoon, that you have pushed new patches to your
public repo on kernel.org (including most of the patches from my
'misc sparse patches' series). After a quick test, I noticed a few
minor problems (see first two patches).

I don't know how you like to manage your public repo, but if you
don't mind re-winding your master branch, then you could squash
patch #1 into commit e23abfd and patch #2 into fe57afa.

The third patch is actually a re-send of one I sent separately
after the 10 patch series.

The final patch is a possible alternative to "[PATCH 04/10]
compile-i386.c: don't mix calls to write(2) with stdio", which
basically just removes the compile program. If you prefer
another solution, just let me know.

[Note: I have been living with the RFC patch #10 for quite a
while now with no problems. However, it was just a quick hack
to speed up cgcc/sparse on Cygwin and, on reflection, not a
good reason to introduce a sparse configuration file! Also, the
use of the perl language for the config file can be viewed as
a bit cute (too cute for some people). I will probably keep it
as a locally applied patch on cygwin (it is a noticeable speedup
on cygwin), but remove it on Linux.]

Ramsay Jones (4):
  test-suite: remove bashism to avoid test failures
  cgcc: avoid passing a sparse-only option to cc
  parse.c: remove duplicate 'may_alias' ignored_attributes
  compile: remove the unmaintained compile program

 .gitignore            |    1 -
 Makefile              |    4 +-
 cgcc                  |    4 +-
 compile-i386.c        | 2407 -------------------------------------------------
 compile.c             |   84 --
 compile.h             |   10 -
 parse.c               |    2 -
 validation/test-suite |    2 +-
 8 files changed, 4 insertions(+), 2510 deletions(-)
 delete mode 100644 compile-i386.c
 delete mode 100644 compile.c
 delete mode 100644 compile.h

-- 
2.1.0
