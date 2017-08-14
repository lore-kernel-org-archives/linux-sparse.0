From: Christopher Li <sparse@chrisli.org>
Subject: Re: Adding an option to sparse to disable the IR simplifications
Date: Mon, 14 Aug 2017 13:09:46 -0400
Message-ID: <CANeU7Qnxiz1x_VRRyYiN1PYXeB1zoH8-Qo3T8c0SWQ7HzhN88g@mail.gmail.com>
References: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
 <CACXZuxdoLAW4rtk=zgwor9hVj8cxZ5GwSKGMSQUis_eWRiQ4GA@mail.gmail.com>
 <CACXZuxeyNL_OE0geog_TJPGtWj5TCP2CyX5UHeKxERvzsthbBw@mail.gmail.com>
 <CAExDi1S+g2AVH-wn4zAG1OiQPZKCb7x2kuSvD=-niPO1Yivhqw@mail.gmail.com> <CACXZuxfND-vZ7zT9qN3q-ghckQByx_FFBOwykxL3Ff_skqSvEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:32777 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdHNRJr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 13:09:47 -0400
Received: by mail-yw0-f175.google.com with SMTP id p68so58709311ywg.0
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 10:09:47 -0700 (PDT)
In-Reply-To: <CACXZuxfND-vZ7zT9qN3q-ghckQByx_FFBOwykxL3Ff_skqSvEQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 14, 2017 at 12:59 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> We can perhaps also move towards a granular level of control as in gcc
> or clang - i.e. enable or disable specific simplifications.
>

Yes,  we can also do that. I I think the the back end should have some way
to control what kind of the optimization it want and what level it want etc.

I plan to release 0.5.1 finial on Wednesday. Then the merge windows is
open again. We can start to work on getting the IR right, getting SSA right etc.
I also have some patch want to merged as well like the ptrlist ref count.

It can even have a post release branch for experiment. After release
this branch will merge back to master.


Chris
