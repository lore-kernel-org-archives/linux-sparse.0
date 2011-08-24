From: Chris Forbes <chrisf@ijw.co.nz>
Subject: Re: sparse and multiarch include paths
Date: Thu, 25 Aug 2011 09:48:26 +1200
Message-ID: <CAH3ygc3AsB4rcnd1onA8B6h2zRsCpXr=36oL2s71TuNuxXS12g@mail.gmail.com>
References: <20110824214244.GA12248@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53150 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1HXVs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Aug 2011 17:48:27 -0400
Received: by gya6 with SMTP id 6so1211961gya.19
        for <linux-sparse@vger.kernel.org>; Wed, 24 Aug 2011 14:48:26 -0700 (PDT)
In-Reply-To: <20110824214244.GA12248@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, debian-gcc@lists.debian.org, multiarch-devel@lists.alioth.debian.org

I've hit this as well. The ubuntu-packaged sparse seems to get this
right; building from git sources gives busted paths -- suspect they
have patches that need to come upstream?

-- Chris

On Thu, Aug 25, 2011 at 9:42 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> When trying to use sparse on some low-level userspace code, I ran int=
o
> the following error:
>
> /usr/include/bits/socket.h:381:11: error: unable to open 'asm/socket.=
h'
>
> It looks like that file lives in
> /usr/include/x86_64-linux-gnu/asm/socket.h , and gcc has
> /usr/include/x86_64-linux-gnu in its default include path. =A0This re=
lates
> to Debian's multiarch efforts, moving such headers to paths which
> include the architecture to allow simultaneous installation of the
> headers for multiple architectures. =A0I don't know how gcc ends up w=
ith
> that directory in its include path, but sparse needs to follow suit t=
o
> compile any code which includes these architecture-specific
> headers.
>
> I've CCed the Debian GCC maintainers and multiarch developers, in the
> hopes of getting some additional details that might help resolve this
> problem.
>
> - Josh Triplett
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
