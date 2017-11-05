From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Sun, 5 Nov 2017 17:52:40 +0100
Message-ID: <CAExDi1ST5ddB5Ti4rTOCdXsihc=xsuZ6riPAqvFCotrNmjUrUQ@mail.gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com> <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
 <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:43081 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdKEQwm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:52:42 -0500
Received: by mail-it0-f42.google.com with SMTP id k70so2091832itk.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:52:41 -0800 (PST)
In-Reply-To: <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sun, Sep 17, 2017 at 9:02 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Sep 17, 2017 at 1:59 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> I can confirm this patchfix works well on my slightly more complicated
>> codebase that was encountering this bug.
>
> Good.
> Thanks for the extra testing.

This is 7 weeks old now. Given the lack of reaction from the maintainer
I've now pushed this to my dev tree at:
  git://github.com/lucvoo/sparse-dev.git master


-- Luc Van Oostenryck
