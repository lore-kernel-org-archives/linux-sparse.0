From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string
 expansion
Date: Thu, 5 Feb 2015 00:38:54 +0100
Message-ID: <20150204233853.GB2275@macpro.local>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
 <20150131012339.GA3460@macpro.local>
 <87386mvcxh.fsf@rasmusvillemoes.dk>
 <20150204020059.GA7069@macpro.local>
 <CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
 <20150204062250.GA9989@macbook.lan>
 <CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
 <CANeU7Qn2yTRxh9VzGuSYE8hGtWvVVMUvfPGQ7212NsU_eVt=vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:41385 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbBDXi6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 18:38:58 -0500
Received: by mail-we0-f182.google.com with SMTP id l61so4634813wev.13
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 15:38:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn2yTRxh9VzGuSYE8hGtWvVVMUvfPGQ7212NsU_eVt=vg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 04, 2015 at 08:38:19AM -0800, Christopher Li wrote:
> On Wed, Feb 4, 2015 at 12:01 AM, Christopher Li <sparse@chrisli.org> wrote:
> >
> > When the lexer process the escape char, you did not know the string
> > is wide char or not. That can be changed after the macro expansion.
> 
> With that in mind, we can't actually perform the escape char substitution
> before the pre-processor stage.
> 
> Here is an untested patch adding the immutable string to macro body.
> I need to double check if the macro arguments needs it as well.
> 
> Can you guys try it on the test case you have?
> 
> Thanks
> 
> Chris

Working perfectly here.

Greetings,
Luc
