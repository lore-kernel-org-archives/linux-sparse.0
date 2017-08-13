From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 23:12:31 +0100
Message-ID: <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com> <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35430 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHMWMc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 18:12:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id j189so3607519vka.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 15:12:32 -0700 (PDT)
In-Reply-To: <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On 13 August 2017 at 22:16, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 13, 2017 at 10:20 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Additionally following fails if simplifications are turned on. I have
>> not analysed the reason yet.
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/minilua.c
>
> This 8000 lines file has a lot of header file dependencies, I'm willing to
> take a look at the preprocessed output if you send it.
>

Actually after RC5 merge there is a change in behaviour.

Previously it would would fail to compile when simplifications were turned on.
Now:

1) Without single store shortcut it fails to compile. The error generated is:

error: no result for pseudo
minilua.c:5593:24: error: failed to output instruction load.64*
%r13018 <- 16[VOID]

minilua.c:5593:24: error: failed to output load.64*    %r13018 <- 16[VOID]

2) With single store shortcut it appears to compile successfully but
when the executable is run against the 'dynasm' test the test fails.
The un-simplified version works however.

Here are the linearized outputs:

Unsimplified:
https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua.lin

Simplified with single store shortcut switched OFF:
https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua_opt.lin

Simplified with single store shortcut switched ON:
https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua_opt_sss.lin

I am not sure this helps you.

>> Note also that I have a couple of workarounds in my repository:
>>
>> http://marc.info/?l=linux-sparse&m=148953605610758&w=2
>
> Only half of the function is there. Care to send to full version?
>
>> http://marc.info/?l=linux-sparse&m=148993825216454&w=2
>
> A floating-point test program while sparse has very very poor
> fp support ... hmmm and with a header file dependencies.
> Care to send the preprocessed output?
>

Maybe we can look at these ones later ...

Regards
Dibyendu
