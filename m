From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 3] Fix core dump on huge switch
Date: Fri, 9 Feb 2007 16:16:47 -0800
Message-ID: <20070210001647.GB20644@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([206.18.177.54]:62785 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423377AbXBJAp2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:45:28 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

Bump up the size of the instruction buffer. vt_ioctl.c has
a huge switch statement causing sparse over flow the instruction
buffer.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2007-01-30 20:07:40.000000000 -0800
+++ sparse/linearize.c	2007-01-30 20:48:16.000000000 -0800
@@ -272,7 +272,7 @@ static char *show_asm(char *buf, struct 
 const char *show_instruction(struct instruction *insn)
 {
 	int opcode = insn->opcode;
-	static char buffer[1024];
+	static char buffer[4096];
 	char *buf;
 
 	buf = buffer;
@@ -457,6 +457,9 @@ const char *show_instruction(struct inst
 	default:
 		break;
 	}
+
+	if (buf >= buffer + sizeof buffer)
+		die("instruction buffer overflowed %d\n", buf - buffer);
 	do { --buf; } while (*buf == ' ');
 	*++buf = 0;
 	return buffer;
