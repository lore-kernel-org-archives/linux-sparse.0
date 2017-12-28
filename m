From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 21:20:41 +0000
Message-ID: <CACXZuxdphqLErKYwxwK=EDuNGO=r2UMttOLRQ7RxhS=pWMYVNw@mail.gmail.com>
References: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
 <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com> <20171228211911.4mkylgyk44ymtyna@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:37048 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdL1VUm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 16:20:42 -0500
Received: by mail-vk0-f41.google.com with SMTP id n2so19979836vkf.4
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 13:20:42 -0800 (PST)
In-Reply-To: <20171228211911.4mkylgyk44ymtyna@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 December 2017 at 21:19, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Dec 28, 2017 at 09:02:27PM +0000, Dibyendu Majumdar wrote:
>> Previous thread on this issue:
>>
>> https://www.spinics.net/lists/linux-sparse/msg05427.html
>
> Ah yes, sorry, I forgot you already specifically reported this one.
>
> It should be fixed now.
>

Well last time I thought the view was that a fix was not needed? What's changed?

Regards
Dibyendu
