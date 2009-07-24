From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in switch"
	warnings
Date: Fri, 24 Jul 2009 13:13:04 -0700
Message-ID: <70318cbf0907241313hea92354me02cae1a8d460351@mail.gmail.com>
References: <4A62338A.1060600@ramsay1.demon.co.uk>
	 <20090719140125.GA25417@feather>
	 <4A663005.5090009@ramsay1.demon.co.uk>
	 <70318cbf0907211729j51e48ca0p430d898a5cb86bc8@mail.gmail.com>
	 <4A69FC7E.7020600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:34774 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbZGXUNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Jul 2009 16:13:04 -0400
Received: by qyk34 with SMTP id 34so567942qyk.33
        for <linux-sparse@vger.kernel.org>; Fri, 24 Jul 2009 13:13:04 -0700 (PDT)
In-Reply-To: <4A69FC7E.7020600@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Jul 24, 2009 at 11:25 AM, Ramsay
Jones<ramsay@ramsay1.demon.co.uk> wrote:
> Just FYI, I had planned to fix this by implementing a local makefile
> config file (like config.mak in git), so that I could fix this issue
> locally ("out of tree").
>
> However, I was (pleasantly) surprised to find that I'd been beaten to
> the punch by Samuel Bronson in commit 8d86d0e.
>
> So I tried this local.mk file:
>
> =A0 =A0OS=3Dcygwin
> =A0 =A0CFLAGS+=3D-Wno-switch-enum
>
> This lead to the invocation of gcc I was hoping for; something like:
>
> =A0 =A0gcc ... -Wall ... -Wno-switch-enum parse.c

Yes, that works. I try the latest version of the cygwin. The gcc in
cygwin is still old enough to give the warning. I am going to leave it
as it is.

BTW, you can put some local build target in local.mk as well, not
just config changes.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
