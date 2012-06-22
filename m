From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Fri, 22 Jun 2012 10:59:51 -0700
Message-ID: <CANeU7Q==MEahGWuUMFKybp4FQrUn4MBn=euhvF9wcFLTKHOvRw@mail.gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
	<CANeU7Q=OHoLdD0O4o8tdcEoAjB83y+8G8mcZGuT2TduQooWkYA@mail.gmail.com>
	<BDDFC596-BA52-41EA-8C7D-D35E620F8E6B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49349 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab2FVR7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Jun 2012 13:59:52 -0400
Received: by gglu4 with SMTP id u4so1768581ggl.19
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jun 2012 10:59:51 -0700 (PDT)
In-Reply-To: <BDDFC596-BA52-41EA-8C7D-D35E620F8E6B@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jun 21, 2012 at 7:08 PM, Xi Wang <xi.wang@gmail.com> wrote:
> On Jun 21, 2012, at 6:00 PM, Christopher Li wrote:
> https://github.com/xiw/sparse/commit/7072002
>
> Then we have:
>
> =A0 =A0 =A0 =A0and.64 =A0 =A0 =A0%r2 <- %arg1, $0x1fffffff
> =A0 =A0 =A0 =A0cast.32 =A0 =A0 %r3 <- (64) %r2
> =A0 =A0 =A0 =A0ret.32 =A0 =A0 =A0%r3
>
> Does this make sense? =A0Or should we just provide an option to turn
> off all sparse simplifications, since backends usually have their own
> optimization passes?

Adding the cast from 64 to 32 bit make sense.

The sparse checker can still benefit from the simplifications. I think
it is OK we turn off those simplifications for sparse-llvm back end.

I want to have this module that, the back end can pick to chose
what kind of simplification/optimization done to the linearized
instructions.

I think the sparse-llvm back end need a different code path in the
front end for things like GEP any way.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
