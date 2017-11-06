From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
Date: Mon, 6 Nov 2017 20:40:19 +0100
Message-ID: <20171106194016.6prbppzwfk5zknrd@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
 <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
 <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com>
 <a91d5505-54a2-c8da-dbb3-af44f0c5f264@kleine-koenig.org>
 <CAExDi1SXfthzUonmiXCDosWyxi-snqK_+fDVMdJe_yoo_yqR0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52963 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbdKFTkW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 14:40:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id t139so16579207wmt.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 11:40:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAExDi1SXfthzUonmiXCDosWyxi-snqK_+fDVMdJe_yoo_yqR0w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 06, 2017 at 09:55:26AM +0100, Luc Van Oostenryck wrote:
> On Mon, Nov 6, 2017 at 9:44 AM, Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
> > But IMHO this should not
> > be sold as "simpler logic" without any further comment.
> 
> Yes. It's not the only patch in this series which commit message
> should be improved.

Here is the updated commit message, no changes in the patch itself:
	Subject: [PATCH v3 31/36] build: simplify quiet commands

	The current mechanism for the quiet commands, what's
	hiding the true command and emitting instead things like:
		CC      target.o
	is, IMO, somehow unneedlessly sophisticated and this doesn't help
	to understand what's happening and to adapt things when needed.
	
	Change this by using simple 'echo' commands and make's '@' to
	display the short command and hiding the long one.
	
	Warning: There is a small change in behaviour with this:
	  previously, when displaying the non-quiet commands with
	  'make V=1' the quiet ones were not emitted. Now, with this
	  patch, the short/quiet command is emitted in both case.
