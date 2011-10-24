From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] sparse, llvm: Fix 'void *' pointer code generation
Date: Mon, 24 Oct 2011 18:18:58 +0300
Message-ID: <CAOJsxLGM-v0n04y6OfgYcXBxNXWMheBpeP4PB_NpjBeCHW8gRw@mail.gmail.com>
References: <1319456619-11546-1-git-send-email-penberg@kernel.org>
	<CA+55aFx1=9C_QDE2CfqLp1zg_t=x+VjKUPZgj2karJsS1FAZaA@mail.gmail.com>
	<alpine.LFD.2.02.1110241455580.13879@tux.localdomain>
	<20111024121426.GA2021@debian.debian>
	<alpine.LFD.2.02.1110241532340.14239@tux.localdomain>
	<4EA580B6.4070008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55938 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869Ab1JXPS7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 11:18:59 -0400
Received: by vcge1 with SMTP id e1so4910597vcg.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 08:18:58 -0700 (PDT)
In-Reply-To: <4EA580B6.4070008@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Mon, Oct 24, 2011 at 6:13 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> Thanks for pointing that out. Jeff, does this look OK?
>
> I don't know what bit_size==-1 means off the top of my head, so I assume yes

So

  void *p;

looks as follows with test-inspect:

  0: SYM_NODE: p
    ctype.base_type: SYM_PTR: <noident>
      ctype.base_type: SYM_BASETYPE: void

[ btw, is there a text mode version of test-inspect? ]

where the SYM_BASETYPE of 'void' has -1 set as bit_size by the frontend.

                        Pekka
