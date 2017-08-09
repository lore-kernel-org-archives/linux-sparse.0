From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Wed, 9 Aug 2017 13:03:06 -0700
Message-ID: <CACXZuxcBaNb40zNh1FgAbJP5nhxEU8pf09_ejnOwWWhjWS3Jwg@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
 <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
 <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
 <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com>
 <CANeU7Qk37J8WTVmzDhzjCbpmJ6cf59LNB6sX6ncRFHP=wvJFQw@mail.gmail.com>
 <CACXZuxddPW-gr+eRLqVTyJmKhVKAB2xEkzEfBbmLKHGK4h_twg@mail.gmail.com> <CANeU7QnT-bco_UUcXx2nTEFPR3M=zmx9i=a6vXRZyUmY6M+5vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32907 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdHIUDH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 16:03:07 -0400
Received: by mail-vk0-f48.google.com with SMTP id j189so29639137vka.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 13:03:07 -0700 (PDT)
In-Reply-To: <CANeU7QnT-bco_UUcXx2nTEFPR3M=zmx9i=a6vXRZyUmY6M+5vg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 9 August 2017 at 12:57, Christopher Li <sparse@chrisli.org> wrote:
> Can you do a "ldd test-inspect"?
>
> Which version of Ubuntu are you using? I think I need to get one of those to
> test it.
>

I am using ubuntu 16.04 LTS.

Here is the output from ldd:

ldd ./test-inspect
    linux-vdso.so.1 =>  (0x00007ffd449d2000)
    libgtk-x11-2.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libgtk-x11-2.0.so.0 (0x00007fbdf76d5000)
    libgobject-2.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0 (0x00007fbdf7482000)
    libglib-2.0.so.0 => /lib/x86_64-linux-gnu/libglib-2.0.so.0
(0x00007fbdf7170000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fbdf6da6000)
    libgdk-x11-2.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libgdk-x11-2.0.so.0 (0x00007fbdf6af1000)
    libgmodule-2.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0 (0x00007fbdf68ec000)
    libpangocairo-1.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so.0 (0x00007fbdf66df000)
    libX11.so.6 => /usr/lib/x86_64-linux-gnu/libX11.so.6 (0x00007fbdf63a5000)
    libXfixes.so.3 => /usr/lib/x86_64-linux-gnu/libXfixes.so.3
(0x00007fbdf619e000)
    libatk-1.0.so.0 => /usr/lib/x86_64-linux-gnu/libatk-1.0.so.0
(0x00007fbdf5f79000)
    libcairo.so.2 => /usr/lib/x86_64-linux-gnu/libcairo.so.2
(0x00007fbdf5c65000)
    libgdk_pixbuf-2.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0 (0x00007fbdf5a42000)
    libgio-2.0.so.0 => /usr/lib/x86_64-linux-gnu/libgio-2.0.so.0
(0x00007fbdf56ba000)
    libpangoft2-1.0.so.0 =>
/usr/lib/x86_64-linux-gnu/libpangoft2-1.0.so.0 (0x00007fbdf54a4000)
    libpango-1.0.so.0 => /usr/lib/x86_64-linux-gnu/libpango-1.0.so.0
(0x00007fbdf5257000)
    libfontconfig.so.1 => /usr/lib/x86_64-linux-gnu/libfontconfig.so.1
(0x00007fbdf5014000)
    libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fbdf4d0b000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
(0x00007fbdf4aed000)
    libffi.so.6 => /usr/lib/x86_64-linux-gnu/libffi.so.6 (0x00007fbdf48e5000)
    libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fbdf4674000)
    /lib64/ld-linux-x86-64.so.2 (0x000055ca0ccca000)
    libXrender.so.1 => /usr/lib/x86_64-linux-gnu/libXrender.so.1
(0x00007fbdf446a000)
    libXinerama.so.1 => /usr/lib/x86_64-linux-gnu/libXinerama.so.1
(0x00007fbdf4267000)
    libXi.so.6 => /usr/lib/x86_64-linux-gnu/libXi.so.6 (0x00007fbdf4057000)
    libXrandr.so.2 => /usr/lib/x86_64-linux-gnu/libXrandr.so.2
(0x00007fbdf3e4b000)
    libXcursor.so.1 => /usr/lib/x86_64-linux-gnu/libXcursor.so.1
(0x00007fbdf3c41000)
    libXcomposite.so.1 => /usr/lib/x86_64-linux-gnu/libXcomposite.so.1
(0x00007fbdf3a3e000)
    libXdamage.so.1 => /usr/lib/x86_64-linux-gnu/libXdamage.so.1
(0x00007fbdf383a000)
    libXext.so.6 => /usr/lib/x86_64-linux-gnu/libXext.so.6 (0x00007fbdf3628000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fbdf3423000)
    libfreetype.so.6 => /usr/lib/x86_64-linux-gnu/libfreetype.so.6
(0x00007fbdf3179000)
    libxcb.so.1 => /usr/lib/x86_64-linux-gnu/libxcb.so.1 (0x00007fbdf2f57000)
    libpixman-1.so.0 => /usr/lib/x86_64-linux-gnu/libpixman-1.so.0
(0x00007fbdf2cae000)
    libpng12.so.0 => /lib/x86_64-linux-gnu/libpng12.so.0 (0x00007fbdf2a89000)
    libxcb-shm.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-shm.so.0
(0x00007fbdf2885000)
    libxcb-render.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-render.so.0
(0x00007fbdf267a000)
    libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fbdf2460000)
    librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fbdf2258000)
    libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1
(0x00007fbdf2035000)
    libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007fbdf1e1a000)
    libharfbuzz.so.0 => /usr/lib/x86_64-linux-gnu/libharfbuzz.so.0
(0x00007fbdf1bbc000)
    libthai.so.0 => /usr/lib/x86_64-linux-gnu/libthai.so.0 (0x00007fbdf19b2000)
    libexpat.so.1 => /lib/x86_64-linux-gnu/libexpat.so.1 (0x00007fbdf1789000)
    libXau.so.6 => /usr/lib/x86_64-linux-gnu/libXau.so.6 (0x00007fbdf1584000)
    libXdmcp.so.6 => /usr/lib/x86_64-linux-gnu/libXdmcp.so.6
(0x00007fbdf137e000)
    libgraphite2.so.3 => /usr/lib/x86_64-linux-gnu/libgraphite2.so.3
(0x00007fbdf1158000)
    libdatrie.so.1 => /usr/lib/x86_64-linux-gnu/libdatrie.so.1
(0x00007fbdf0f50000)
