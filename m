From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add -Wno-address-space
Date: Fri, 21 Jul 2006 19:35:09 -0700
Message-ID: <1153535709.1797.3.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:7578 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751129AbWGVCfI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 21 Jul 2006 22:35:08 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6M2Z74I030116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 22:35:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6M2Z7HA081118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 20:35:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6M2Z7J6004251
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 20:35:07 -0600
Received: from IBM-882E9B45D97.beaverton.ibm.com (IBM-882E9B45D97.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6M2Z6Ld004103
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 20:35:06 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
index ad19696..84d0647 100644
--- a/lib.c
+++ b/lib.c
@@ -177,6 +177,7 @@ int Wptr_subtraction_blows = 0;
 int Wcast_to_address_space = 0;
 int Wdecl = 0;
 int Wtransparent_union = 1;
+int Waddress_space = 1;
 int preprocess_only;
 char *include;
 int include_fd = -1;
@@ -321,6 +322,7 @@ static const struct warning {
 	{ "typesign", &Wtypesign },
 	{ "context", &Wcontext },
 	{ "transparent-union", &Wtransparent_union },
+	{ "address-space", &Waddress_space },
 };
 

diff --git a/lib.h b/lib.h
index a61b2dd..e6b9bfa 100644
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
