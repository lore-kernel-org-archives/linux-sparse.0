From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Sun, 24 Nov 2013 20:49:41 +0100
Message-ID: <1385322581.23961.5.camel@jlt4.sipsolutions.net>
References: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
	 (sfid-20131115_074628_306752_07E6E031)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35036 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab3KXTto (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Nov 2013 14:49:44 -0500
In-Reply-To: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com> (sfid-20131115_074628_306752_07E6E031)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Andi Kleen <ak@linux.intel.com>
Cc: linux-sparse@vger.kernel.org

On Fri, 2013-11-15 at 14:46 +0800, Wei Yongjun wrote:
> After the following kernel commit, sparse warning lot of
> EXPORT_SYMBOL()'d symbol non-static like this:
> 
>   CHECK   net/sctp/socket.c
> net/sctp/socket.c:4292:1: warning:
>  symbol '__ksymtab_sctp_do_peeloff' was not declared. Should it be static?

> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Wed Oct 23 10:57:58 2013 +1030
> 
>     asmlinkage, module: Make ksymtab and kcrctab symbols and __this_module __visible
>     
>     Make the ksymtab symbols for EXPORT_SYMBOL visible.
>     This prevents the LTO compiler from adding a .NUMBER prefix,
>     which avoids various problems in later export processing.

> Any idea?

Well, sparse is clearly "right", for all it cares it might very well be
static, but it seems this is necessary for something in the kernel and
we clearly can't forward-declare it in a header file. Perhaps we can add
some annotation to say
"__attribute__((yes_I_know_but_really_dont_want_this_to_be_static))" to
suppress this warning? This is getting annoying to me as well :-)

johannes

