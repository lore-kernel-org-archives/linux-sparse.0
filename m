From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] cgcc: handle ppc arch
Date: Wed, 02 Apr 2008 18:00:34 +0200
Message-ID: <1207152034.3957.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:60159 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYDCKLq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Apr 2008 06:11:46 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse <linux-sparse@vger.kernel.org>

I'm not sure this is exactly the right thing to do because I'm
unfamiliar with the default CFLAGS, but it seems to at least make it
mostly work on powerpc.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
In particular, I don't know what that _STRING_ARCH_unaligned thing is
and whether I should define it to 0 or 1 (and why I need it at all.)

--- a/cgcc
+++ b/cgcc
@@ -241,6 +241,11 @@ sub add_specs {
 		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m32 ? "unsigned int" : "long unsigned int"));
+    } elsif ($spec eq 'ppc') {
+	return (' -D__powerpc__=1 -D_BIG_ENDIAN -D_STRING_ARCH_unaligned=1' .
+		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
+		&float_types (1, 1, 21, [24,8], [53,11], [113,15]) .
+		&define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
     } elsif ($spec eq 'host_os_specs') {
 	my $os = `uname -s`;
 	chomp $os;
@@ -254,6 +259,8 @@ sub add_specs {
 	    return &add_specs ('sparc');
 	} elsif ($arch =~ /^(x86_64)$/i) {
 	    return &add_specs ('x86_64');
+	} elsif ($arch =~ /^(ppc)$/i) {
+	    return &add_specs ('ppc');
 	}
     } else {
 	die "$0: invalid specs: $spec\n";


