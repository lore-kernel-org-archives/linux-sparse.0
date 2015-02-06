From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string expansion
Date: Fri, 6 Feb 2015 05:58:15 -0800
Message-ID: <CANeU7Q=wp=fCnKaYF+-z+AhrNW5kc+1Uu1=6DgE=9fiapd+VNA@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204020059.GA7069@macpro.local>
	<CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
	<20150204062250.GA9989@macbook.lan>
	<CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
	<CANeU7Qn2yTRxh9VzGuSYE8hGtWvVVMUvfPGQ7212NsU_eVt=vg@mail.gmail.com>
	<20150204233853.GB2275@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:64053 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbbBFN6Q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2015 08:58:16 -0500
Received: by mail-qg0-f50.google.com with SMTP id j5so11243477qga.9
        for <linux-sparse@vger.kernel.org>; Fri, 06 Feb 2015 05:58:16 -0800 (PST)
In-Reply-To: <20150204233853.GB2275@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 4, 2015 at 3:38 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Working perfectly here.
>

Any update of the string test case?

I commit a review version of the immutable string fix in review-immutable-string
branch. Compare to the last patch,  it take into account that string
can come from
macro arguments rather than macro body.

It also avoid the string copy if there is no change, that is pretty
common as well.

Care to give this version a try?

https://git.kernel.org/cgit/devel/sparse/chrisl/sparse.git/commit/?h=review-immutable-string&id=de1fa7e60d3d179a1b67c47a0429b2d0ac4e4842

Chris
