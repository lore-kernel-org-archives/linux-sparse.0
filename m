From: Christopher Li <sparse@chrisli.org>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 16:21:27 -0400
Message-ID: <CANeU7QnGSF+88NbBR834F+Yt_B_b-VtAwRr5+oAqHKsMUDRq5Q@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
 <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
 <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
 <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com>
 <CANeU7Qk37J8WTVmzDhzjCbpmJ6cf59LNB6sX6ncRFHP=wvJFQw@mail.gmail.com>
 <CACXZuxddPW-gr+eRLqVTyJmKhVKAB2xEkzEfBbmLKHGK4h_twg@mail.gmail.com>
 <CANeU7QnT-bco_UUcXx2nTEFPR3M=zmx9i=a6vXRZyUmY6M+5vg@mail.gmail.com> <CACXZuxcBaNb40zNh1FgAbJP5nhxEU8pf09_ejnOwWWhjWS3Jwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36529 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdHIUV2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 16:21:28 -0400
Received: by mail-yw0-f169.google.com with SMTP id u207so46945794ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 13:21:28 -0700 (PDT)
In-Reply-To: <CACXZuxcBaNb40zNh1FgAbJP5nhxEU8pf09_ejnOwWWhjWS3Jwg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 4:03 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> On 9 August 2017 at 12:57, Christopher Li <sparse@chrisli.org> wrote:
>> Can you do a "ldd test-inspect"?
>>
>> Which version of Ubuntu are you using? I think I need to get one of those to
>> test it.
>>
>
> I am using ubuntu 16.04 LTS.
>
> Here is the output from ldd:
>
> ldd ./test-inspect
>     linux-vdso.so.1 =>  (0x00007ffd449d2000)
>     libgtk-x11-2.0.so.0 =>
> /usr/lib/x86_64-linux-gnu/libgtk-x11-2.0.so.0 (0x00007fbdf76d5000)
>     libgobject-2.0.so.0 =>

Thanks.

Your GTK lib looks good.

I will get a ubuntu 16.04 to reproduce it.

Thanks

Chris
