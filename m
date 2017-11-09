From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck
 target
Date: Thu, 9 Nov 2017 17:37:45 +0000
Message-ID: <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:56228 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752541AbdKIRhs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 12:37:48 -0500
In-Reply-To: <20171109170644.vn6ktpk2newq5ps3@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 09/11/17 17:06, Luc Van Oostenryck wrote:
> 
> Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> 
> BTW, selfcheck also fails when reaching sparse-llvm.c because of
> the use of CFLAGS/BASIC_CFLAGS/ALL_CFLAGS/COMMON_CFLAGS/PKG_CFLAGS.

Hmm, I used to have LLVM installed on Linux as well as cygwin, but
I didn't install it the last time I did a 'nuke-n-pave' Linux
installation. (Linux Mint is much easier to upgrade these days, which
is to say it actually works now, but that wasn't always the case!).

On cygwin, sparse-llvm.c complains for a cygwin-only reason, so it
may be that those errors a hiding the ones you are seeing. I have been
meaning to get around to fix the cygwin problems.

What kind of errors are you seeing?

ATB,
Ramsay Jones

