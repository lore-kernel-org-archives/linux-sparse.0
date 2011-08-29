From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Mon, 29 Aug 2011 11:27:22 -0400
Message-ID: <4E5BAFDA.6080407@garzik.org>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6> <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com> <CAOJsxLEMvZMX9x0s4VGx9KMPdPbcHqtg0Q=o6ivSCamC3aHUrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60749 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953Ab1H2P1Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 11:27:24 -0400
Received: by qwk3 with SMTP id 3so3383843qwk.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 08:27:24 -0700 (PDT)
In-Reply-To: <CAOJsxLEMvZMX9x0s4VGx9KMPdPbcHqtg0Q=o6ivSCamC3aHUrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

On 08/29/2011 10:22 AM, Pekka Enberg wrote:
> On Sat, Aug 27, 2011 at 11:08 PM, Pekka Enberg<penberg@kernel.org>  wrote:
>>> Jeff Garzik and myself have been hacking on LLVM backed for Sparse. The
>>> sources
>>> are available on Github:
>>>
>>>   git clone git://github.com/penberg/sparse-llvm.git
>
> On Sun, Aug 28, 2011 at 11:51 AM, Christopher Li<sparse@chrisli.org>  wrote:
>> Very impressive. That is some sparse 0.5 material.
>> I will start merging it as soon as I release 0.4.4
>>
>> I play around with it a little bit, It seems choke on the hello
>> world program. Shouldn't be hard to fix though.
>
> It's alive!
>
> $ cat validation/backend/hello.c
> #include<stdio.h>
>
> int main(int argc, char *argv[])
> {
> 	puts("hello, world");
>
> 	return 0;
> }

you should be more adventurous, and try varargs!  :)

This also works:

[WARNING: it only works if I disable optimization, for some reason]

[jgarzik@bd sparse-llvm]$ ./sparse-llvm foo.c | llc > foo.s
[jgarzik@bd sparse-llvm]$ gcc -o foo foo.s
[jgarzik@bd sparse-llvm]$ ./foo
hello, world!
[jgarzik@bd sparse-llvm]$ cat foo.c

#include <stdio.h>

int main (int argc, char *argv[])
{
	printf("%s\n", "hello, world!");

	return 0;
}


