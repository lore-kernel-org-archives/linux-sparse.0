From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] sparse, llvm: Fix 'void *' pointer code generation
Date: Mon, 24 Oct 2011 14:14:26 +0200
Message-ID: <20111024121426.GA2021@debian.debian>
References: <1319456619-11546-1-git-send-email-penberg@kernel.org>
 <CA+55aFx1=9C_QDE2CfqLp1zg_t=x+VjKUPZgj2karJsS1FAZaA@mail.gmail.com>
 <alpine.LFD.2.02.1110241455580.13879@tux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:39961 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932130Ab1JXMOb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 08:14:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110241455580.13879@tux.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Mon, Oct 24, 2011 at 02:56:41PM +0300, Pekka Enberg wrote:
> Fix the issue by switching to LLVMIntType(bits_per_pointer) in
> sym_basetype_type().

You didn't update the commit message.

--
Jonathan Neusch=C3=A4fer
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
