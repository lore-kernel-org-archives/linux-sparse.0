From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Signed divides vs shifts (Re: [Security] /dev/urandom uses uninit bytes, leaks user data)
Date: Mon, 17 Dec 2007 10:12:47 -0800
Message-ID: <2c0942db0712171012o613b2596x81f4a867e2b5c01@mail.gmail.com>
References: <E1J3RD5-0006yU-00@gondolin.me.apana.org.au>
	 <alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org>
	 <20071217185557.0b501e23.dada1@cosmosbay.com>
	 <2c0942db0712171005w65bbb512p71a4f9b1fc65c6a7@mail.gmail.com>
	 <20071217191017.117c61ff.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:47059 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbXLQSMv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Dec 2007 13:12:51 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1231289nfb.21
        for <linux-sparse@vger.kernel.org>; Mon, 17 Dec 2007 10:12:49 -0800 (PST)
In-Reply-To: <20071217191017.117c61ff.dada1@cosmosbay.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, John Reiser <jreiser@bitwagon.com>, Andrew Morton <akpm@linux-foundation.org>, security@kernel.org, tytso@mit.edu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mpm@selenic.com, linux-sparse@vger.kernel.org

On Dec 17, 2007 10:10 AM, Eric Dumazet <dada1@cosmosbay.com> wrote:
> On Mon, 17 Dec 2007 10:05:35 -0800
> "Ray Lee" <ray-lk@madrabbit.org> wrote:
>
> > On Dec 17, 2007 9:55 AM, Eric Dumazet <dada1@cosmosbay.com> wrote:
> > > -               mid = (last - first) / 2 + first;
> > > +       while (low <= high) {
> > > +               mid = (low + high) / 2;
> >
> > I think you just introduced a bug. Think about what happens if
> > low=high=MAX_LONG/2 + 1.
> >
>
> Fortunatly this is not possible :)
>
> Hint : sizeof(struct exception_table_entry) is >= 8
>
> so high is garanteed to be <= MAX_LONG/8

Ah, my bad. One of these days I'll learn to not post before coffee.
