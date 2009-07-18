From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/5] Fix some "plain integer as NULL pointer" warnings on
 cygwin
Date: Sat, 18 Jul 2009 21:58:14 +0100
Message-ID: <4A623766.5020002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:41482 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764AbZGRVKA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:10:00 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


These sparse warnings are caused by broken new-lib headers,
which sometimes result in NULL being defined as 0, and at
other times defined as ((void *)0).

In essence, the only header which works correctly (by defining
NULL as ((void *)0)) is stddef.h. The stdio.h and time.h headers
also work, almost by accident, by indirectly including stddef.h.
The other standard headers which are required to define the NULL
macro, namely locale.h, stdlib.h, string.h and wchar.h, all
define the macro as the 0 token. (This is a slightly simplified
description of the problem).

In order to suppress these warnings, include the stddef.h header
at the start of ptrlist.c.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

$ cat -n null-test.sh
     1	#!/bin/bash
     2	
     3	# The C99 standard says that the following headers define NULL:
     4	#   locale.h (7.11), stddef.h (7.17), stdio.h (7.19.1),
     5	#   stdlib.h (7.20), string.h (7.21.1), time.h (7.23.1),
     6	#   wchar.h (7.24.1).
     7	
     8	for i in locale.h stddef.h stdio.h stdlib.h string.h time.h wchar.h
     9	do
    10		printf "%10s:  " $i
    11		printf "#include<%s>\nchar *xyz_ptr = NULL;\n" $i >t.c
    12		cgcc -E t.c | grep xyz_ptr
    13	done
    14	rm t.c
    15	
$ ./null-test.sh
  locale.h:  char *xyz_ptr = 0;
  stddef.h:  char *xyz_ptr = ((void *)0);
   stdio.h:  char *xyz_ptr = ((void *)0);
  stdlib.h:  char *xyz_ptr = 0;
  string.h:  char *xyz_ptr = 0;
    time.h:  char *xyz_ptr = ((void *)0);
   wchar.h:  char *xyz_ptr = 0;
$ 

The "slightly simplified" description above deliberately omits details
which I'm happy to illuminate if necessary; but it's not very interesting!

This is clearly not a sparse bug, but it is a simple solution to remove
the sparse warnings. Having said that, it would be good if sparse could
notice that the pre-processed source text included the NULL token, *not*
the 0 token, and not issue this warning at all. ;-)

ATB,
Ramsay Jones

 ptrlist.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 2620412..7d18862 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -5,6 +5,7 @@
  *
  * (C) Copyright Linus Torvalds 2003-2005
  */
+#include <stddef.h>
 #include <stdlib.h>
 #include <string.h>
 #include <assert.h>
-- 
1.6.3.1


