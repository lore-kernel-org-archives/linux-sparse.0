From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 06/15] Sparc64 (Sparc V9, LP64) support
Date: Mon, 15 Dec 2008 03:26:37 +0300
Message-ID: <20081215002637.16107.50800.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYLOARZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:17:25 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:17:24 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

From: Blue Swirl <blauwirbel@gmail.com>

This patch adds support for Sparc64 (Sparc V9, LP64).

Signed-off-by: Blue Swirl <blauwirbel@gmail.com>
---
 cgcc |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cgcc b/cgcc
index 31c219a..98686a7 100755
--- a/cgcc
+++ b/cgcc
@@ -243,6 +243,11 @@ sub add_specs {
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
+    } elsif ($spec eq 'sparc64') {
+	return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1 -D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
+		&integer_types (8, 16, 32, 64, 64) .
+		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
+		&define_size_t ("long unsigned int"));
     } elsif ($spec eq 'x86_64') {
 	return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' .
 		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64) .
@@ -268,6 +273,8 @@ sub add_specs {
 	    return &add_specs ('x86_64');
 	} elsif ($arch =~ /^(ppc)$/i) {
 	    return &add_specs ('ppc');
+	} elsif ($arch =~ /^(sparc64)$/i) {
+	    return &add_specs ('sparc64');
 	}
     } else {
 	die "$0: invalid specs: $spec\n";

