From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 21:44:25 +0000
Message-ID: <CACXZuxdxdAybNJr6jzj2B02TWTw3PsZbV7YjSmE1CgQ1yzSm9A@mail.gmail.com>
References: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
 <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com>
 <20171228211911.4mkylgyk44ymtyna@ltop.local> <CACXZuxdphqLErKYwxwK=EDuNGO=r2UMttOLRQ7RxhS=pWMYVNw@mail.gmail.com>
 <20171228214008.o7vwji7oldjwqzfj@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:40725 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1Vo0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 16:44:26 -0500
Received: by mail-vk0-f43.google.com with SMTP id w75so24116946vkd.7
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 13:44:26 -0800 (PST)
In-Reply-To: <20171228214008.o7vwji7oldjwqzfj@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 December 2017 at 21:40, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Dec 28, 2017 at 09:20:41PM +0000, Dibyendu Majumdar wrote:
>> On 28 December 2017 at 21:19, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> > On Thu, Dec 28, 2017 at 09:02:27PM +0000, Dibyendu Majumdar wrote:
>> >> Previous thread on this issue:
>> >>
>> >> https://www.spinics.net/lists/linux-sparse/msg05427.html
>> >
>> > Ah yes, sorry, I forgot you already specifically reported this one.
>> >
>> > It should be fixed now.
>> >
>>
>> Well last time I thought the view was that a fix was not needed? What's changed?
>
> Another case which led to a better understanding of the situation.
>

I understood that the correct solution was for the symbol to hold the size.

https://www.spinics.net/lists/linux-sparse/msg05442.html
https://www.spinics.net/lists/linux-sparse/msg05444.html


Regards
Dibyendu
