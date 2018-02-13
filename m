From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Tue, 13 Feb 2018 15:49:56 -0800
Message-ID: <CANeU7QkhZix7xj4_pskyPUXSsSLX1qpXU98rJTf1BBBbxvCnXg@mail.gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com> <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
 <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
 <CAExDi1ST5ddB5Ti4rTOCdXsihc=xsuZ6riPAqvFCotrNmjUrUQ@mail.gmail.com>
 <CAHmME9qREfXRQb3ORwd7nyN2E-OTANRKpyirc6FkMON6T8fLOw@mail.gmail.com> <20180210200237.a4xmiyppshy5bbbk@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:38953 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966228AbeBMXt6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:58 -0500
Received: by mail-qk0-f173.google.com with SMTP id z197so7739740qkb.6
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:49:57 -0800 (PST)
In-Reply-To: <20180210200237.a4xmiyppshy5bbbk@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 10, 2018 at 12:02 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 02:23:11PM +0100, Jason A. Donenfeld wrote:
>> Any chance of this getting merged into the real sparse tree?
>>
>> Jason
>
> Chris,
>
> Can you please take a look at this one, please?

Hi, I take a look at this series. It is this series, right?

https://patchwork.kernel.org/patch/9954727/

It looks fine to me. I do want to apply them.

Do you want to make this 2 patch series pullable from master
or I just apply them as patch?

Chris
