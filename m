From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 18:42:46 +0100
Message-ID: <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33320 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdHIRmr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 13:42:47 -0400
Received: by mail-vk0-f52.google.com with SMTP id j189so28299303vka.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 10:42:47 -0700 (PDT)
In-Reply-To: <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 9 August 2017 at 18:14, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 8 August 2017 at 00:35, Christopher Li <sparse@chrisli.org> wrote:
>>
>> The test-inspect knows about statements and expressions. You
>> just need to expand the right object.
>>
>
> Thanks - I will try to build this. Previously I tried using the
> test-inspect that comes with Ubuntu and unfortunately it crashes /
> doesn't work properly. Perhaps if I build the latest version it will
> be more stable.
>
> Will let you know.
>

I built the latest version (master branch) - and tried to run it. It
immediately crashes with core dump as soon as I click on anything.

Regards
Dibyendu
