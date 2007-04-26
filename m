From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: sparse preprocessing confused
Date: Thu, 26 Apr 2007 23:38:52 +0900
Message-ID: <20070426143852.GB13111@daikokuya.co.uk>
References: <20070425164355.2c250388.rdunlap@xenotime.net> <118833cc0704251652r28f2431cs145a993e783a58bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7498 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1031229AbXDZOpR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Apr 2007 10:45:17 -0400
Content-Disposition: inline
In-Reply-To: <118833cc0704251652r28f2431cs145a993e783a58bc@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

Morten Welinder wrote:-

> On 4/25/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> >Although this may just be a case of "it's fugly, kill it".
> >
> >In net/core/skbuff.c (2.6.21-rc7-mm1), we have:
> >
> >        memcpy(data + nhead, skb->head,
> >#ifdef NET_SKBUFF_DATA_USES_OFFSET
> >                skb->tail);
> >#else
> >                skb->tail - skb->head);
> >#endif
> 
> If memcpy happens to be a macro, that is not valid C.

It's undefined rather than invalid.  GCC makes an effort to
do "what you'd expect".

Neil.
