From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Thu, 3 Aug 2017 20:04:03 -0400
Message-ID: <CANeU7Q=bv3PxHE+ieLvfofiMey9V0StX-4XncR9uHSU7CkABnQ@mail.gmail.com>
References: <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local> <CA+55aFzif2qNMQ0xniB6ubgGJu67h25K3G9jyGHPHa6o-unjTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35682 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHDAEF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 20:04:05 -0400
Received: by mail-pg0-f49.google.com with SMTP id v189so950910pgd.2
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 17:04:05 -0700 (PDT)
In-Reply-To: <CA+55aFzif2qNMQ0xniB6ubgGJu67h25K3G9jyGHPHa6o-unjTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 3, 2017 at 6:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> That very early inlining was actually a fairly big design decision
> originally - at some point I actually wanted to allow sparse to have

What is the reason behind it?

> inline functions act as untyped "templates" that it inlined, and that
> had their types evaluated only within the context of being used.

Sound a lot like macro then. Can it do any thing macro can not do?

> I have this memory of that actually even working to some degree at
> some point (ie you could leave arguments to inline functions untyped,
> and they would take their type from the invocation). But that may have
> been with special patches.
>
> But yes, for this particular case it's apparently a horrible choice,
> exactly because it inlines very early before any actual evaluation of
> anything.

Sounds like reason to implement inline at the instruction level.
I think it should be easier to copy instructions than AST.
I recall the inline copying of AST is very error prone, e.g. forget to
copy a member of the AST struct.

Chris
