From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 2/2] parser: define __builtin_unreachable
Date: Tue, 13 Jul 2010 00:52:48 -0700
Message-ID: <AANLkTimf821jhfhU-Rsj7xa2S4EzuP23weoUSZVWsD2u@mail.gmail.com>
References: <AANLkTikFmeXz9og4t98jm6QcAdRa6rIeCAv3oeFnTgd8@mail.gmail.com>
	<1278751162-10053-2-git-send-email-jslaby@suse.cz>
	<20100710090705.GA14881@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61581 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0GMHwt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Jul 2010 03:52:49 -0400
In-Reply-To: <20100710090705.GA14881@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sat, Jul 10, 2010 at 2:07 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> __builtin_unreachable has special semantics beyond just a function.
> This definition will suffice to allow compilation, but
> __builtin_unreachable should have the same effect in sparse that it d=
oes
> in GCC: mark the point (and the remainder of the basic block) as
> unreachable. =A0Something like the mechanism used for handling noretu=
rn
> would work here as well; declaring the function to have attribute
> noreturn would probably have almost the right semantics.
>

The attribute noreturn will apply to the whole function. The function
NEVER returns.
__builtin_unreachable only apply to current basic block. e.g. some
error handling path like panic. The function can still return a value o=
n the
normal path. It has different meaning than attribute noreturn. So I don=
't think
automatically give the function noreturn attribute is the right thing t=
o do.

I will apply the patch until we got better way to handle this.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
