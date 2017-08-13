From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 15:24:34 +0100
Message-ID: <CACXZuxd20hDJFX8z3F=782qqyQUwMe0LoZgq5eUh1LTAm1kicA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
 <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com> <CACXZuxejatWcHmdm_aczwdZBssv=R0q+vJ2dANsYT5snJLDHSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33416 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdHMOYf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 10:24:35 -0400
Received: by mail-ua0-f173.google.com with SMTP id 80so29267239uas.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 07:24:35 -0700 (PDT)
In-Reply-To: <CACXZuxejatWcHmdm_aczwdZBssv=R0q+vJ2dANsYT5snJLDHSA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On 13 August 2017 at 14:54, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 13 August 2017 at 14:18, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> On 13 August 2017 at 14:10, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> On Sun, Aug 13, 2017 at 2:56 PM, Dibyendu Majumdar
>>> <mobile@majumdar.org.uk> wrote:
>>>> I am merging and testing this in my repository. I notice that after
>>>> applying the changes related to killing of BBs - there is a
>>>> significant slow down in Sparse.
>>>>
>>>> Before the merge:
>>>>
>>>> real: 4.3 minutes
>>>> user: 4.1 minutes
>>>>
>>>> After the merge:
>>>>
>>>> real: 18.9 minutes
>>>> user: 18.7 minutes
>>>>
>>>> I just noticed this and these are my initial tests. But I thought it
>>>> worth letting you know.
>>>
>> Yes apologies I should have mentioned the test case:
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/lcc/cq.c
>>
>> I am checking whether the slowdown is due to some other factor such as:
>>
>> a) Build options - I need to check whether my build is an optimized
>> build or not.
>
> I had optimizations switched off - but with -O2, results are not good either:
>
> Before merge:
>
> real: 1.6 minutes
> user: 1.5 minutes
>
> After merge:
>
> real: 8.3 minutes
> user: 8.2 minutes
>

Apologies all - these times are in seconds - not minutes.

Regards
