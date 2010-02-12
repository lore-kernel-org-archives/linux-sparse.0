From: Christopher Li <sparse@chrisli.org>
Subject: Re: Warnings on global symbols accessed only from assembly code
Date: Thu, 11 Feb 2010 17:06:56 -0800
Message-ID: <70318cbf1002111706n7011eecpdaeb8bb691f95087@mail.gmail.com>
References: <20100212000052.GA6837@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f178.google.com ([209.85.221.178]:49756 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0BLBG5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Feb 2010 20:06:57 -0500
Received: by qyk8 with SMTP id 8so2250217qyk.24
        for <linux-sparse@vger.kernel.org>; Thu, 11 Feb 2010 17:06:57 -0800 (PST)
In-Reply-To: <20100212000052.GA6837@laptop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Thu, Feb 11, 2010 at 4:00 PM, Ahmed S. Darwish <darwish.07@gmail.com=
> wrote:
> Hi,
>
> Is there a way to let sparse avoid emitting warnings like:
>
> =A0 symbol 'X' was not declared. Should it be static?
>
> for global methods that are only accessed from assembly files?
>

You mean other than declare it as function prototype first?
No that I know of.

The reason behind sparse is that, if this function is shared,
it should shared by some header file and declared some where.

> The reason is that a declaration for such methods - which are usually
> bootstrap ones - can given the false impression of being used by some
> C code 'somewhere'.

Sparse does not care about who call those function, C code or asm code.
Sparse don't not actually link the program so it can't know this symbol=
 is
actually externally used or not.

Personally, I don't see why you can't declare those functions even
if they are called from asm.

> Unfortunately the current `-Wno-decl' solution is a bit extreme: it
> turns off a very useful sparse feature (by design).

Right, the problem is that sparse can't tell which functions are used i=
n
asm files and only skip warning on those.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
