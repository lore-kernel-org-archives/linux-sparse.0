From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Thu, 3 Aug 2017 00:50:20 +0200
Message-ID: <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
References: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com> <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:37740 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdHBWuV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Aug 2017 18:50:21 -0400
Received: by mail-qt0-f173.google.com with SMTP id 16so35628961qtz.4
        for <linux-sparse@vger.kernel.org>; Wed, 02 Aug 2017 15:50:21 -0700 (PDT)
In-Reply-To: <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Aug 2, 2017 at 3:17 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 1, 2017 at 5:46 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> has any effects for sparse and the only effect of -O2 is
>> to define __OPTIMIZE__.
>
> Yes, indeed. It is the -O2 make the difference.
>
> I recently upgrade to Fedora 26. I think it is the system header file
> making a difference
> on the __OPTIMIZE__. I attach two files here. O2.c is the one with -O2 flag
> after processor. The 0.c is the one without.
>
> There is huge difference in them.
>
> I confirm with O2.c I am seeing the 24 second delay. And 0.c 4 seconds.
>
> I attach the two files with gzip.

It seems that the email was rejected on the mailing list.

> I think you should be able to reproduce it with O2.c now.

Yes, I can reproduce it now.
The differences in the two file are not big. Basically, in -O2 there is
- a bunch of small functions which have now an inline definition
- a set of strcmp(winetest_platform, "wine") which are replaced
  by a macro of hell.
It's, of course, the last one which creates the problem.
The macro seems to try to optimize the compare using the fact
that the compiler will statically evaluate things like:
- strlen("wine")
- "wine"[0], "wine"[1], ...
but sparse doesn't do this kind of simplification (yet) and this result
in much much more code.

A first inspection of the generated code doesn't show anything
obviously wrong but I don't exclude there is another problem.

-- Luc
