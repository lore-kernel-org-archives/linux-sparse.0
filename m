From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sparse, llvm: Fix 'void *' pointer code generation
Date: Mon, 24 Oct 2011 11:13:58 -0400
Message-ID: <4EA580B6.4070008@garzik.org>
References: <1319456619-11546-1-git-send-email-penberg@kernel.org> <CA+55aFx1=9C_QDE2CfqLp1zg_t=x+VjKUPZgj2karJsS1FAZaA@mail.gmail.com> <alpine.LFD.2.02.1110241455580.13879@tux.localdomain> <20111024121426.GA2021@debian.debian> <alpine.LFD.2.02.1110241532340.14239@tux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65058 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab1JXPOB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 11:14:01 -0400
Received: by mail-vx0-f174.google.com with SMTP id e1so4904973vcg.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 08:14:01 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1110241532340.14239@tux.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, Linus Torvalds <torvalds@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On 10/24/2011 08:33 AM, Pekka Enberg wrote:
>> On Mon, Oct 24, 2011 at 02:56:41PM +0300, Pekka Enberg wrote:
>>> Fix the issue by switching to LLVMIntType(bits_per_pointer) in
>>> sym_basetype_type().
>
> On Mon, 24 Oct 2011, Jonathan Neusch=C3=A4fer wrote:
>> You didn't update the commit message.
>
> Thanks for pointing that out. Jeff, does this look OK?

I don't know what bit_size=3D=3D-1 means off the top of my head, so I a=
ssume=20
yes ;-)

	Jeff




--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
