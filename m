From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: Signed divides vs shifts (Re: [Security] /dev/urandom uses
 uninit bytes, leaks user data)
Date: Mon, 17 Dec 2007 19:10:17 +0100
Message-ID: <20071217191017.117c61ff.dada1@cosmosbay.com>
References: <E1J3RD5-0006yU-00@gondolin.me.apana.org.au>
	<alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org>
	<20071217185557.0b501e23.dada1@cosmosbay.com>
	<2c0942db0712171005w65bbb512p71a4f9b1fc65c6a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfx2.jmh.fr ([194.153.89.55]:41638 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756966AbXLQSKU (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Dec 2007 13:10:20 -0500
In-Reply-To: <2c0942db0712171005w65bbb512p71a4f9b1fc65c6a7@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, John Reiser <jreiser@bitwagon.com>, Andrew Morton <akpm@linux-foundation.org>, security@kernel.org, tytso@mit.edu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mpm@selenic.com, linux-sparse@vger.kernel.org

On Mon, 17 Dec 2007 10:05:35 -0800
"Ray Lee" <ray-lk@madrabbit.org> wrote:

> On Dec 17, 2007 9:55 AM, Eric Dumazet <dada1@cosmosbay.com> wrote:
> > -               mid = (last - first) / 2 + first;
> > +       while (low <= high) {
> > +               mid = (low + high) / 2;
> 
> I think you just introduced a bug. Think about what happens if
> low=high=MAX_LONG/2 + 1.
> 

Fortunatly this is not possible :)

Hint : sizeof(struct exception_table_entry) is >= 8

so high is garanteed to be <= MAX_LONG/8
