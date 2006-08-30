From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH 1/3 RESEND] Add -Wno-address-space
Date: Tue, 29 Aug 2006 18:17:16 -0700
Message-ID: <1156900636.5203.10.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:37081 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932266AbWH3BRK
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 21:17:10 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U1HA11030032
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 21:17:10 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U1HAMb356712
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 19:17:10 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U1H9Zd008674
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 19:17:10 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Add the ability to turn off address-space mismatch warnings using
-Wno-address-space, helpful when attempting to track down a particular class
of warnings only without losing them amongst others.  Address space checking
defaults to on, so this does not change the default behavior of sparse.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 evaluate.c |    2 +-
 lib.c      |    2 ++
 lib.h      |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2561f38..c5d2526 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -681,7 +681,7 @@ const char * type_difference(struct symb
 			return "different base types";
 
 		/* Must be same address space to be comparable */
-		if (as1 != as2)
+		if (Waddress_space && as1 != as2)
 			return "different address spaces";
 
 		/* Ignore differences in storage types or addressability */
diff --git a/lib.c b/lib.c
index feb755a..61c35b3 100644
--- a/lib.c
+++ b/lib.c
@@ -178,6 +178,7 @@ int Wcast_to_address_space = 0;
 int Wdecl = 0;
 int Wtransparent_union = 1;
 int Wshadow = 0;
+int Waddress_space = 1;
 int preprocess_only;
 char *include;
 int include_fd = -1;
@@ -323,6 +324,7 @@ static const struct warning {
 	{ "context", &Wcontext },
 	{ "transparent-union", &Wtransparent_union },
 	{ "shadow", &Wshadow },
+	{ "address-space", &Waddress_space },
 };
 

diff --git a/lib.h b/lib.h
index a248c08..24dd38f 100644
--- a/lib.h
+++ b/lib.h
@@ -77,6 +77,7 @@ extern int Wdefault_bitfield_sign;
 extern int Wundefined_preprocessor;
 extern int Wbitwise, Wtypesign, Wcontext;
 extern int Wtransparent_union;
+extern int Waddress_space;
 extern int Wcast_to_address_space;
 extern int Wdecl;
 extern int Wone_bit_signed_bitfield;
-- 
1.4.1.1
