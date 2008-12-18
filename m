From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 06:11:13 +0300
Message-ID: <f19298770812171911u1e7e3cc0i11d33544cd519fea@mail.gmail.com>
References: <20081217190534.24084.94887.stgit@zaytsev.su>
	 <49498C67.4000700@cowlark.com>
	 <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com>
	 <4949A306.2060200@knosof.co.uk> <4949ACDF.50209@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:30198 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYLRDLP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Dec 2008 22:11:15 -0500
Received: by fg-out-1718.google.com with SMTP id 19so98019fgg.17
        for <linux-sparse@vger.kernel.org>; Wed, 17 Dec 2008 19:11:13 -0800 (PST)
In-Reply-To: <4949ACDF.50209@knosof.co.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Thu, Dec 18, 2008 at 04:52, Derek M Jones <derek@knosof.co.uk> wrote:
> All,
>
>> I have reported the bug in gcc.  Track Bug: 38563
>> at: gcc.gnu.org/bugzilla
>
> A very prompt response from a gcc maintainer, bug 38563
> is a duplicate of bug 22086.
>
> "This is a GCC extension. sizeof(void) is invalid C and should error out
> and does with -pedantic-errors"
>
> Yuk, who ever thought to use -pedantic-errors!
>
> -ansi or -std=c89 or -std=c99 don't elicit any diagnostics.

I don't really see why you take this as a tragedy. People seem
to like this extension:
linux/linux-2.6$ make -j 8 CC='gcc -Wpointer-arith' 2>&1 | grep
'warning: pointer of type \'void \*\' used in arithmetic' | uniq | wc
-l
45095

And anyway, that's how gcc works, so sparse can only follow.

P.S:
Dear sir, can you imagine, in Russia, they put pieces of lemon
in their tea! And you worry about gcc being wrong.
/humor
