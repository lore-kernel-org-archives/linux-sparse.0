From: Christopher Li <sparse@chrisli.org>
Subject: Re: Variable "combinations" in tokenize.c and token.h
Date: Tue, 1 May 2007 14:27:53 -0700
Message-ID: <20070501212753.GA8539@chrisli.org>
References: <4637B126.7050100@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc12.comcast.net ([206.18.177.52]:48167 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946030AbXEAWJg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 18:09:36 -0400
Content-Disposition: inline
In-Reply-To: <4637B126.7050100@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Tue, May 01, 2007 at 02:29:10PM -0700, Josh Triplett wrote:
> 
> Apart from triggering a -Wshadow warning, this seems somewhat wasteful.
> The reason appears to relate to the presence or absence of a '\0'
> terminator at the end of each item.  Does that matter?  Could
> show_special change somehow to avoid the duplication?  Alternatively,
> could the global version just include '\0' terminators?
> 
> - Josh Triplett
> 

You mean some thing like that?

Chris

Combinations string clean up

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/token.h
===================================================================
--- sparse.orig/token.h	2007-03-23 11:32:54.000000000 -0700
+++ sparse/token.h	2007-05-01 13:53:22.000000000 -0700
@@ -100,7 +100,7 @@ enum token_type {
 	"<", ">", "<=", ">="	\
 }
 
-extern unsigned char combinations[][3];
+extern unsigned char combinations[][4];
 
 enum special_token {
 	SPECIAL_BASE = 256,
Index: sparse/tokenize.c
===================================================================
--- sparse.orig/tokenize.c	2007-03-23 11:32:54.000000000 -0700
+++ sparse/tokenize.c	2007-05-01 13:54:31.000000000 -0700
@@ -59,13 +59,12 @@ static struct position stream_pos(stream
 
 const char *show_special(int val)
 {
-	static const char *combinations[] = COMBINATION_STRINGS;
 	static char buffer[4];
 
 	buffer[0] = val;
 	buffer[1] = 0;
 	if (val >= SPECIAL_BASE)
-		strcpy(buffer, combinations[val - SPECIAL_BASE]);
+		strcpy(buffer, (char *) combinations[val - SPECIAL_BASE]);
 	return buffer;
 }
 
@@ -611,7 +610,7 @@ static int drop_stream_comment(stream_t 
 	return nextchar(stream);
 }
 
-unsigned char combinations[][3] = COMBINATION_STRINGS;
+unsigned char combinations[][4] = COMBINATION_STRINGS;
 
 #define NR_COMBINATIONS (SPECIAL_ARG_SEPARATOR - SPECIAL_BASE)
 
