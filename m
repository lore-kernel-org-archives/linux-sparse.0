From: Alexey zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 0/4] Proper gcc header dir handling in sparse.
Date: Mon, 08 Dec 2008 12:20:32 +0300
Message-ID: <20081208091817.15890.27981.stgit@xl0.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:26734 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbYLHJLZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Dec 2008 04:11:25 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1611560qba.17
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2008 01:11:24 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Josh Triplett <josh@freedesktop.org>

[Resending with correct ml address. Sorry.]

Hello.

People have convinced me that sparse should take
gcc base directory as a run-time parameter, so it
could be used with gcc versions differing from the
one sparse was compiled with.
So here it goes, along with some related fixes.

The patches may also be pulled from

       git://git.zaytsev.su/git/sparse.git git-base-dir

Also, the first two patches should fix the Debian bug 505177:

       http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=505177

---

Alexey zaytsev (4):
      Set gcc include path at runtime.
      Let cgcc pass -gcc-base-dir to sparse.
      Document -gcc-base-dir in sparse.1
      Rename dirafter to idirafter.


 Makefile      |    7 ++--
 cgcc          |   14 ++++++++
 lib.c         |   30 ++++++++++++-----
 pre-process.c |   98 +++++++++++++++++++++++++++++++++++++++++++++------------
 sparse.1      |    5 +++
 5 files changed, 119 insertions(+), 35 deletions(-)

-- 
