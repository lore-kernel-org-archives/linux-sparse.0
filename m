From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Adding an option to sparse to disable the IR simplifications
Date: Mon, 14 Aug 2017 17:59:36 +0100
Message-ID: <CACXZuxfND-vZ7zT9qN3q-ghckQByx_FFBOwykxL3Ff_skqSvEQ@mail.gmail.com>
References: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
 <CACXZuxdoLAW4rtk=zgwor9hVj8cxZ5GwSKGMSQUis_eWRiQ4GA@mail.gmail.com>
 <CACXZuxeyNL_OE0geog_TJPGtWj5TCP2CyX5UHeKxERvzsthbBw@mail.gmail.com> <CAExDi1S+g2AVH-wn4zAG1OiQPZKCb7x2kuSvD=-niPO1Yivhqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36850 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdHNQ7i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 12:59:38 -0400
Received: by mail-vk0-f51.google.com with SMTP id u133so33369189vke.3
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 09:59:37 -0700 (PDT)
In-Reply-To: <CAExDi1S+g2AVH-wn4zAG1OiQPZKCb7x2kuSvD=-niPO1Yivhqw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On 14 August 2017 at 17:46, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 6:38 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I suggested a while back that it might be useful to add an option to
>> control the simplifications.
>>
>> In dmrC the simplification phase is turned off by default. But if you
>> supply -O1 option then it is turned on. This ensures that  I can test
>> both the unsimplified and simplified versions.
>
> Yes, it's something that more useful now than it was months ago.
> I think I'll first move some code around though.
>

We can perhaps also move towards a granular level of control as in gcc
or clang - i.e. enable or disable specific simplifications.

Regards
Dibyendu
