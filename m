From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Multiple translation unit regression
Date: Sat, 18 Jul 2009 21:26:23 +0100
Message-ID: <4A622FEF.2010704@ramsay1.demon.co.uk>
References: <4A5131F4.7070007@ramsay1.demon.co.uk>	 <70318cbf0907060232j7067f7fcra857b71ebdf62348@mail.gmail.com>	 <70318cbf0907062327u51a4253fub2c0f1b2f64c1a@mail.gmail.com>	 <4A54F452.8030601@ramsay1.demon.co.uk>	 <70318cbf0907081315w1e066a1fiac24b1b58ef146bb@mail.gmail.com>	 <4A57AA66.4080305@ramsay1.demon.co.uk> <70318cbf0907101627w1b9760a4oc7d13969751e3d00@mail.gmail.com> <4A5B7257.9090409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070204070908000208010502"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:41055 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609AbZGRVJq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:09:46 -0400
In-Reply-To: <4A5B7257.9090409@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070204070908000208010502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ramsay Jones wrote:
> Christopher Li wrote:
>> I attach the patch follows. Can you give it a try?
>>
> 
> Yep, this works.
> Tested on cygwin and Linux.
> 
> Thanks!
> 

BTW, I forgot to mention that I changed the test file so that
it would fail before applying the rest of this patch, and
pass afterward.

I've attached the new file. The diff is as follows:

-->8--
diff --git a/validation/extern-inline.c b/validation/extern-inline.c
index 13af438..4f12ac0 100644
--- a/validation/extern-inline.c
+++ b/validation/extern-inline.c
@@ -17,6 +17,7 @@ g(int x)
 
 /*
  * check-name: extern inline function
+ * check-command: sparse $file $file
  * check-description: Extern inline function never emits stand alone copy
  * of the function. It allows multiple such definitions in different file.
  */
-->8--

HTH.

ATB,
Ramsay Jones


--------------070204070908000208010502
Content-Type: text/plain;
 name="extern-inline.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extern-inline.c"

extern __inline__ int f(int);

extern __inline__ int
f(int x)
{
        return x;
}

extern int g(int);

extern __inline__ int
g(int x)
{
        return x;
}


/*
 * check-name: extern inline function
 * check-command: sparse $file $file
 * check-description: Extern inline function never emits stand alone copy
 * of the function. It allows multiple such definitions in different file.
 */

--------------070204070908000208010502--

