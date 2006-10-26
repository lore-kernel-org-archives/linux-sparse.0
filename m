From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Add __builtin_popcountl
Date: Thu, 26 Oct 2006 19:43:01 +0100
Message-ID: <20061026184301.GJ29920@ftp.linux.org.uk>
References: <20061026174730.GE5591@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59832 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423716AbWJZSnC
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Oct 2006 14:43:02 -0400
Content-Disposition: inline
In-Reply-To: <20061026174730.GE5591@parisc-linux.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-sparse@vger.kernel.org

On Thu, Oct 26, 2006 at 11:47:30AM -0600, Matthew Wilcox wrote:
> 
> IA-64 uses __builtin_popcountl() which wasn't a function sparse knew
> about.  This patch adds it.  I've never looked at sparse before, so this
> is a hack-and-run job.  Please feel free to rewrite it if it doesn't suit.

AFAICS, that's way over the top.  That kind of stuff is needed only
when builtin can't be described as a normal function.  This, OTOH...

diff --git a/lib.c b/lib.c
--- a/lib.c
+++ b/lib.c
@@ -467,6 +467,16 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern void __builtin_trap(void);\n");
 	add_pre_buffer("extern int __builtin_ffs(int);\n");
 	add_pre_buffer("extern void *__builtin_alloca(__SIZE_TYPE__);\n");
+	add_pre_buffer("extern int __builtin_popcount(unsigned int);\n");
+	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
+	add_pre_buffer("extern void __builtin_prefetch (const void *, ...);\n");
+	add_pre_buffer("extern long __builtin_alpha_extbl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_extwl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_insbl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_inswl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_insql(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 }
 
 void create_builtin_stream(void)
