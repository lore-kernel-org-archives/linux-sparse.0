From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/5] sparse on MinGW
Date: Tue, 21 May 2013 20:14:47 +0100
Message-ID: <519BC7A7.1040308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:33942 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752674Ab3EUT2L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 15:28:11 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hi Chris,

As I mentioned before, I ported sparse to MinGW four years ago, but
have not posted the patches here yet because they need some "tidy up"
work.

Well, I still haven't done the tidy-up, but I have decided to post
them anyway! :-D

Actually, only the first four patches are really about porting to
MinGW; the final patch just happens to fix a problem while running
sparse over git on MinGW (compat/nedmalloc/nedmalloc.c to be precise).

Patch #1 adds the __restrict__ keyword, which is used often in the
system headers.

Patch #2 actually adds support for MinGW to cgcc. Note that this only
adds support for 32-bit systems. I don't have access to a 64-bit system,
but I suspect this would require additional changes to support 64-bit.

Patch #3 fixes all of the compilation errors/warnings. This is mostly
fixing up "format specifiers" (e.g. "%llx") which gcc on MinGW does not
understand. Fixing the format specifiers involves using the macros in
the <inttypes.h> header file. However, this patch addresses other issues,
which are mostly marked by the use of "#if !defined(__MINGW32__)"
conditional blocks, and is the reason for not submitting earlier.

Patch #4 allows the test-suite to run on MinGW. [The original version of
these patches actually used calls to _setmode() to set _O_BINARY mode for
stdout and stderr so that sparse output used LF line endings, rather than
CRLF.]

ATB,
Ramsay Jones

Ramsay Jones (5):
  Add the __restrict__ keyword
  Add support for the MinGW platform
  Fix some "unknown format" warnings
  test-suite: Add -b option to ignore CR at eol on MinGW
  lib.c: Add __sync_lock_test_and_set as a builtin function

 cgcc                  | 13 +++++++++++++
 compile-i386.c        |  7 ++++---
 example.c             |  7 ++++---
 expand.c              |  5 +++--
 ident-list.h          |  2 +-
 lib.c                 |  1 +
 linearize.c           | 15 ++++++++++-----
 parse.c               |  6 ++++--
 pre-process.c         |  7 ++++++-
 show-parse.c          | 15 ++++++++++-----
 sparse.c              |  3 ++-
 tokenize.c            |  4 ++--
 validation/reserved.c |  1 +
 validation/test-suite |  2 +-
 14 files changed, 62 insertions(+), 26 deletions(-)

-- 
1.8.2

