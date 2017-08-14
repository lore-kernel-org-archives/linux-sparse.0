From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Fwd: Adding an option to sparse to disable the IR simplifications
Date: Mon, 14 Aug 2017 17:38:31 +0100
Message-ID: <CACXZuxeyNL_OE0geog_TJPGtWj5TCP2CyX5UHeKxERvzsthbBw@mail.gmail.com>
References: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
 <CACXZuxdoLAW4rtk=zgwor9hVj8cxZ5GwSKGMSQUis_eWRiQ4GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34813 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdHNQif (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 12:38:35 -0400
Received: by mail-vk0-f50.google.com with SMTP id n125so33334186vke.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 09:38:34 -0700 (PDT)
In-Reply-To: <CACXZuxdoLAW4rtk=zgwor9hVj8cxZ5GwSKGMSQUis_eWRiQ4GA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hi,

I suggested a while back that it might be useful to add an option to
control the simplifications.

In dmrC the simplification phase is turned off by default. But if you
supply -O1 option then it is turned on. This ensures that  I can test
both the unsimplified and simplified versions.


Regards
Dibyendu

---------- Forwarded message ----------
From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Date: 22 March 2017 at 20:53
Subject: Re: Adding an option to sparse to disable the IR simplifications
To: Linux-Sparse <linux-sparse@vger.kernel.org>


On 22 March 2017 at 19:56, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> With the progress made with spars-llvm in recent weeks we are now
> beginning to hit bugs in the simplifications carried out by the
> linearizer. So it is useful I think to have an ability to turn off
> these modifications - perhaps by a command line argument. This will
> enable testing of sparse-llvm with and without the simplifications,
> and help identify issues caused by the latter phase.
>

It appears that there is already an optimize flag that is set by -O
option. Perhaps this flag can be utilized to control the level of
simplifications attempted.

Thanks and Regards
Dibyendu
