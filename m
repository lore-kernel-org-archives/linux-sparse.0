From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Mon, 2 Feb 2009 20:58:14 +0000
Message-ID: <20090202205814.GF28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021217r634f94a0y46fe572091a78634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49265 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZBBU6R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 15:58:17 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0902021217r634f94a0y46fe572091a78634@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 02, 2009 at 12:17:06PM -0800, Christopher Li wrote:
> On Sun, Feb 1, 2009 at 11:30 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >        There are several interesting problems caused by the fact that
> > we create a separate symbol for each declaration of given function.
> 
> Thanks for the patch. That is great. This is actually one of the two
> hard problem in
> sparse. I haven't able to solved them. (BTW, the other one was running
> out of modifier bits.)

Modifier bits are going to get easier - I have a patch series that
takes a bunch out (basically, to hell with everything in MOD_SPECIFIER -
the only hard part is on the parser side and I've got a saner way to
deal with that).
