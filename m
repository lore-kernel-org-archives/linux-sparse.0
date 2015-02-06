From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string expansion
Date: Fri, 06 Feb 2015 21:32:32 +0100
Message-ID: <878ugapyqn.fsf@rasmusvillemoes.dk>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204020059.GA7069@macpro.local>
	<CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
	<20150204062250.GA9989@macbook.lan>
	<CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
	<CANeU7Qn2yTRxh9VzGuSYE8hGtWvVVMUvfPGQ7212NsU_eVt=vg@mail.gmail.com>
	<20150204233853.GB2275@macpro.local>
	<CANeU7Q=wp=fCnKaYF+-z+AhrNW5kc+1Uu1=6DgE=9fiapd+VNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:42300 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbBFUcg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2015 15:32:36 -0500
Received: by labhs14 with SMTP id hs14so3530311lab.9
        for <linux-sparse@vger.kernel.org>; Fri, 06 Feb 2015 12:32:34 -0800 (PST)
In-Reply-To: <CANeU7Q=wp=fCnKaYF+-z+AhrNW5kc+1Uu1=6DgE=9fiapd+VNA@mail.gmail.com>
	(Christopher Li's message of "Fri, 6 Feb 2015 05:58:15 -0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Feb 06 2015, Christopher Li <sparse@chrisli.org> wrote:

> On Wed, Feb 4, 2015 at 3:38 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> Working perfectly here.
>>
>
> Any update of the string test case?
>
> I commit a review version of the immutable string fix in review-immutable-string
> branch. Compare to the last patch,  it take into account that string
> can come from
> macro arguments rather than macro body.
>
> It also avoid the string copy if there is no change, that is pretty
> common as well.
>
> Care to give this version a try?
>
> https://git.kernel.org/cgit/devel/sparse/chrisl/sparse.git/commit/?h=review-immutable-string&id=de1fa7e60d3d179a1b67c47a0429b2d0ac4e4842

Sorry for taking so long to reply. This seems to work for the cases I
can think of, but I haven't put it to the real test yet (whether the
format strings are going to be messed up).

Rasmus
