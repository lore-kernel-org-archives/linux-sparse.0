From: Chris Wedgwood <cw@f00f.org>
Subject: Re: sparse preprocessing confused
Date: Sat, 28 Apr 2007 22:41:43 -0700
Message-ID: <20070429054143.GA15365@tuatara.stupidest.org>
References: <20070425164355.2c250388.rdunlap@xenotime.net> <118833cc0704251652r28f2431cs145a993e783a58bc@mail.gmail.com> <20070426143852.GB13111@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:34912 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756192AbXD2Fs0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Apr 2007 01:48:26 -0400
Content-Disposition: inline
In-Reply-To: <20070426143852.GB13111@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Morten Welinder <mwelinder@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Thu, Apr 26, 2007 at 11:38:52PM +0900, Neil Booth wrote:

> > >        memcpy(data + nhead, skb->head,
> > >#ifdef NET_SKBUFF_DATA_USES_OFFSET
> > >                skb->tail);
> > >#else
> > >                skb->tail - skb->head);
> > >#endif
> >
> > If memcpy happens to be a macro, that is not valid C.
>
> It's undefined rather than invalid.  GCC makes an effort to
> do "what you'd expect".

I think I prefer sparse breaking on things like this (so we can find
such uglies and correct them.).
