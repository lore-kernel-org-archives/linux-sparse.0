From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse context warning on 0.5.0
Date: Sat, 11 Oct 2014 10:14:00 +0800
Message-ID: <CANeU7Qn68zSjRJ9oVmYJm4cw9qyRqyXWUr4gp2sCdKsZ-XrYyw@mail.gmail.com>
References: <4801d85f4f4c4f97ba83a075fc9a80b4@BY1PR0701MB1240.namprd07.prod.outlook.com>
	<CANeU7Qk8E2pGANy1f8fXCeTwC1u0tE9HPT1FZqf_DGoASXF0rw@mail.gmail.com>
	<4f5fd314ec274d16816d5cf17dd2cdfd@BY1PR0701MB1240.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36653 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaJKCOA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Oct 2014 22:14:00 -0400
Received: by mail-qc0-f170.google.com with SMTP id m20so2904688qcx.1
        for <linux-sparse@vger.kernel.org>; Fri, 10 Oct 2014 19:14:00 -0700 (PDT)
In-Reply-To: <4f5fd314ec274d16816d5cf17dd2cdfd@BY1PR0701MB1240.namprd07.prod.outlook.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Franco, Scott" <Scott.Franco@caviumnetworks.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Sat, Oct 11, 2014 at 9:52 AM, Franco, Scott
<Scott.Franco@caviumnetworks.com> wrote:
> Chistopher,
>
> Thanks for looking at my issue. I've been running it via the kernel make (make c=1),
> So I'll figure out how to strip it out of the make and get back to you (I suspect the
> Easiest way is to make --dry it and use the output).
>

There should be a ".octeon_poll.o.cmd" inside the same directory where
you generate
the octeon_poll.o file. The first line of that file contain the build
command of gcc.

You can copy that to a new shell script and edit it a little bit to
invoke gcc -E with
the same command line argument, without using the kbuild.

Chris
