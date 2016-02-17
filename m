From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [FAIL 0/5] Static lock analysis
Date: Wed, 17 Feb 2016 10:51:30 +0100
Message-ID: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:46768 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756964AbcBQJvv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Feb 2016 04:51:51 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Locking can be tricky to get right and sometimes things go wrong. This
here is/was an attempt to come up with a simple static code analysis tool
which tries to point to problematic looking.

Especially figurering out if an access to variables wihtout holding
the right lock is happenin was of interest for me.

There are alot of small and bigger problems I faced and some of
them I was able to solve a lot of them not. Surprise surprise.

Anyway I learned quite a lot by doing this and maybe this epic fail
helps someone else in some way. :)

Maybe the first 3 patches might be okay to get merged.

cheers,
daniel

Daniel Wagner (5):
  parse: Add comment to struct statement
  inspect: Show context information
  linearize: Add context symbol name when showing context instructions
  parse: Add acquire, release, requires and guarded_by attributes
  test-locks: Add lock tester

 Makefile          |    3 +-
 allocate.c        |    1 +
 allocate.h        |    1 +
 ast-inspect.c     |   27 +-
 lib.c             |    2 +
 lib.h             |    7 +
 linearize.c       |    2 +-
 parse.c           |   64 ++++
 parse.h           |    2 +-
 symbol.c          |    5 +
 symbol.h          |   17 +
 test-locks.c      | 1020 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 validation/caps.c |   80 +++++
 13 files changed, 1227 insertions(+), 4 deletions(-)
 create mode 100644 test-locks.c
 create mode 100644 validation/caps.c

-- 
2.5.0

