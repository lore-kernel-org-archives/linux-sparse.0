From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Warning message when using sparse
Date: Fri, 09 Jul 2010 22:47:21 +0200
Message-ID: <4C378AD9.1070602@gmail.com>
References: <4C3680D1.5070601@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63989 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab0GIUra (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Jul 2010 16:47:30 -0400
In-Reply-To: <4C3680D1.5070601@lwfinger.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 07/09/2010 03:52 AM, Larry Finger wrote:
> On recent kernels, sparse reports the following message for every source
> file that is processed. The warning does not seem to affect the results.
> I'm not sure when the problem started, but I think it was with 2.6.35-rc1.
> 
> 
>   CHECK   drivers/staging/rtl8712/rtl871x_rf.c
> /home/finger/linux-2.6/arch/x86/include/asm/cpufeature.h:297:21: error:
> Expected ( after asm
> /home/finger/linux-2.6/arch/x86/include/asm/cpufeature.h:297:21: error:
> got goto
> 

Yeah, I posted a support for that already:
http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=summary

The patch is not 100% correct, it doesn't support asm volatile goto and
similar.

What distro you use? I will fix it in opensuse (which provide gcc 4.5
already), if there will be no new release of sparse.

regards,
-- 
js
