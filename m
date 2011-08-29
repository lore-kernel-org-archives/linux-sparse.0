From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Mon, 29 Aug 2011 17:22:47 +0300
Message-ID: <CAOJsxLEMvZMX9x0s4VGx9KMPdPbcHqtg0Q=o6ivSCamC3aHUrg@mail.gmail.com>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
	<CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65474 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1H2OWs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 10:22:48 -0400
Received: by iabu26 with SMTP id u26so528481iab.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 07:22:47 -0700 (PDT)
In-Reply-To: <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

On Sat, Aug 27, 2011 at 11:08 PM, Pekka Enberg <penberg@kernel.org> wro=
te:
>> Jeff Garzik and myself have been hacking on LLVM backed for Sparse. =
The
>> sources
>> are available on Github:
>>
>> =A0git clone git://github.com/penberg/sparse-llvm.git

On Sun, Aug 28, 2011 at 11:51 AM, Christopher Li <sparse@chrisli.org> w=
rote:
> Very impressive. That is some sparse 0.5 material.
> I will start merging it as soon as I release 0.4.4
>
> I play around with it a little bit, It seems choke on the hello
> world program. Shouldn't be hard to fix though.

It's alive!

$ cat validation/backend/hello.c
#include <stdio.h>

int main(int argc, char *argv[])
{
	puts("hello, world");

	return 0;
}

/*
 * check-name: 'hello, world' code generation
 * check-command: ./sparsec -c $file -o tmp.o
 */
$ ./sparsec -c validation/backend/hello.c -o tmp.o && gcc tmp.o && ./a.=
out
hello, world

You can find details in this commit:

https://github.com/penberg/sparse-llvm/commit/deb11bd4ee6ed46bce6a5e35a=
69ada519d81a0a8

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
