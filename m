From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH 3/3 RESEND] Add -Wno-cast-truncate
Date: Tue, 29 Aug 2006 18:17:31 -0700
Message-ID: <1156900651.5203.14.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:26842 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932306AbWH3BRZ
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 21:17:25 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U1HOdU030390
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 21:17:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U1HOl7276048
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 19:17:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U1HOvI012144
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 19:17:24 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Add the ability to turn off checks for casts that truncate constant values
using -Wno-cast-truncate, helpful when attempting to track down a particular
class of warnings only without losing them amongst others.  Checks for
truncating casts default to on, so this does not change the default behavior
of sparse.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 expand.c |    4 ++++
 lib.c    |    2 ++
 lib.h    |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/expand.c b/expand.c
index 474344d..882d80e 100644
--- a/expand.c
+++ b/expand.c
@@ -94,6 +94,10 @@ Int:
 	mask = signmask | (signmask-1);
 	expr->value = value & mask;
 
+	// Stop here unless checking for truncation
+	if (!Wcast_truncate)
+		return;
+	
 	// Check if we dropped any bits..
 	oldsignmask = 1ULL << (old_size-1);
 	oldmask = oldsignmask | (oldsignmask-1);
diff --git a/lib.c b/lib.c
index 8fac8ae..fb5e54e 100644
--- a/lib.c
+++ b/lib.c
@@ -169,6 +169,7 @@ static char pre_buffer[8192];
 
 int Wdefault_bitfield_sign = 0;
 int Wone_bit_signed_bitfield = 1;
+int Wcast_truncate = 1;
 int Wbitwise = 0;
 int Wtypesign = 0;
 int Wcontext = 0;
@@ -317,6 +318,7 @@ static const struct warning {
 	{ "cast-to-as", &Wcast_to_address_space },
 	{ "decl", &Wdecl },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
+	{ "cast-truncate", &Wcast_truncate },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "undef", &Wundefined_preprocessor },
diff --git a/lib.h b/lib.h
index 0b45c67..207a8ec 100644
--- a/lib.h
+++ b/lib.h
@@ -83,6 +83,7 @@ extern int Wenum_mismatch;
 extern int Wdecl;
 extern int Wone_bit_signed_bitfield;
 extern int Wshadow;
+extern int Wcast_truncate;
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
-- 
1.4.1.1
