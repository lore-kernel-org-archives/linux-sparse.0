From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Turn on -Wcontext by default
Date: Wed, 06 Sep 2006 13:10:00 -0700
Message-ID: <1157573400.4911.19.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:32394 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751546AbWIFUJv
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Sep 2006 16:09:51 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k86K9oFT026588
	for <linux-sparse@vger.kernel.org>; Wed, 6 Sep 2006 16:09:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k86K9ooG353096
	for <linux-sparse@vger.kernel.org>; Wed, 6 Sep 2006 14:09:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k86K9oCx011825
	for <linux-sparse@vger.kernel.org>; Wed, 6 Sep 2006 14:09:50 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Context checking currently requires explicitly passing the -Wcontext option.
In a Linux build, this requires passing CF=-Wcontext.  Thus, running people
running sparse over Linux or other software in the default way will not see
context warnings.  Change this by enabling -Wcontext.

While context checking does generate false positives, due to both missing
annotations on kernel functions and insufficiently clever checking in sparse,
the context warnings still do provide useful information and help track down
real bugs.  Furthermore, showing these warnings by default may incite more
people to add annotations or enhance sparse.  As a last resort, -Wno-context
will still work.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib.c b/lib.c
index cd46e03..c89ac75 100644
--- a/lib.c
+++ b/lib.c
@@ -179,7 +179,7 @@ int Wone_bit_signed_bitfield = 1;
 int Wcast_truncate = 1;
 int Wbitwise = 0;
 int Wtypesign = 0;
-int Wcontext = 0;
+int Wcontext = 1;
 int Wundefined_preprocessor = 0;
 int Wptr_subtraction_blows = 0;
 int Wcast_to_address_space = 0;
-- 
1.4.1.1
